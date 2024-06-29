type HeaderProps = {
  headerText: string;
};
export const Header = ({ headerText }: HeaderProps) => {
  return (
    <div>
      <pre>{headerText}</pre>
    </div>
  );
};
