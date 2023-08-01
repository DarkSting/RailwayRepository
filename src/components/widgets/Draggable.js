import { Train } from '@mui/icons-material';
import { Paper, Typography } from '@mui/material';
import React, { useState } from 'react';

const DraggableItem = ({ data ,fileName,displayBody,width,header,color}) => {

  const [dragging, setDragging] = useState(false);

  const handleDragStart = (e) => {

    if(data==null){
      return;
    }

    setDragging(true);
    e.dataTransfer.setData(fileName, JSON.stringify(data));
  };

  const handleDragEnd = () => {
    setDragging(false);
  };

  return (
    <Paper elevation={2} sx={{border:'none',outline:'none',display:'flex',flexDirection:'column',alignItems:'flex-start',padding:'10px',width:width}}
      draggable
      onDragStart={handleDragStart}
      onDragEnd={handleDragEnd}
      
    >
      <Typography variant='subtitle1' sx={{marginBottom:'5px',fontWeight:'bold',color:color}}>{header}</Typography>
      
      {displayBody}
    </Paper>
  );
};

export default DraggableItem;
