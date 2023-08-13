const mongoose = require("mongoose");
const {seatSchema} = require('./SeatModel');

const bookingSchema = new mongoose.Schema({
  refNo: {
    type: Number
  },
  isPaid: {
    type: Boolean,
    default:false
  },
  totalPrice:{
    type:Number,
  },
  bookedDate:{
    type:Date,
    default:Date.now
  },
  userID:{
    type:mongoose.Schema.Types.ObjectId,
    ref:'users'
  },
  bookedSeats:{
    type:[String],
    required:[true ,'seats not provided']
  },

});


const BookingModel = mongoose.model("bookings", bookingSchema);

module.exports = {BookingModel};

