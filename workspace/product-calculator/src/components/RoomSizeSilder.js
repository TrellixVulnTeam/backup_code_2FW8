import React from "react"
import { Paper, Slider, makeStyles, TextField } from "@material-ui/core"
import { CropFree } from '@material-ui/icons';


const useStyles = makeStyles(theme => ({
  root: {
    padding: ".2em .5em",
    display: 'flex',
    justifyContent: 'sapce-around',
    alignItems: 'center',
    "& > *": {
      marginLeft: 12,
      marginRight: 12,
    }
  }
}));

function RoomSizeSilder(props) {
  const { value, onChange } = props;
  
  const classes = useStyles();
  const handleChange = (e, value) => {
    if (!!onChange) {
      onChange(value)
    }
  }
  return (
    <Paper className={classes.root}>
      <CropFree />
      <Slider min={0} max={10000} value={value} onChange={handleChange} aria-labelledby="continuous-slider" />
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
        value={value}
        margin="normal"
        variant="outlined"
      />
      <span>m2</span>
    </Paper>
  )
}

export default RoomSizeSilder;