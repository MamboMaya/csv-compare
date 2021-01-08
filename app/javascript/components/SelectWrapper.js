import React, { useState } from 'react';
import { FormControl, InputLabel, MenuItem, Select } from '@material-ui/core';

export default function SelectWrapper({ handleConcern }) {
  const [concern, setConcern] = useState('');

  return(
    <div className="select-wrapper">
      <FormControl>
        <InputLabel id="concern-label">Concern</InputLabel>
        <Select
          labelId="concern-label"
          id="concern-select"
          value={concern}
          onChange={e => {
            setConcern(e.target.value);
            handleConcern(e.target.value)
          }}
        >
          <MenuItem value=""><em>None</em></MenuItem>
          <MenuItem value={'channel_ownership'}>Channel Ownership</MenuItem>
          <MenuItem value={'subscriber_count'}>Subscriber Count</MenuItem>
        </Select>
      </FormControl>
    </div>
  )
}
