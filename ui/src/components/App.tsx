import { useState } from "react";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { isEnvBrowser } from "../utils/misc";
import { PlayerContext } from "../contexts/PlayerContext";
import Container from "./container/Container";
import useMockPlayerData from "../mocks/PlayerDataMock";

import "./App.css";
import { fetchNui } from "../utils/fetchNui";

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
  const [player, setPlayer] = useState<IPlayer>({} as IPlayer);

  useNuiEvent<IPlayer>("loadCriminalRecords", (data) => {
    console.log("loadCriminalRecords", data);    
    setPlayer(data);
  });

  return (
    <PlayerContext.Provider value={player}>
      <div className="nuiWrapper">
        <Container />
      </div>
    </PlayerContext.Provider>
  );
}
