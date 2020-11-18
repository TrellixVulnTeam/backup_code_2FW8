import React from "react";
import { render } from "react-dom";
import FlagComponent from "../../src";

const App = () => {
  return <FlagComponent />;
};
render(<App />, document.getElementById('root'));