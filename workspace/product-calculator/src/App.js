import React, { useState } from 'react';
import './App.css';
import RoomSizeSilder from './components/RoomSizeSilder';
import UnitInput from "./components/UnitInput";
import { makeStyles, Grid } from '@material-ui/core';

const useStyles = makeStyles(theme => ({
  root: {
    padding: "1em 2em"
  },
  grid: {

  }
}));

function App() {
  const [roomSizeValue, setRoomSizeValue] = useState(0);
  const classes = useStyles();
  return (
    <main className={classes.root}>
      <Grid container xs={12} spacing={2}>
        <Grid item xs={12}>
          <RoomSizeSilder value={roomSizeValue} onChange={setRoomSizeValue} />
        </Grid>
        <Grid item xs={6}>
          <UnitInput unit="有保温层每平配比(w)" />
        </Grid>
        <Grid item xs={6}>
          <UnitInput unit="无保温层每平配比(w)" />
        </Grid>
      </Grid>
    </main>
  );
}

export default App;
