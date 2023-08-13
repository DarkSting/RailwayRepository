const { RouteModel } = require("../Models/RouteModel");


/**
 * 
 * METHOD : POST
 * DESC : creating routes for trains
 * ROUTE :
 */
const createRoute = async(req,res)=>{

    const{routeNumber,starting,destination,Stops} = req.body;

    

    if(!routeNumber || !Stops){
        return res.status(200).json({code:500,data:"please provide all details"})
    }

    let min = Math.sqrt((Stops[0].longitude)^2 + (Stops[0].latitude)^2);

    let endPoint = destination?destination:Stops[0].stationName;
    let startPoint = starting?starting:Stops[0].stationName;

    let List = {};

    let max = 0.0;

    let stationIds =[]

    if(starting=="" || destination==""){

        for(let currentstop of Stops){
           
            let hypo = Math.sqrt(((currentstop.longitude)^2 + (currentstop.latitude)^2));
            
            if(max<hypo){
                endPoint = currentstop.stationName;
                
            }
            
        }
    
       
        for(let currentstop of Stops){
    
            let hypo = Math.sqrt(((currentstop.longitude)^2 + (currentstop.latitude)^2));
           stationIds.push(currentstop._id);
         
            if(min>hypo){
                
                startPoint = currentstop.stationName;
                
            }
            
        }
    }
    console.log(req.body)

   
    const newPoint =  new RouteModel({
        routeNumber:routeNumber,
        startPoint:startPoint,
        endPoint:endPoint,
        Stops:Stops
    })

    try{
        const createdmodel = await newPoint.save();
        return res.status(201).json({code:201,data:createdmodel});

    }catch(e){
        return res.status(500).json(e);
    }
    

}


/**
 * 
 * METHOD : GET
 * DESC : getting routes for trains
 * ROUTE :
 */

const getRoute = async(req,res)=>{


    console.log('route api is working')
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

const getRoutes = async(req,res)=>{

        const foundRoutes = await RouteModel.find({});
        if(foundRoutes){
            return res.status(200).json({code:200,data:foundRoutes});
        }

        return res.status(500).json({code:500,data:"not found the train"});
   

}

module.exports={
    createRoute,getRoute,
    getRoutes
}