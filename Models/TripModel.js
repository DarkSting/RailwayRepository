const mongoose = require('mongoose');
const { stationSchema } = require('./StationModel');
const { Date } = require('mongoose/lib/schema/index');

const TripSchema = new mongoose.Schema({

    train:{
        type:String,
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
    bookingOpened:{
        type:Date,
        default:Date.now

    },
    bookingOpeningExpired:{
        type:Date,
        required:[true, 'provide expiry date']
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
    isOpened:{
        type:Boolean,
        default:true
    }
 

})

const tripModel = mongoose.model('trips',TripSchema);

module.exports = {tripModel};