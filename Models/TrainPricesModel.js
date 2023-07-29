const mongoose = require('mongoose');


const trainPriceSchema = new mongoose.Schema({

    a1:{
        type:Number,
        default:200
    },
    c1:{
        type:Number,
        default:100
    },
    s1:{
        type:Number,
        default:50
    },
    trainRef:{
        required:[true,'train box reference not provided'],
        type:mongoose.Schema.Types.ObjectId,
        unique:[true,'cannot have two model for same train']
        
    }

});


const TrainPriceModel = mongoose.model('trainprices',trainPriceSchema);

module.exports ={TrainPriceModel};