const mongoose = require("mongoose");
const{seatSchema,seatModel} = require('./SeatModel');

//train schema 
const TrainSchema = new mongoose.Schema({
  name: {
    type: String,
  },
  trainNumber:{
    type:Number,
    required:[true,'provide number']
  },
  startpoint: {
    type: String,
    maxlength: 100,
  },
  destination:{
    type: String,
    maxlength: 100,
  },
  trainBoxes:[{
    type:mongoose.Schema.Types.ObjectId,
    required:[true],
    ref:'trainboxes'
  }]
  ,
  totalSeats:{
    type:Number,
    default:0
  
  }
});

//model for train box
const TrainBoxSchema = new mongoose.Schema({

  trainBoxNumber:{
    type:Number,
    required:[true,'trainbox id not supplied']
  },
  capacity:{
    type:Number,
    default:0
  },
  seats:{
    type:[Boolean]
  }
  ,
  classOfBox:{
    type:String
  }

})

//before save the train into the database this will assign the total number of seats to the model




//static methods for database to add seats to the train
TrainSchema.statics.addSeats = async function (seatNumber,seatOccupied,seatType,
  createdAt){

}

 const trainModel=mongoose.model("train", TrainSchema);
const trainBoxModel = mongoose.model("trainboxes",TrainBoxSchema);


 module.exports = {
  trainModel,
  trainBoxModel
 }
