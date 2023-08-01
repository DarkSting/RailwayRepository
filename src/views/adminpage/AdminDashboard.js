import React, { useState } from "react"
import Navbar from "../../components/Navbar"
import Sidebar from "../../components/Sidebar"
import Feed from "../../components/Feed"


//mui stuff

import { createTheme, Stack, Box, ThemeProvider, Grid } from "@mui/material"
import { Outlet } from "@mui/icons-material"



const Dashboard = () => {
  const [mode, setMode] = useState("light")
  const toogleThemeMode = () => setMode(mode === "light" ? "dark" : "light")

  const theme = createTheme({
    palette: {
      mode,
    },
  })

  return (
    <ThemeProvider theme={theme}>
      <Box bgcolor={"background.default"} color={"text.primary"}>
        <Navbar />
    
        <Box sx={{flexDirection:"row"}}>
          <Sidebar toogleThemeMode={toogleThemeMode} themeMode={mode} />
                <Outlet />
        </Box>    
            
               
           
      </Box>
    </ThemeProvider>
  )
}

export default Dashboard