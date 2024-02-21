export default function useMockPlayerData(): IPlayer {
  return {
    id: "549",
    name: "Harry Plan",
    birthDay: new Date(1875, 5, 1),
    crimes: [
      {
        date: new Date(1900, 2, 19, 10, 0, 0),
        level: 1,
        description: "Arnaque vente de bois",
      },
      {
        date: new Date(1900, 2, 20, 15, 1, 0),
        level: 3,
        description: "Non respect arbre",
      },
    ],
  };
}
