import React, { useState } from 'react';
import { Input, InputLabel } from '@material-ui/core';
import IconButton from '@material-ui/core/IconButton';
import DeleteIcon from '@material-ui/icons/Delete';

export default function FileUpload({ name, remove, addFile }) {
  const [upload, setUpload] = useState();

  return(
    <div className="file-upload-wrapper">
      {/* <InputLabel htmlFor="csv-2">CSV</InputLabel> */}
      <Input
        type="file"
        name={name}
        accept=".txt"
        disableUnderline
        onChange={e => {
          setUpload(e.target?.files?.[0]);
          addFile(e.target?.files?.[0]);
        }}
      />
      <IconButton onClick={() => remove(name, upload)}>
        <DeleteIcon />
      </IconButton>
    </div>
  )
}