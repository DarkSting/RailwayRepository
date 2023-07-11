// loading necessary modules
const {trainModel} = require("../Models/TrainModel");

/*
method: GET
route : api/train/
description: returns all the trains
*/

//adding trains 
const addTrain = async(req,res)=>{

  const{
  name,
  startpoint,
  endpoint,
  price,
  seats,
  totalSeats,
trainNumber} = req.body;

  const newTrain = new trainModel({
    
    name:name,
    startpoint:startpoint,
    endpoint:endpoint,
    price:price,
    seats:seats,
    trainNumber:trainNumber

  });

  await newTrain.save().then(result=>{
    return res.status(200).json({msg:"Train added"});
  }).catch(err=>{
    return res.status(500).json(err);
  })


}

/**
MEHTOD : POST
ROUTE : api/train/putSeat 
description : put a seat to a train this will be tracked to whether
the seat is booked by a person
 */
const putSeat = async (req, res) => {

  const{
    trainNumber,
    typeNumber,
    seatNumber

  } = req.body

  const array = ["c1","a1","s1"];

  const isValid = typeNumber>array.length?false:true;

  if(isNaN(trainNumber)){
    res.status(404).json({msg:"train number not provided"})
  }

  try{
  const foundTrain = await trainModel.findOne({trainNumber:trainNumber});

  console.log(array[0])
 


  if (foundTrain) {

    let uniqueSeatNumber = seatNumber;
    let count = seatNumber;
    while (
      foundTrain.seats.find((seat) => seat.seatNumber === uniqueSeatNumber)
    ) {
      uniqueSeatNumber = seatNumber + count;
      count++;
    }

    const seatData = {
      seatNumber: uniqueSeatNumber,
      seatOccupied: false,
      seatType: isValid ? array[typeNumber] : array[2],
    };
    

    await trainModel.updateOne({trainNumber:trainNumber},
     {$push:{ "seats":seatData }} 
      );

   
  } else {
   res.status(404).json({ msg: "Train not found" });
  }
} catch (err) {
  return res.status(500).json(err);
}
};



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

module.exports = {
  putSeat
  ,getTrains, addTrain, getTrain, deleteTrain };
