const mongoose = require("mongoose");

const scheduleSchema = new mongoose.Schema({
  refNo: {
    type: String,
    ref: "train",
  },
  isPaid: {
    type: mongoose.Schema.Types.ObjectId,
    defaul:false
  },
  bookedSeats:{
    type:Number,
    required:true
  },
  totalPrice:{
    type:Number,

  }
  ,
  bookedDate:{
    type:Date.now,
  },
  bookedPerson:{
    type: mongoose.Schema.Types.ObjectId,
    ref:'users'
  }

});

module.exports = mongoose.model("bookings", scheduleSchema);
