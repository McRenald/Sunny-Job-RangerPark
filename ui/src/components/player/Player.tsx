import { useVisibility } from "../../providers/VisibilityProvider";
import { fetchNui } from "../../utils/fetchNui";
import Button from "../button/Button";
import Label from "../label/Label";
import "./Player.css";

const Player = (props: { player: IPlayer }) => {
  const visibility = useVisibility();

  const handleReloadClick = () => {
    fetchNui("sunny-job-rangerpark:nui:refresh-player");
  };

  const handleCloseClick = () => {
    visibility.setVisible(false);
  };

  return (
    <div className="nuiPlayer">
      <Label label="Nom" content={props.player.name} />
      <Label
        label="Date de naissance"
        content={props.player.birthDay?.toLocaleDateString()}
      />
      <Button content="Recharger" onClick={handleReloadClick} />
      <Button content="Fermer" onClick={handleCloseClick} />
    </div>
  );
};

export default Player;
