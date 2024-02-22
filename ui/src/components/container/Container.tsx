import { useState } from "react";
import CrimesPanel from "../crimes/CrimesPanel";
import Player from "../player/Player";
import Title from "../title/Title";
import AddCrime from "../addcrime/AddCrime";
import "./Container.css";

export default function Container({ player }: { player: IPlayer }) {
  const [showAddCrime, setShowAddCrime] = useState(false);

  const handleToggleAddCrimeClick = () => {
    setShowAddCrime(!showAddCrime)
  };

  return (
    <div className="nuiContainer">
      <Title />
      {!player && <div className="nuiLoading">Chargement en cours...</div>}
      {player && (
        <div className="nuiColumn">
          <Player player={player} onAddCrime={handleToggleAddCrimeClick} />
          <CrimesPanel crimes={player.crimes} />
        </div>
      )}
      {showAddCrime && <AddCrime player={player} onClose={handleToggleAddCrimeClick} />}
    </div>
  );
}
