import Train from "../models/Train.js";
import Ticket from "../models/Ticket.js";

export const createTrain = async (req, res, next) => {
  const newTrain = new Train(req.body);

  try {
    const savedTrain = await newTrain.save();
    res.status(200).json(savedTrain);
  } catch (err) {
    next(err);
  }
};
export const updateTrain = async (req, res, next) => {
  try {
    const updatedTrain = await Train.findByIdAndUpdate(
      req.params.id,
      { $set: req.body },
      { new: true }
    );
    res.status(200).json(updatedTrain);
  } catch (err) {
    next(err);
  }
};
export const deleteTrain = async (req, res, next) => {
  try {
    await Train.findByIdAndDelete(req.params.id);
    res.status(200).json("Train has been deleted.");
  } catch (err) {
    next(err);
  }
};
export const getTrain = async (req, res, next) => {
  try {
    const train = await Train.findById(req.params.id);
    res.status(200).json(train);
  } catch (err) {
    next(err);
  }
};
export const getTrains = async (req, res, next) => {
  const { min, max, ...others } = req.query;
  try {
    const trains = await Train.find({
      ...others,
      cheapestprice: { $gt: min | 1, $lt: max || 999 },
    }).limit(req.query.limit);
    res.status(200).json(trains);
  } catch (err) {
    next(err);
  }
};
export const countByCity = async (req, res, next) => {
  const cities = req.query.cities.split(",");
  try {
    const list = await Promise.all(
      cities.map((city) => {
        return Train.countDocuments({ city: city });
      })
    );
    res.status(200).json(list);
  } catch (err) {
    next(err);
  }
};
export const countByType = async (req, res, next) => {
  try {
    const trainCount = await Train.countDocuments({ type: "train" });
    const intercityexpresCount = await Train.countDocuments({ type: "intercityexpres" });
    const expresCount = await Train.countDocuments({ type: "expres" });
    const observationCount = await Train.countDocuments({ type: "observation" });
    const regionalCount = await Train.countDocuments({ type: "regional" });

    res.status(200).json([
      { type: "train", count: trainCount },
      { type: "intercityexpress", count: intercityexpresCount },
      { type: "expres", count: expresCount },
      { type: "observations", count: observationCount },
      { type: "regional", count: regionalCount },
    ]);
  } catch (err) {
    next(err);
  }
};

export const getTrainTickets = async (req, res, next) => {
  try {
    const train = await Train.findById(req.params.id);
    const list = await Promise.all(
      train.tickets.map((ticket) => {
        return Ticket.findById(ticket);
      })
    );
    res.status(200).json(list)
  } catch (err) {
    next(err);
  }
};