import { useEffect, useState } from "react";

export default function CrimeSummary({ crimes }: {crimes: Array<ICrime> }) {
    const [majorCrimes, setMajorCrimes] = useState<Array<ICrime>>([]);
    const [mediumCrimes, setMediumCrimes] = useState<Array<ICrime>>([]);
    const [minorCrimes, setMinorCrimes] = useState<Array<ICrime>>([]);

    useEffect(() => {
        setMajorCrimes(crimes.filter((x) => x.level == 1));
        setMediumCrimes(crimes.filter((x) => x.level == 2));
        setMinorCrimes(crimes.filter((x) => x.level == 3));
    }, [crimes]);
  return (
    <>
      <div>Nombre de crime : <span className="nuiWritten">{crimes.length}</span></div>
      <div>Nombre de crime grave : <span className="nuiWritten">{majorCrimes.length}</span></div>
      <div>Nombre de crime moyen : <span className="nuiWritten">{mediumCrimes.length}</span></div>
      <div>Nombre de crime mineur : <span className="nuiWritten">{minorCrimes.length}</span></div>
    </>
  );
}
