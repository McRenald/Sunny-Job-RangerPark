export default function useMockPlayerData(): IPlayer {
  return {
    id: "549",
    name: "Harry Plan",
    birthDay: "1875-06-01T00:00:00Z",
    crimes: [
      {
        date: "1900-02-19T10:00:00Z",
        level: 1,
        description: "Arnaque vente de bois",
      },
      {
        date: "1900-02-19T15:22:00Z",
        level: 3,
        description: "Non respect arbre",
      },
    ],
  };
}
