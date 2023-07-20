const mongoose = require('mongoose');
const { stationSchema } = require('./StationModel');


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
    createdAt:{
        type:Date,
        default:Date.now
    },
    duration:{
        type:String,
        default:""
    },
    Stops:[{
        type:mongoose.Schema.Types.ObjectId,
        ref:'stations'
    }]

})