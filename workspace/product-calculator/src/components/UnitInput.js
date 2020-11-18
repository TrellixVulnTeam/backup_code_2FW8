import React from "react";
import { Paper, TextField } from "@material-ui/core";
import { FlashOn } from "@material-ui/icons";
import { makeStyles } from "@material-ui/styles";



const useStyles = makeStyles(theme => ({
  root: {
    padding: ".2em .5em",
    display: 'flex',
    justifyContent: 'sapce-around',
    alignItems: 'center',
    "& > *": {
      marginLeft: 6,
      marginRight: 6,
    }
  }
}));


function WATTInput(props) {
  const { value, unit } = props;
  const classes = useStyles();
  return (
    <Paper className={classes.root}>
      <FlashOn />
      <TextField
        type="number"
        InputLabelProps={{
          shrink: true,
          padding: 0,
        }}
        inputProps={{
          style: {
            padding: '0 14px',
            height: '2em'
          },
        }}
        margin="normal"
        variant="outlined"
      />
      {unit && <span>{unit}</span>}
    </Paper>
  )
}

export default WATTInput;