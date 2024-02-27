import { format } from "date-fns";
import { useContext } from "react";
import { PlayerContext } from "../../contexts/PlayerContext";

export default function CrimeList() {
  const playerCtx = useContext(PlayerContext);

  return (
    <>
      <h3>Crimes</h3>
      <table className="nuiCrimesTable">
        <thead className="nuiCrimesHeader">
          <tr>
            <td className="nuiCrimesDate">Date</td>
            <td>Observations</td>
          </tr>
        </thead>
        <tbody>
          {playerCtx.crimes
            .sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime())
            .map((crime, index) => {
              return (
                <tr key={index} className="nuiWritten">
                  <td>
                    <div>{format(new Date(crime.date), "dd/MM/yyyy HH:mm")}</div>
                  </td>
                  <td>
                    <div>{crime.description}</div>
                  </td>
                </tr>
              );
            })}
        </tbody>
      </table>
    </>
  );
}
