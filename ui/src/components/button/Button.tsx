import "./Button.css";

export default function Button({ content, onClick }: { content: string, onClick: any }) {
  return (
    <>
      <button className="nuiButton" onClick={onClick}>{content}</button>
    </>
  );
}
