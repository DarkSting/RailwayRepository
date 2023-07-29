const { Date } = require('mongoose/lib/schema/index');
const {BookingModel} = require('../Models/BookingModel');
const { trainModel } = require('../Models/TrainModel');
const { TrainPriceModel } = require('../Models/TrainPricesModel');
const { bookSeat } = require('./TrainControllers');

/**.
 * 
 * METHOD
 * POST
 * DESC : creates a booking
 */

const createBooking = async(req,res)=>{

    

    const{seatIdArray,bookedPersonId,paid} = req.body;
    
    const IDs = seatIdArray[0].split(':');

    let trainId = parseInt(IDs[2]);

    let results = [];

    let train = null;
    let trainPrices = null;

    try{

    train = await trainModel.findOne({trainNumber:trainId})
    trainPrices = await TrainPriceModel.findOne({trainRef:train._id});

    }catch(e){
        return res.status(500).json("server error")
    }
   

    console.log(trainPrices);

    for(let seatId of seatIdArray){

        const result = await bookSeat(seatId);
        
        if(result?.data){
            if(result.data){
                
                const splits = seatId.split(":");
                let totalprice = trainPrices[splits[0]]
                results.push([200,totalprice]);
                
            }
            else{
                results.push([500,0])
            }
        }
    }

    let totalCost = 0;

    for(let cost of results){

        if(cost[0]==200){
            totalCost = cost[1]+totalCost;
        }
        
    }



    try{
        const response = new BookingModel({
            refNo:trainId,
            bookedSeats:seatIdArray,
            totalPrice:totalCost,
            isPaid : paid
        })

        response.save();

        return res.status(201).json("model created")
        
    }
    catch(e){
        return res.status(500).json("model not created")
    }
    
    
    
    


}


module.exports ={createBooking};