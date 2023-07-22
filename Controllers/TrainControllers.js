// loading necessary modules
const { seatModel } = require("../Models/SeatModel");
const {trainModel, trainBoxModel} = require("../Models/TrainModel");

/*
method: GET
route : train/addtrain
description: returns all the trains
*/

//adding trains 
const gettingTrainBoxArray=async(capacity)=>{

  
    let trainBoxes = [];

    for(let i=0;i<capacity;i++){

  
      if(i==0){   
          trainBoxes.push(createTrainBoxWithArray(i,10,"a1")); 
      }
      else if(i<3){
        trainBoxes.push(createTrainBoxWithArray(i,10,"c1")); 
      }
      else{
        trainBoxes.push(createTrainBoxWithArray(i,10,"s1")); 
      }
     
  
    }

    try{

      let result = await Promise.all(trainBoxes);
      console.log("tasks completed")
      return result;

    }catch(e){

      console.log(e.message);
    } 





}

const addTrain = async(req,res)=>{

  const{
  name,
  startpoint,
  endpoint,
  trainNumber} = req.body;

  let r = null;

  if(trainNumber!==undefined){
    r = await trainModel.findOne({trainNumber:trainNumber});
  }
  else{
    res.status(500).json({code:500,msg:"please provide the train number"});

  }


  let trainboxes =await gettingTrainBoxArray(5);
  
  

  const newTrain = new trainModel({
    
    name:name,
    startpoint:startpoint,
    destination:endpoint,
    trainBoxes:trainboxes,
    trainNumber:trainNumber

  });

  

  if(r?._id){
        
    trainModel.find({}).then(r=>{
      res.status(500).json({code:500,msg:"already exists",data:r})
    }).catch(er=>{
      console.log('this code hit')
      res.status(500).json({code:500,msg:"exectuion failed"});
    })
  }else{
    console.log("here im ")
    newTrain.save().then(result=>{
   res.status(200).json({msg:"Train added"});
  }).catch(err=>{
   res.status(500).json(err);
    })
  }
  



}

/**
 * decription : creats train box to be used by the trains.
 */
const createTrainBoxWithArray =  (boxid,capacity,boxClass)=>{

  
 return new Promise((resolve,reject)=>{

  let seatArray = [];

  for(let i=0;i<capacity;i++){
    seatArray.push(false);
  }

  const newBox = new trainBoxModel({
    trainBoxNumber:boxid,
    capacity:capacity,
    seats:seatArray,
    classOfBox:boxClass
  })

  newBox.save().then(r=>{
    resolve({code:200,_id:r._id});
  }).catch(er=>{
    reject({code:500,data:er.message});
  })



  })
 


}


/**
MEHTOD : POST
ROUTE : train/putSeat 
description : put a seat to a train this will be tracked to whether
the seat is booked by a person
 */
const putSeat = async (seatType) => {


  let refid =0;


  const list = await seatModel.find({}).sort({seatNumber:-1});
  
  if(list.length===0){
      refidid=1;
  }
  else{
      refid= parseInt(list[0])+1;
  }

  const newSeat = new seatModel({
    seatNumber:refid,
    seatType:seatType
  });

  newSeat.save().then(r=>{
    return {code:200,data:r._id};
  }).catch(er=>{
    return {code:500,data:er.message};
  });


};

/**
MEHTOD : POST
ROUTE : train/createtrainbox
description : create train boxes
 */

const createTrainBox = async(boxId,capacity,boxClass)=>{


let refid =0;


  const list = await trainBoxModel.find({}).sort({seatNumber:-1});
  
  if(list.length===0){
      refidid=1;
  }
  else{
      refid= parseInt(list[0])+1;
  }

  let seatArray = [];

  //creating seats
  for(let i=0;i<capacity; i++){
    let currentSeat = await putSeat(boxClass);

    if(currentSeat?.code){
      if(code===200){
        seatArray.push(currentSeat.data)
      }else{
        return {code:500,data:currentSeat.data};
      }
    }
  }

  //creating the box
  const newTrainBox = new trainBoxModel({
    trainBoxNumber:refid,
    capacity:capacity,
    seats:seatArray
  });

  newTrainBox.save().then(r=>{
    return {code:200,data:r._id};
  }).catch(er=>{
    return {code:500,data:er.message};
  });

}



const getTrains = async (req, res) => {
  await train
    .find({})
    .sort({ startDate: -1 })
    .then((trains) => {
      return res.status(200).json({
        trains,
      });
    })
    .catch((err) => res.status(500).json(err));
};

/*
method: GET
route : api/train/:id
description: returns a single train based on id
*/
const getTrain = async (req, res) => {
  const { id,name,trainNumber } = req.params;

  //validation
  if (!name) return res.status(400).json({ msg: "name not found" });

  const outTrain = await trainModel.findOne({
    $or:[{name:name},{trainNumber:trainNumber}]
  });

  if (!outTrain) return res.json({ msg: "Train Does not exist" });

  res.status(200).json({
    id: outTrain._id,
    name: outTrain.name,
    destination: outTrain.destination,
    startpoint: outTrain.startpoint,
    totalSeats:outTrain.totalSeats,
    trainBoxes: outTrain.trainBoxes,
  });
};

/*
method: DELETE
route: /api/train/
description: deletes a train based on id
*/
const deleteTrainBox = async(arrayTrainBoxes)=>{

  let array = []
  
  console.log(arrayTrainBoxes);
  for(let id of arrayTrainBoxes){
    try{

      let result = await trainBoxModel.findOneAndDelete({_id:id});
      console.log(result._id);
      if(result?._id){
        array.push(result._id);
      }
      
     
    }catch(e){
      return {code:500,msg:"failed to delete"}
    }
  }

  if(array.length>0){
    return {code:200,msg:"all train boxes are deleted"}
  }
  else{
    return {code:500,msg:"couldnt able to delete all trains"}
  }

 

}


const deleteTrain = async (req, res) => {
  const {trainNumber} = req.body;

  // validation
  if (!trainNumber) return res.status(400).json({ msg: "id not found" });

  const traindel = await trainModel.findOne({
    trainNumber:trainNumber
  });


  if (!traindel) return res.json({ msg: "Id invalid" });

  let result = await deleteTrainBox(traindel.trainBoxes);


  if(result?.code && result.code==200){
    await traindel
    .deleteOne()
    .then((train) =>
      res.status(200).json({
        train,
      })
    )
    .catch((err) => res.status(409).json({
      err,
    }));
  }

  
};

module.exports = {
  putSeat
  ,getTrains, addTrain, getTrain, deleteTrain };
