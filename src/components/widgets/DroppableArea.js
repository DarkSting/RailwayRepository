import React, { useState } from 'react';
import { Box,Typography } from '@mui/material';

const DroppableArea = ({width,props,filename,setDropableData,height,notifyUpdate, header,color,type,Snack}) => {
  
  const [droppedData, setDroppedData] = useState(null);

  const handleDragOver = (e) => {
    e.preventDefault();
  };

  const handleDrop = (e) => {
    e.preventDefault();
    try {

      if(e.dataTransfer.getData('null')==null){
        setDroppedData(null);
        return;
      }
      const droppedData = JSON.parse(e.dataTransfer.getData(filename));
      setDroppedData(droppedData);
      notifyUpdate(droppedData);
      Snack.setMsg("Action Inserted");
      Snack.setSeverity("success");
      Snack.openSnack();
    } catch (error) {
      Snack.setMsg("Action Failed");
      Snack.setSeverity("error");
      Snack.openSnack();
      
      // Handle the error, e.g., show a message to the user
    }
    
  };



  return (
    <Box
      onDragOver={handleDragOver}
      onDrop={handleDrop}
      sx={{display:'flex', justifyContent:'center',alignItems:'center',
       border:'dashed 2px black',height:height,width:width, padding:'5px'}}
    >
   
   
      {setDropableData(droppedData,header,color,type)}
    
  
    </Box>
  );
};

export default DroppableArea;
