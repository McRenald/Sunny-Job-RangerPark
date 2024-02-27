import { useContext, useState } from "react";
import { fetchNui } from "../../utils/fetchNui";
import { PlayerContext } from "../../contexts/PlayerContext";
import Button from "../button/Button";
import "./AddCrime.css";

export default function AddCrime({ onClose }: { onClose: any }) {
  const [description, setDescription] = useState("");
  const [level, setLevel] = useState(1);

  const playerCtx = useContext(PlayerContext);

  const handleOnSubmitClick = () => {
    const date = new Date();

    // DEBUG: Always add crime to player
    playerCtx.crimes.push({
      date: date.toISOString(),
      level: level,
      description: description,
    });

    // Post crime to server
    fetchNui("sunny-job-rangerpark:nui:add-criminal-record", {
      pedId: playerCtx.id,
      date: date,
      level: level,
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
        <div>
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
        </div>
        <div>
          <label>Gravité :</label>
          <br />
          <input
            type="radio"
            name="level"
            value="1"
            id="grave"
            checked={level === 1}
            onChange={(e) => setLevel(parseInt(e.target.value))}
          />
          <label htmlFor="grave">Grave</label>
          <br />
          <input
            type="radio"
            name="level"
            value="2"
            id="moyen"
            checked={level === 2}
            onChange={(e) => setLevel(parseInt(e.target.value))}
          />
          <label htmlFor="moyen">Moyen</label>
          <br />
          <input
            type="radio"
            name="level"
            value="3"
            id="mineur"
            checked={level === 3}
            onChange={(e) => setLevel(parseInt(e.target.value))}
          />
          <label htmlFor="mineur">Mineur</label>
        </div>
        <br />
        <div>
          <Button content="Ajouter" onClick={handleOnSubmitClick} />
          <Button content="Annuler" onClick={onClose} />
        </div>
      </form>
    </div>
  );
}
