import { format } from "date-fns";

export default function CrimeList({ crimes }: { crimes: Array<ICrime> }) {
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
          {crimes.map((crime, index) => {
            return (
              <tr key={index} className="nuiWritten">
                <td>
                  <div>{format(crime.date, "dd/MM/yyyy HH:mm")}</div>
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
