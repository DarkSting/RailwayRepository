const { StationModel } = require("../Models/StationModel");

const createStation = async (req, res) => {
    const {stationNumber,stationName,longitude,latitude,stationClass} = req.body;
  
    // validation
    if (!stationNumber && !stationName && !longitude && !latitude && !stationClass) return res.status(400)
    .json({ msg: "please provide all details" });
  
    const newStation = new StationModel({
        stationNumber:stationNumber,
        stationName:stationName,
        longitude:longitude,
        latitude:latitude,
        stationClass:stationClass
    });
  
    newStation.save().then(r=>{
        return res.status(201).json({code:201,msg:"station created"});
    })
    .catch(er=>{
        return res.status(500).json({code:201,msg:"model saving failed"});3
    })
  
    
  };

  const getStation = async(req,res)=>{

    const{stationName,stationNumber,objectID} = req.body;

    if(!stationName && !stationNumber && !objectID ) return res.status(500).json({code:500,msg:"provide at least one id"})

    const foundStation = await StationModel.findOne({$or:[{stationNumber:stationNumber},
        {stationName:stationName},{_id:objectID}]})

    
        if(foundStation){
            return res.status(200).json({foundStation});
        }
        else{
            return res.status(404).json({code:404,msg:"object not found"});
        }

  }

  const getStations = async(req,res)=>{


    const foundStation = await StationModel.find({})
    
        if(foundStation){
            return res.status(200).json({foundStation});
        }
        else{
            return res.status(404).json({code:404,msg:"object not found"});
        }

  }



  const addbookingsToStation = async(req,res)=>{

        const{bookings} = req.body;



  }


  module.exports = {

    createStation,
    getStations,
    getStation
  }