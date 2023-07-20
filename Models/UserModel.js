const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  name: {
    type: String,
    trim: true,
    maxlength: 50,
  },
  email: {
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

  DOB:{
    type:Date,

  },
  createdAt:{
    type:Date,


  }
});


const UserModel = mongoose.model("users", userSchema);

module.exports = {
  
  UserModel,
  userSchema

};