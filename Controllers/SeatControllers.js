// loading necessary modules
const {seatModel} = require("../Models/SeatModel");

/*
method: GET
route : api/train/
description: returns all the trains
*/

//adding trains 
const addSeat = async(req,res)=>{

  const{
    seatNumber,
    seatOccupiedt,
  endpoint,
  price,
  seats,
  totalSeats} = req.body;

  const newTrain = new trainModel({
    
    name:name,
    startpoint:startpoint,
    endpoint:endpoint,
    price:price,
    seats:seats,
    totalSeats:totalSeats

  });

  await newTrain.save().then(result=>{
    return res.status(200).json({msg:"Train added"});
  }).catch(err=>{
    return res.status(500).json(err);
  })


}

const getTrains = async (req, res) => {
  await train
    .find({})
    .sort({ startDate: -1 })
    .then((trains) => {
      return res.status(200).json({
        trains,
      });
    })
    .catch((err) => res.status(500).json(err));
};

/*
method: GET
route : api/train/:id
description: returns a single train based on id
*/
const getTrain = async (req, res) => {
  const { id,name,trainNumber } = req.params;

  //validation
  if (!name) return res.status(400).json({ msg: "name not found" });

  const outTrain = await trainModel.findOne({
    $or:[{name:name},{trainNumber:trainNumber}]
  });

  if (!outTrain) return res.json({ msg: "Train Does not exist" });

  res.status(200).json({
    id: outTrain._id,
    name: outTrain.name,
    seats: outTrain.seats,
    destination: outTrain.destination,
    startpoint: outTrain.startpoint,
    totalSeats:outTrain.totalSeats,
    price: outTrain.price,
  });
};

/*
method: DELETE
route: /api/train/
description: deletes a train based on id
*/
const deleteTrain = async (req, res) => {
  const { id, TrainNumber} = req.body;

  // validation
  if (!TrainNumber) return res.status(400).json({ msg: "id not found" });

  const traindel = await train.findOne({
    TrainNumber:TrainNumber
  });

  if (!traindel) return res.json({ msg: "Id invalid" });

  await traindel
    .deleteOne()
    .then((train) =>
      res.status(200).json({
        train,
      })
    )
    .catch((err) => res.status(409).json({
      err,
    }));
};

module.exports = { getTrains, addTrain, getTrain, deleteTrain };
