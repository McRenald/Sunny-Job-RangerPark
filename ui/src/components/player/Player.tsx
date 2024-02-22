import { useContext } from "react";
import { useVisibility } from "../../providers/VisibilityProvider";
import { fetchNui } from "../../utils/fetchNui";
import { PlayerContext } from "../../contexts/PlayerContext";
import Button from "../button/Button";
import Label from "../label/Label";
import "./Player.css";

const Player = (props: { onAddCrime: any }) => {
  const visibility = useVisibility();
  const playerCtx = useContext(PlayerContext);

  const handleReloadClick = () => {
    fetchNui("sunny-job-rangerpark:nui:refresh-player");
  };

  const handleCloseClick = () => {
    visibility.setVisible(false);
  };

  return (
    <div className="nuiPlayer">
      <Label label="Nom" content={playerCtx.name} />
      <Label
        label="Date de naissance"
        content={playerCtx.birthDay?.toLocaleDateString()}
      />
      <Button content="Recharger" onClick={handleReloadClick} />
      <Button content="Ajouter un crime" onClick={props.onAddCrime} />
      <Button content="Fermer" onClick={handleCloseClick} />
    </div>
  );
};

export default Player;
