import express from "express";
import {
    countByCity,
    countByType,
    getTrainTickets,
    createTrain,
    deleteTrain,
    getTrain,
    getTrains,
    updateTrain,
  } from "../controllers/train.js";


import Train from "../models/Train.js";
import {verifyAdmin} from "../utils/verifyToken.js"


const router = express.Router();

//CREATE
router.post("/", verifyAdmin, createTrain);

//UPDATE
router.put("/:id", verifyAdmin, updateTrain);
//DELETE
router.delete("/:id", verifyAdmin, deleteTrain);
//GET

router.get("/find/:id", getTrain);
//GET ALL



router.get("/", getTrains);
router.get("/countByCity", countByCity);
router.get("/countByType", countByType);
router.get("/ticket/:id", getTrainTickets);


export default router;