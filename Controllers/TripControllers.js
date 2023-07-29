const { RouteModel } = require("../Models/RouteModel");
const { trainModel } = require("../Models/TrainModel");
const {tripModel}= require("../Models/TripModel");


const createTrip= async(req,res)=>{

    const{trainID,routeID,departure,arrival} = req.body;

    if(!trainID && !routeID || !departure || !arrival){
        return res.status(404).json({code:404,data:"provide all necessary details"})
    }


    const foundTrain = trainModel.findOne({_id:trainID});
    const foundroute = RouteModel.findOne({_id:routeID});

    if(foundTrain && foundroute){

        const newTrip =  new tripModel({
            train:trainID,
            departure:departure,
            arrival:arrival,
            route:foundroute._id,

        })

        newTrip.save().then(r=>{
            return res.status(201).json({code:201,data:r});
        }).catch(er=>{
            return res.status(500).json({code:500,data:er.message});
        })
    }
    else{
        return res.status(404).json({code:404,data:"cannot find either the train or the route"});
    }

}

const getTrip= async(req,res)=>{

    const{tripId} = req.body;

    if(!tripId)  return res.status(404).json({code:404,data:"provide trip id"});

    try{

        const foundTrip = await tripModel.findOne({_id:tripId});

        if(foundTrip){
            return res.status(200).json({code:200,data:foundTrip});
        }
        else{
            return res.status(500).json({code:500,data:"cannot find the trip"});
        }

    }catch(e){
        return res.status(500).json({code:500,data:e.message});
    }
    

   
}

module.exports = {
    createTrip,
    getTrip

};