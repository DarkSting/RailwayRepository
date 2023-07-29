const { RouteModel } = require("../Models/RouteModel");


/**
 * 
 * METHOD : POST
 * DESC : creating routes for trains
 * ROUTE :
 */
const createRoute = async(req,res)=>{

    const{startPoint,endPoint,routeNumber,name} = req.body;

    if(!startPoint && !endPoint && !routeNumber && !name){
        return res.status(200).json({code:500,data:"please provide all details"})
    }

    const newPoint =  new RouteModel({
        routeNumber:routeNumber,
        name:name,
        startPoint:startPoint,
        endPoint:endPoint
    })

    try{
        const createdmodel = await newPoint.save();
        return res.status(201).json({code:201,data:createdmodel});

    }catch(e){
        return res.status(500).json({code:500,data:e.message});
    }
    

}


/**
 * 
 * METHOD : GET
 * DESC : getting routes for trains
 * ROUTE :
 */

const getRoute = async(req,res)=>{


    const{routeNumber,routeID} = req.body;

    if(!routeNumber && !routeID){
        return res.status(404).json({code:404,data:"provide route number or route id"})
    }

    try{
        const foundRoute = await RouteModel.findOne({$or:[{routeNumber:routeNumber},{_id:routeID}]});
        if(foundRoute){
            return res.status(200).json({code:200,data:foundRoute});
        }

        return res.status(500).json({code:500,data:"not found the train"});
    }
    catch(er){
        return res.status(500).json({code:500,data:er.message});
    }


    
   

}

module.exports={
    createRoute,getRoute
}