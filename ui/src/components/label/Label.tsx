import "./Label.css";

export default function Label({
  label,
  content,
}: {
  label: string;
  content: string;
}) {
  return (
    <div className="nuiLabel">
      <div className="nuiLabelLabel">{label} :</div>
      <div className="nuiWritten">{content}</div>
    </div>
  );
}
