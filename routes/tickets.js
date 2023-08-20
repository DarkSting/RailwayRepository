import express from "express";
import {
  createTicket,
  deleteTicket,
  getTicket,
  getTickets,
  updateTicket,
  updateTicketAvailability,
} from "../controllers/ticket.js";
import { verifyAdmin } from "../utils/verifyToken.js";

const router = express.Router();
//CREATE
router.post("/:trainid", verifyAdmin, createTicket);

//UPDATE
router.put("/availability/:id", updateTicketAvailability);
router.put("/:id", verifyAdmin, updateTicket);
//DELETE
router.delete("/:id/:trainid", verifyAdmin, deleteTicket);
//GET

router.get("/:id", getTicket);
//GET ALL

router.get("/", getTickets);

export default router;