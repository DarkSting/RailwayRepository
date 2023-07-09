const mongoose = require("mongoose");

const loyaltySchema = new mongoose.Schema({
  points: {
    type:Number,
    default:0
  },
  name: {
    type: String,
    maxlength: 100,
    unique: true,
  },
  encry_password: {
    type: String,
  },
  phone: {
    type: String,
    trim: true,
    unique: true,
  },
   nic:{
  type:String,
  required:true,
  unique:true

 },
 role:{
  type:String,
  
 },
  is_admin: {
    type: Boolean,
  },

  DOB:{
    type:Date,

  },
  createdAt:{
    type:Date,
    

  }
});

module.exports = mongoose.model("user", userSchema);
