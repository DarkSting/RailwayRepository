import Ticket from "../models/Ticket.js";
import Train from "../models/Train.js";
import { createError } from "../utils/error.js";

export const createTicket = async (req, res, next) => {
  const trainId = req.params.trainid;
  const newTicket = new Ticket(req.body);

  try {
    const savedTicket = await newTicket.save();
    try {
      await Train.findByIdAndUpdate(trainId, {
        $push: { tickets: savedTicket._id },
      });
    } catch (err) {
      next(err);
    }
    res.status(200).json(savedTicket);
  } catch (err) {
    next(err);
  }
};

export const updateTicket = async (req, res, next) => {
  try {
    const updatedTicket = await Ticket.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.status(200).json(updatedTicket);
  } catch (err) {
    next(err);
  }
};
export const updateTicketAvailability = async (req, res, next) => {
  try {
    await Ticket.updateOne(
      { "ticketNumbers._id": req.params.id },
      {
        $push: {
          "ticketNumbers.$.unavailableDates": req.body.dates
        },
      }
    );
    res.status(200).json("Ticket status has been updated.");
  } catch (err) {
    next(err);
  }
};
export const deleteTicket = async (req, res, next) => {
  const trainId = req.params.ticketid;
  try {
    await Ticket.findByIdAndDelete(req.params.id);
    try {
      await Train.findByIdAndUpdate(trainId, {
        $pull: { tickets: req.params.id },
      });
    } catch (err) {
      next(err);
    }
    res.status(200).json("Ticket has been deleted.");
  } catch (err) {
    next(err);
  }
};
export const getTicket = async (req, res, next) => {
  try {
    const ticket = await Ticket.findById(req.params.id);
    res.status(200).json(ticket);
  } catch (err) {
    next(err);
  }
};
export const getTickets = async (req, res, next) => {
  try {
    const tickets = await Ticket.find();
    res.status(200).json(tickets);
  } catch (err) {
    next(err);
  }
};