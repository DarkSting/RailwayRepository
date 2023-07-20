const mongoose = require("mongoose");
const{seatSchema,seatModel} = require('./SeatModel');

//train schema 
const TrainSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  trainNumber:{
    type:String,
    required:[true,'provide name']
  },
  startpoint: {
    type: String,
    maxlength: 100,
  },
  destination:{
    type: String,
    maxlength: 100,
  },
  price: {
    type: Number,
  },
  seats:[{
    type:mongoose.Schema.Types.ObjectId,
    required:[true],
    ref:'seats'
  }]
  ,
  totalSeats:{
    type:Number,
    default:0
  
  }
});

//before save the train into the database this will assign the total number of seats to the model
TrainSchema.post('updateOne',function(next){

  this.totalSeats = this.seats.length;
  next();
});

TrainSchema.post('save',function(next){

  this.totalSeats = this.seats.length;
  next();
});


//static methods for database to add seats to the train
TrainSchema.statics.addSeats = async function (seatNumber,seatOccupied,seatType,
  createdAt){

}

 const trainModel=mongoose.model("train", TrainSchema);



 module.exports = {
  trainModel
 }
