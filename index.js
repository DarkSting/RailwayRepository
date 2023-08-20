import express from "express";
import dotenv from "dotenv";
import mongoose from "mongoose";
import authRoute from "./routes/auth.js";
import usersRoute from "./routes/users.js";
import trainsRoute from "./routes/trains.js";
import ticketsRoute from "./routes/tickets.js";
import cookieParser from "cookie-parser";
import cors from "cors";

const app = express();
dotenv.config();
mongoose.set('strictQuery', true);

// const connect = async () =>{
//   console.log("connected to mongodb")
//   try {
//     await mongoose.connect(process.env.MONGO);
//     // const dbName = "myDatabase";
//     // const collectionName = "recipes";
//   } catch (error) {
//     throw error;
//   }
// }
const connect = async () => {
  try {
    await mongoose.connect(process.env.MONGO);
    console.log("Connected to mongoDB.");
  } catch (error) {
    throw error;
  }
};


mongoose.connection.on("disconnected", () => {
  console.log("mongoDB disconnected!");
});

//middlewares
app.use(cors());
app.use(cookieParser());
app.use(express.json());

app.use((err, req, res, next) => {
  const errorStatus = err.status || 500;
  const errorMessage = err.message || "Something went wrong!";
  return res.status(errorStatus).json({
    success: false,
    status: errorStatus,
    message: errorMessage,
    stack: err.stack,
  });
});

app.use("/api/auth", authRoute);
app.use("/api/users", usersRoute);
app.use("/api/trains", trainsRoute);
app.use("/api/tickets", ticketsRoute);


app.listen(8800, () => {
    connect();
    console.log("Connected to backend.");
  });