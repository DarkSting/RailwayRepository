import { Box } from '@mui/material';
import React from 'react';


export default function Wrap ({children, ...props }) {
  return (
    <Box  sx={{marginLeft:{md:'250px', sm:'250px' ,xs:'50px'},marginRight:'50px',marginTop:'-40px'}}>
        {children}
    </Box>
  );
};

