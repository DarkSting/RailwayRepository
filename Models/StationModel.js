const mongoose = require("mongoose");


const stationSchema = new mongoose.Schema({
  stationNumber: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "train",
  },
 location: {
    type: String,
    default:false
  },
  totalPrice:{
    type:Number,

  }
  ,
  bookedDate:{
    type:Date.now,
  },
  bookedSeats:{
    type:[seatSchema],
    required:[true ,'seats not provided']
  },
  bookedPerson:{
    type: mongoose.Schema.Types.ObjectId,
    ref:'users',
    required:[true ,'booked person not provided']
  }

});

module.exports = mongoose.model("bookings", bookingSchema);
