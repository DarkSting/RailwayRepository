import {
  BrowserRouter,
  Routes,
  Route,
} from "react-router-dom";
import Home from "./pages/home/Home";
import Train from "./pages/train/Train";
import List from "./pages/list/List";
import Login from "./pages/login/Login";


function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Home/>}/>
        <Route path="/trains" element={<List/>}/>
        <Route path="/trains/:id" element={<Train/>}/>
        <Route path="/login" element={<Login/>}/>
      </Routes>
    </BrowserRouter>
  );
}

export default App;
