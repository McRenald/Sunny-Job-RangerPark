import { useContext, useEffect, useState } from "react";
import { PlayerContext } from "../../contexts/PlayerContext";
import NoCrime from "../nocrime/NoCrime";
import CrimeSummary from "./CrimeSummary";
import CrimeList from "./CrimeList";
import "./CrimesPanel.css";

const CrimesPanel = () => {
  const [crimeCount, setCrimeCount] = useState(0);
  const playerCtx = useContext(PlayerContext);

  useEffect(() => {
    setCrimeCount(playerCtx.crimes?.length);
  }, [playerCtx]);

  return (
    <div className="nuiCrimes">
      {crimeCount ? (
        <>
          <CrimeSummary />
          <CrimeList />
        </>
      ) : (
        <NoCrime />
      )}
    </div>
  );
};

export default CrimesPanel;
