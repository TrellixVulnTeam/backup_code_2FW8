import State from "./State";

const gameState = new State({
  win: 0,
  coin: 100,
  get: 0
});
window['gs'] = gameState;
export default gameState;