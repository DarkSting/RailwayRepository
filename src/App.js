import React, { useState } from "react";
import { createTheme, Stack, Box, ThemeProvider } from "@mui/material"
import Dashboard from "./views/adminpage/AdminDashboard"
import { Route,RouterProvider,Routes, createBrowserRouter, createRoutesFromElements } from 'react-router-dom';
import Feed from "./components/Feed";
import TripPage from "./views/adminpage/TripPage/TripPage";


const router = createBrowserRouter(

  createRoutesFromElements(

    <Route>
         
         <Route path="/" element={ <Feed />} />
          <Route path="trains" element={<TripPage />} />
          <Route path="settrip" element={<Feed />} />
          <Route path="addtrains" element={<Feed />} />
     
    
    </Route>
  

        
  )

)


const App = () => {
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
        <Dashboard />
      </Box>
      <RouterProvider router={router}/>
    </ThemeProvider>
  )
}

export default App
