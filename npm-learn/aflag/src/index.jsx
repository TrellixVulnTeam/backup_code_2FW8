import React from "react";
import "./index.scss";
import logo from "./flag.jpg";

export default function Flag() {
  return (
    <div className="box"> 
      <img src={logo} />
    </div>
  )
}