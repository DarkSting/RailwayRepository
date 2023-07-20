const mongoose = require('mongoose');

const Enums = ["online","cash"]

const paymentSchema = new mongoose.Schema({

    bookingId:{
        type:mongoose.Schema.Types.ObjectId,
        required:[true,'id not provided'],
        ref:'bookings'
    },
    payedDate:{
        type:Date,
        required:[true,'date not provided']
    },
    createdDate:{
        type:Date,
        default:Date.now

    },
    paymentMethod:{
        type:String,
        validate:{
            validator:function(value){
                return Enums.includes(value)
            },
            message:"invalid payment method"
        },
        required:[true,'payment method required']

    }

});

const PaymentModel = mongoose.model('payments',paymentSchema);

module.exports = {PaymentModel}

