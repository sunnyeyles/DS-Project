type StickyNoteProps = {
  messageBody: string;
};
export const StickyNote = ({ messageBody }: StickyNoteProps) => {
  return (
    <div className="note">
      <p>{messageBody}</p>
    </div>
  );
};
