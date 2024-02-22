import "./Button.css";

export default function Button({
  content,
  onClick,
  className
}: {
  content: string;
  onClick: any;
  className?: string
}) {
  let classNames = "nuiButton "
  if (className)
    classNames += className

  return (
    <button type="button" className={classNames} onClick={onClick}>
      {content}
    </button>
  );
}
