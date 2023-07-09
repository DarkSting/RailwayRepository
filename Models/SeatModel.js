const mongoose = require("mongoose");

const seatSchema = new mongoose.Schema({
  seatNumber: {
    type: Number,
    required:[true,'seat number provided']
    
  },
  seatOccupied: {
    type: Boolean,
    required:[true,'seat state not provided']
  },
  seatType:{
    type:String,
    required:[true,'seat type not provided']
  }
  ,
  createdAt:{
    type:Date,
    

  }
});

const seatModel = mongoose.model("user", seatSchema);

module.exports = {

    seatModel,
    seatSchema
}
