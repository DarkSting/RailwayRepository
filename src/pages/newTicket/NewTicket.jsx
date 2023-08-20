import "./newTicket.scss";
import Sidebar from "../../components/sidebar/Sidebar";
import Navbar from "../../components/navbar/Navbar";
import DriveFolderUploadOutlinedIcon from "@mui/icons-material/DriveFolderUploadOutlined";
import { useState } from "react";
import { ticketInputs } from "../../formSource";
import useFetch from "../../hooks/useFetch";
import axios from "axios";

const NewTicket = () => {
  const [info, setInfo] = useState({});
  const [trainId, setTrainId] = useState(undefined);
  const [tickets, setTickets] = useState([]);

  const { data, loading, error } = useFetch("/trains");

  const handleChange = (e) => {
    setInfo((prev) => ({ ...prev, [e.target.id]: e.target.value }));
  };

  const handleClick = async (e) => {
    e.preventDefault();
    const ticketNumbers = tickets.split(",").map((ticket) => ({ number: ticket }));
    try {
      await axios.post(`/tickets/${trainId}`, { ...info, ticketNumbers });
    } catch (err) {
      console.log(err);
    }
  };

  console.log(info)
  return (
    <div className="new">
      <Sidebar />
      <div className="newContainer">
        <Navbar />
        <div className="top">
          <h1>Add New Ticket</h1>
        </div>
        <div className="bottom">
          <div className="right">
            <form>
              {ticketInputs.map((input) => (
                <div className="formInput" key={input.id}>
                  <label>{input.label}</label>
                  <input
                    id={input.id}
                    type={input.type}
                    placeholder={input.placeholder}
                    onChange={handleChange}
                  />
                </div>
              ))}
              <div className="formInput">
                <label>Tickets</label>
                <textarea
                  onChange={(e) => setTickets(e.target.value)}
                  placeholder="give comma between ticket numbers."
                />
              </div>
              <div className="formInput">
                <label>Choose a train</label>
                <select
                  id="trainId"
                  onChange={(e) => setTrainId(e.target.value)}
                >
                  {loading
                    ? "loading"
                    : data &&
                      data.map((train) => (
                        <option key={train._id} value={train._id}>{train.name}</option>
                      ))}
                </select>
              </div>
              <button onClick={handleClick}>Send</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  );
};

export default NewTicket;
