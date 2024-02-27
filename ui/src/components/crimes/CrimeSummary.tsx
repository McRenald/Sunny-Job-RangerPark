import { useContext, useEffect, useState } from "react";
import { PlayerContext } from "../../contexts/PlayerContext";

export default function CrimeSummary() {
  const [majorCrimes, setMajorCrimes] = useState<Array<ICrime>>([]);
  const [mediumCrimes, setMediumCrimes] = useState<Array<ICrime>>([]);
  const [minorCrimes, setMinorCrimes] = useState<Array<ICrime>>([]);

  const playerCtx = useContext(PlayerContext);

  useEffect(() => {
    setMajorCrimes(playerCtx.crimes.filter((x) => x.level == 1));
    setMediumCrimes(playerCtx.crimes.filter((x) => x.level == 2));
    setMinorCrimes(playerCtx.crimes.filter((x) => x.level == 3));
  }, [playerCtx]);

  return (
    <>
      <div>
        Nombre de crime :{" "}
        <span className="nuiWritten">{playerCtx.crimes.length}</span>
      </div>
      <div>
        Nombre de crime grave :{" "}
        <span className="nuiWritten">{majorCrimes.length}</span>
      </div>
      <div>
        Nombre de crime moyen :{" "}
        <span className="nuiWritten">{mediumCrimes.length}</span>
      </div>
      <div>
        Nombre de crime mineur :{" "}
        <span className="nuiWritten">{minorCrimes.length}</span>
      </div>
    </>
  );
}
