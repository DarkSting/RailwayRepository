const mongoose = require('mongoose');

const locationSchema = new mongoose.Schema({

    name:{
        type:String,
        required:[true,'provide a name for the location']
    },
    long:{
        type:String,
        required:[true,'provide the long']
    }
    ,
    lat:{
        type:String,
        required:[true,'provide the lat']
    }

})

module.exports = {locationSchema};