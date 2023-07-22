const mongoose = require("mongoose");

const seatSchema = new mongoose.Schema({
  seatNumber: {
    type: Number,
    required:[true,'seat number not provided'],
    unique:[true,'provide a unique seat number']
    
  },
  seatOccupied: {
    type: Boolean,
    required:[true,'seat state not provided'],
    default:false
  },
  seatType:{
    type:String,
    required:[true,'seat type not provided'],
    enum:["c1","a1","s1"]
  }
  ,
  createdAt:{
    type:Date,
    default:Date.now
    

  },
 
});



const seatModel = mongoose.model("seats", seatSchema);

module.exports = {

    seatModel,
    seatSchema
}
