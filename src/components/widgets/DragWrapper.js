import { Box } from '@mui/material';
import React from 'react';


export default function Wrap ({children, ...props }) {
  return (
    <Box  {...props}>
        {children}
    </Box>
  );
};