const mongoose = require("mongoose");

const scheduleSchema = new mongoose.Schema({
  refNo: {
    type: String,
    unique:[true,'please provide a unique number']
  },
  
  journey:{
    type:mongoose.Schema.Types.ObjectId,
    ref:'train'
  }
  ,
  estTimeForComplete:{
    type:Number,
    required:[true,'Completion time is not provided']
  },

 createdAt:{
    type:Date.now,
  },
  
  stops:{
    type:[{
      type:mongoose.Schema.Types.ObjectId,
      required:[true,'provide stops'],
      ref:'stations'
    }]
  }

});

module.exports = mongoose.model("schedules", scheduleSchema);
