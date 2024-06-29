import "../index.css";
import { PostForm } from "../components/Form";
import { StickyNote } from "../components/StickyNote";

const messages = [
  "Hello, world!",
  "This is a simple message.",
  "I have some important information for you.",
  "Hello, world!",
];

export const Body = () => {
  return (
    <div>
      <PostForm />
      <div className="body-layout">
        {messages.map((message, index) => (
          <StickyNote key={index} messageBody={message} />
        ))}
      </div>
    </div>
  );
};
