const mongoose = require("mongoose");

const routeSchema = new mongoose.Schema({
  name: {
    type: String,

  },
  routeNumber: {
    type: String,
    trim: true,
    unique: true,
    required:[true,'route number not set up']
  },
  Stops:[{
    type:mongoose.Schema.Types.ObjectId,
    ref:'stations'
}],
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
    default:false
  },
  createdAt:{
    type:Date,
    default:Date.now


  }
});




const RouteModel = mongoose.model("routes", routeSchema);

module.exports = {
  
  RouteModel,

};