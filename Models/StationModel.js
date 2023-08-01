const mongoose = require("mongoose");

const stationEnum =["s1","c1","a1"];

const stationSchema = new mongoose.Schema({
  stationNumber: {
    type: String,
    required:[true,'station number not provided']
    
  },
  stationName:{
    type:String,
    required:[true,'station name not provided']
  },
 longitude: {
    type: String,
    default:"0"
  },
  latitude:{
    type: String,
    default:"0"
  },
  stationClass:{
    type:String,
    enum:stationEnum,
    default:stationEnum[0]
  },
  bookings:[{
      type:mongoose.Schema.Types.ObjectId,
      ref:'bookings'
    }]
  

});

const StationModel = mongoose.model("stations", stationSchema);

module.exports = {
  stationSchema,
  StationModel
}
