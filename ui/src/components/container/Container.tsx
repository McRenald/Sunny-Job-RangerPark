import { useContext, useState } from "react";
import { PlayerContext } from "../../contexts/PlayerContext";
import CrimesPanel from "../crimes/CrimesPanel";
import Player from "../player/Player";
import Title from "../title/Title";
import AddCrime from "../addcrime/AddCrime";
import "./Container.css";

export default function Container() {
  const [showAddCrime, setShowAddCrime] = useState(false);
  const playerCtx = useContext(PlayerContext);

  const handleToggleAddCrimeClick = () => {
    setShowAddCrime(!showAddCrime);
  };

  return (
    <div className="nuiContainer">
      <Title />
      {!playerCtx && <div className="nuiLoading">Chargement en cours...</div>}
      {playerCtx && (
        <div className="nuiColumn">
          <Player onAddCrime={handleToggleAddCrimeClick} />
          <CrimesPanel />
        </div>
      )}
      {showAddCrime && <AddCrime onClose={handleToggleAddCrimeClick} />}
    </div>
  );
}
