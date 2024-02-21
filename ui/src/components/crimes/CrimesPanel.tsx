import { useEffect, useState } from "react";
import NoCrime from "../nocrime/NoCrime";
import CrimeSummary from "./CrimeSummary";
import CrimeList from "./CrimeList";

import "./CrimesPanel.css";

const CrimesPanel = (props: { crimes: Array<ICrime> }) => {
  const [crimes, setCrimes] = useState<Array<ICrime>>(props.crimes ?? []);
  const [crimeCount, setCrimeCount] = useState(0);

  useEffect(() => {
    setCrimes(props.crimes ?? []);
    setCrimeCount(props.crimes?.length);
  }, [props]);

  return (
    <div className="nuiCrimes">
      {crimeCount ? (
        <>
          <CrimeSummary crimes={crimes} />
          <CrimeList crimes={crimes} />
        </>
      ) : (
        <NoCrime />
      )}
    </div>
  );
};

export default CrimesPanel;
