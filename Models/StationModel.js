const mongoose = require("mongoose");


const stationSchema = new mongoose.Schema({
  stationNumber: {
    type: String,
    required:[true,'station number not provided']
    
  },
  stationName:{
    type:String,
    required:[true,'station name not provided']
  },
 location: {
    type: String,
    default:""
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
