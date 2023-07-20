const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
  name: {
    type: String,
    trim: true,
  },
  routeNumber: {
    type: String,
    trim: true,
    unique: true,
    required:[true,'route number not set up']
  },
startPoint:{
  type:String,
  required:[true,'start point not set up']

 },
 endPoint:{
  type:String,
  require:[true,'end point not set up']
  
 },
  isClosed: {
    type: Boolean,
  },
  DOB:{
    type:Date,

  },
  createdAt:{
    type:Date,


  }
});


const UserModel = mongoose.model("routes", userSchema);

module.exports = {
  
  UserModel,
  userSchema

};