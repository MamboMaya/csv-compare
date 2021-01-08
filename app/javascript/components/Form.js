import React, { useState } from 'react';
import FileUpload from './FileUpload';
import { Button } from '@material-ui/core';
import SelectWrapper from './SelectWrapper';
import DifferencesList from './DifferencesList';

export default function Form() {
  const [inputs, setInputs] = useState(['input-0']);
  const [files, setFiles] = useState([]);
  const [differences, setDifferences] = useState(null);

  const formData = new FormData();

  function addFile(data){
    setFiles(prevState => [...prevState, data])
  }

  function handleConcern(value){
    formData.append('concern', value);
  }
  function removeItem(name, upload) {
    setInputs(inputs.filter(input => input !== name));
    setFiles(files.filter(file => file !== upload));
  }

  function submitForm(e) {
    e.preventDefault();
    files.map(item => formData.append('files[]', item))



    let options = {
      method: 'POST',
      body: formData
    }

    fetch(`http://localhost:3000/compare`, options)
      .then(res => res.json())
      .then(json => setDifferences(json.data))
  }

  return(
    <div>
      <form className="form-wrapper" onSubmit={submitForm}>
        <div className="left-50">
          {inputs.length && inputs.map((input) =>
            <FileUpload
              key={input}
              name={input}
              remove={removeItem}
              addFile={addFile}
            />
          )}
          <Button
            variant="contained"
            color="primary"
            disabled={differences?.length > 0}
            onClick={() => {
              const newInput = `input-${inputs.length}`;
              setInputs(prevState => [...prevState, newInput ]);
            }}
            >
            Add Another File
          </Button>
        </div>
        <div className="left-50">
          <SelectWrapper handleConcern={handleConcern} />
          <Button
            variant="contained"
            color="primary"
            type="submit"
            disabled={files.length < 2 || differences?.length > 0}
          >
            Compare
          </Button>
        </div>
      </form>
      <DifferencesList data={differences} />
    </div>
  )
}
