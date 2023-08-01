const mongoose = require('mongoose');
const { stationSchema } = require('./StationModel');
const { Date } = require('mongoose/lib/schema/index');

const TripSchema = new mongoose.Schema({

    train:{
        type:String,
        ref:'trains',
        required:[true,'train reference is required']
    },
    departure:{
        type:Date,
        required:[true,'departure time not provided']
    },
    arrival:{
        type:Date,
        required:[true,'arrival time not provided']
    },
    bookings:[{

        type:mongoose.Schema.Types.ObjectId,
        ref:'bookings'
        }]
    ,
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