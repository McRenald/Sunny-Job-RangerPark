import { useState } from "react";
import Button from "../button/Button";
import { fetchNui } from "../../utils/fetchNui";
import "./AddCrime.css";

export default function AddCrime({ player, onClose }: { player: IPlayer, onClose: any }) {
  const [date, _] = useState(new Date());
  const [description, setDescription] = useState("");

  const handleOnSubmitClick = () => {
    fetchNui("sunny-job-rangerpark:nui:add-criminal-record", {
      pedId: player.id,
      date: date,
      description: description,
    }).finally(() => {
      fetchNui("sunny-job-rangerpark:nui:refresh-player");
      onClose();
    });
  };

  return (
    <div className="nuiAddCrime">
      <h1>Ajouter un crime</h1>
      <form>
        <label htmlFor={description}>Observations :</label>
        <br />
        <textarea
          id={description}
          value={description}
          rows={10}
          className="nuiAddCrimeTextArea"
          onChange={(e) => {
            setDescription(e.target.value);
          }}
        />
        <div>
          <Button content="Ajouter" onClick={handleOnSubmitClick} />
          <Button content="Annuler" onClick={onClose} />
        </div>
      </form>
    </div>
  );
}
