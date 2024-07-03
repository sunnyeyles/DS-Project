resource "aws_instance" "backend_instance" {
  count           = var.instance_count
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = element(var.private_app_subnet_ids, count.index % length(var.private_app_subnet_ids))
  security_groups = [var.security_group_id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  key_name        = var.key_name

  root_block_device {
    volume_size = 100  # Increase this value as needed
  }

  user_data = <<-EOF
    #!/bin/bash

    # Log file for debugging
    exec > /var/log/user-data.log 2>&1
    set -e

    echo "Starting user-data script"

    # Function to check for network availability
    wait_for_network() {
      until ping -c1 google.com &>/dev/null; do
        echo "Waiting for network..."
        sleep 5
      done
    }

    # Wait for network to be available
    wait_for_network

    echo "Updating package information..."
    sudo apt-get update -y || { echo "Failed to update package information"; exit 1; }
    sudo apt-get upgrade -y || { echo "Failed to upgrade packages"; exit 1; }

    # Install CloudWatch Agent
    echo "Installing CloudWatch Agent..."
    wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
    sudo dpkg -i -E ./amazon-cloudwatch-agent.deb || { echo "Failed to install CloudWatch Agent"; exit 1; }

    # Create CloudWatch Agent configuration
    cat <<EOC > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
    {
      "agent": {
        "metrics_collection_interval": 60,
        "logfile": "/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log"
      },
      "metrics": {
        "namespace": "CWAgent",
        "metrics_collected": {
          "cpu": {
            "measurement": [
              "cpu_usage_idle",
              "cpu_usage_iowait",
              "cpu_usage_user",
              "cpu_usage_system"
            ],
            "totalcpu": true,
            "resources": [
              "*"
            ],
            "append_dimensions": {
              "InstanceId": "\$${aws:InstanceId}"
            }
          }
        }
      }
    }
    EOC

    sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json -s

    echo "Installing Docker..."
    sudo apt-get install -y docker.io || { echo "Failed to install Docker"; exit 1; }
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    sudo chmod 666 /var/run/docker.sock

    echo "Installing kubectl..."
    curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl || { echo "Failed to install kubectl"; exit 1; }

    echo "Installing minikube..."
    curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    chmod +x minikube
    sudo mv minikube /usr/local/bin/minikube || { echo "Failed to install minikube"; exit 1; }

    echo "Installing helm"
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash || { echo "Failed to install helm"; exit 1; }

    echo "Installing jq..."
    sudo apt-get install -y jq || { echo "Failed to install jq"; exit 1; }

    #echo "Installing AWS CLI..."
    #sudo apt-get install -y unzip || { echo "Failed to install unzip"; exit 1; }
    #curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" || { echo "Failed to download AWS CLI"; exit 1; }
    #unzip awscliv2.zip || { echo "Failed to unzip AWS CLI"; exit 1; }
    #sudo ./aws/install || { echo "Failed to install AWS CLI"; exit 1; }

    echo "Installing git..."
    sudo apt-get install -y git || { echo "Failed to install git"; exit 1; }

    echo "Cloning repo"
    git clone https://github.com/sunnyeyles/DS-Project.git /home/ubuntu/DS-Project || { echo "Err: Failed to clone repo"; exit 1; }

    # Verify the directory structure
    if [ ! -d "/home/ubuntu/DS-Project/kubernetes/HELM" ]; then
        echo "Err: HELM directory does not exist"
        exit 1
    fi

    echo "Adding public key and repository for libssl1.1"
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3B4FE6ACC0B21F32 || { echo "Failed to add public key"; exit 1; }
    sudo add-apt-repository 'deb http://archive.ubuntu.com/ubuntu bionic main' || { echo "Failed to add repository"; exit 1; }
    sudo apt-get update -y || { echo "Failed to update package information"; exit 1; }

    echo "Installing libssl1.1"
    sudo apt-get install -y libssl1.1 || { echo "Failed to install libssl1.1"; exit 1; }

    echo "Installing MongoDB client"
    wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
    sudo apt-get update -y
    sudo apt-get install -y mongodb-org-shell || { echo "Failed to install MongoDB client"; exit 1; }

    echo "Setting up Minikube to start as a non-root user"
    sudo -i -u ubuntu bash << EOF2
    cd /home/ubuntu/DS-Project/kubernetes/HELM
    alias kubectl="minikube kubectl --"
    echo "Starting minikube"
    minikube start --driver=docker --force || { echo "Failed to start Minikube"; exit 1; }
    echo "Installing the charts"
    helm install test . --values=values-dev.yaml || { echo "Failed to install dev Helm chart"; exit 1; }
    helm install prod . --values=values-prod.yaml || { echo "Failed to install prod Helm chart"; exit 1; }

    EOF2

    echo "User-data script completed"
  EOF

  tags = {
    Name = "BackendInstance${count.index + 1}"
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_secrets_manager_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          Service: "ec2.amazonaws.com"
        },
        Action: "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_agent_policy" {
  name   = "cloudwatch_agent_policy"
  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: [
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams",
          "logs:CreateLogGroup",
          "logs:DescribeLogGroups",
          "cloudwatch:PutMetricData"
        ],
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_run_instances_policy" {
  name   = "ec2_run_instances_policy"
  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Action: [
          "ec2:RunInstances",
          "ec2:DescribeInstances",
          "ec2:TerminateInstances",
          "ec2:CreateVolume",
          "ec2:AttachVolume"
        ],
        Resource: "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_cloudwatch_agent_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.cloudwatch_agent_policy.arn
}

resource "aws_iam_role_policy_attachment" "attach_ec2_run_instances_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_run_instances_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name          = "high_cpu_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "90"
  alarm_description   = "This metric monitors EC2 CPU utilization"
  actions_enabled     = true

  alarm_actions = [
    aws_sns_topic.cpu_alert.arn
  ]

  dimensions = {
    InstanceId = aws_instance.backend_instance[0].id
  }
}

resource "aws_sns_topic" "cpu_alert" {
  name = "cpu_alert"
}

resource "aws_sns_topic_subscription" "cpu_alert_email" {
  topic_arn = aws_sns_topic.cpu_alert.arn
  protocol  = "email"
  endpoint  = "s.ben@outlook.fr"
}