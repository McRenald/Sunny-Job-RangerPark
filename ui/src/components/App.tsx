import { useState } from "react";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import Container from "./container/Container";

import "./App.css";
import { isEnvBrowser } from "../utils/misc";
import useMockPlayerData from "../mocks/PlayerDataMock";

// DEBUG - TO REMOVE FOR GAME
if (isEnvBrowser()) {
  debugData([
    {
      action: "setVisible",
      data: true,
    },
  ]);
  setTimeout(() => {
    debugData([
      {
        action: "loadCriminalRecords",
        data: useMockPlayerData(),
      },
    ]);
  }, 2000);
}

export default function App() {
  const [player, setPlayer] = useState<IPlayer | any>();

  useNuiEvent<IPlayer>("loadCriminalRecords", (data) => {
    setPlayer(data);
  });

  return (
    <div className="nuiWrapper">
      <Container player={player} />
    </div>
  );
}
