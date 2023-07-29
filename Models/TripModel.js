const mongoose = require('mongoose');
const { stationSchema } = require('./StationModel');


const TripSchema = new mongoose.Schema({

    train:{
        type:String,
        ref:'trains',
        required:[true,'train reference is required']
    },
    departure:{
        type:String,
        required:[true,'departure time not provided']
    },
    arrival:{
        type:String,
        required:[true,'arrival time not provided']
    },
    createdAt:{
        type:Date,
        default:Date.now
    },
    duration:{
        type:String,
        default:""
    },
    route:{
        type:String,
        ref:'routes'
    },
    Stops:[{
        type:mongoose.Schema.Types.ObjectId,
        ref:'stations'
    }]

})

const tripModel = mongoose.model('trips',TripSchema);

module.exports = {tripModel};