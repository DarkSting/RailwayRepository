const { Date } = require('mongoose/lib/schema/index');
const {BookingModel} = require('../Models/BookingModel');
const { trainModel } = require('../Models/TrainModel');
const { TrainPriceModel } = require('../Models/TrainPricesModel');
const{tripModel}= require('../Models/TripModel')
const { bookSeat } = require('./TrainControllers');
const { StationModel } = require('../Models/StationModel');

/**.
 * 
 * METHOD
 * POST
 * DESC : creates a booking
 */

const getBookings = async(req,res)=>{

    const{userID} = req.body;

    console.log("hello buddy")
    if(!userID) return res.status(404).json({code:404,msg:"provide the user id"});

    //change this code to obtain based on the user id instead ref no
    const foundBookings = await BookingModel.find({userID:userID});

   if(foundBookings){

    if(foundBookings[0]?.refNo){
        return res.status(200).json(foundBookings);
    }
   
    return res.status(404).json({code:404, msg:"no bookings available"});

   }
   else{
    return res.status(404).json({code:404, msg:"no bookings available"});
   }

}

const calculateDistance = (lat1,lon1, lat2,lon2)=>{

    const earthRadius = 6371; // Earth's radius in kilometers

    const dLat = degreesToRadians(lat2 - lat1);
    const dLon = degreesToRadians(lon2 - lon1);

    const a =
        Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(degreesToRadians(lat1)) * Math.cos(degreesToRadians(lat2)) *
        Math.sin(dLon / 2) * Math.sin(dLon / 2);
    
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = earthRadius * c;

    console.log(distance);
    return distance.toFixed(3);

}

function degreesToRadians(degrees) {
    return degrees * (Math.PI / 180);
}

const createBooking = async(req,res)=>{

    const{seatIdArray,userID,paid,station,tripId,destinationID} = req.body;

    console.log(req.body);

    if(!seatIdArray || !userID || !station || !destinationID){

        return res.status(404).json({msg:'provide necessary details'});
    }
    
    const IDs = seatIdArray[0].split(':');

    let trainId = parseInt(IDs[2]);

    let results = [];

    let train = null;
    let trainPrices = null;
    let foundDestination=null;
    let beginStation = null;

    try{

    foundDestination = await StationModel.findOne({stationNumber:destinationID});
    beginStation = await StationModel.findOne({stationNumber:station});
    train = await trainModel.findOne({trainNumber:trainId})
    trainPrices = await TrainPriceModel.findOne({trainRef:train._id});

    
    }catch(e){
        return res.status(500).json("server error")
    }
   
    if(!trainPrices){
        return res.status(409).json("Prices are not defined for the current train");
    }

    if(!foundDestination || !beginStation){
        return res.status(404).json("provide correct station ids");
    }


    const distance = calculateDistance(foundDestination.latitude,foundDestination.longitude,beginStation.latitude,beginStation.longitude);

    console.log(foundDestination);
    console.log(beginStation);
    console.log(distance);

    for(let seatId of seatIdArray){

    
        const result = await bookSeat(seatId);
        
        if(result?.data){

            if(result.data){
                
                const splits = seatId.split(":");
                let totalprice = trainPrices[`${splits[0]}`]
                results.push([200,parseInt(totalprice*distance)]);
                
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
            userID:userID,
            isPaid : paid
        })

        response.save();

        return res.status(201).json({totalPrice:totalCost})
        
    }
    catch(e){
        return res.status(500).json("model not created")
    }
    
    
    
    


}


module.exports ={
    getBookings,
    calculateDistance,
    createBooking};