variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet1_cidr" {
  description = "Public Subnet 1"
  type        = string
  default     = "10.0.0.0/24"
}

variable "public_subnet2_cidr" {
  description = "Public Subnet 2"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet1_cidr" {
  description = "App Subnet 1"
  type        = string
  default     = "10.0.2.0/24"
}

variable "app_subnet2_cidr" {
  description = "App Subnet 2"
  type        = string
  default     = "10.0.3.0/24"
}

variable "db_subnet1_cidr" {
  description = "Database Subnet 1"
  type        = string
  default     = "10.0.4.0/24"
}

variable "db_subnet2_cidr" {
  description = "Database Subnet 2"
  type        = string
  default     = "10.0.5.0/24"
}