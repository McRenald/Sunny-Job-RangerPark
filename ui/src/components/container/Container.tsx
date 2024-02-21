import { BounceLoader } from "react-spinners";
import CrimesPanel from "../crimes/CrimesPanel";
import Player from "../player/Player";
import Title from "../title/Title";

import "./Container.css";

export default function Container({ player }: { player: IPlayer}) {
  return (
    <div className="nuiContainer">
      <Title />
      {player && (
        <div className="nuiColumn">
          <Player player={player} />
          <CrimesPanel crimes={player.crimes} />
        </div>
      )}
      {!player && (
        <div className="nuiLoading">
          Chargement en cours...
        </div>
      )}
    </div>
  );
}
