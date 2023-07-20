const mongoose = require("mongoose");
const {userSchema} = require('./UserModel')

const userSchema = new mongoose.Schema({
  person:{
    type:mongoose.Schema.Types.ObjectId,
    ref:'users',
  },
  Tire: {
    type: Number,
    required:[true,'Tire not provided']
  },
  features: {
    type: [],
    required:[true,'Subcription features should be included']
  },
  startDate: {
    type: Date,
    required:[true,'start date not provided']
  },
    expiryDate:{
  type:Date,
  required:[true,'end date  not provided']
 },
 payment:{
    type:Number,
    required:[true,'payment not provided']
 }
});

module.exports = mongoose.model("subscription", userSchema);
