// loading necessary modules
const { seatModel } = require("../Models/SeatModel");
const {trainModel, trainBoxModel} = require("../Models/TrainModel");
const { TrainPriceModel } = require("../Models/TrainPricesModel");

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
 * decription : creats train prices.
 */
const createPrice = async(req,res)=>{

  const{a1Price,c1Price,s1Price,trainNumber} = req.body;

  if(!trainNumber) return res.status(404).json({code:404,msg:"train not found"});

  if(!a1Price || !c1Price || !s1Price) return res.status(404).json({code:404,msg:"please provide all seat prices"});

  const foundTrain = await trainModel.findOne({trainNumber:trainNumber});

  if(foundTrain?._id){

    try{
      const response = new TrainPriceModel({
        trainRef:foundTrain._id,
        a1:a1Price,
        c1:c1Price,
        s1:s1Price
      }).save()
      
      return res.status(201).json({code:200,msg:"train price created"});
    }
    catch(e){
      return res.status(500).json({code:500,msg:"couldnt create the train price"});
    }
   
  

    
  }
  else{
    return res.status(404).json({code:404,msg:"train not found under the provided id"});
  }







}

 /**
  * METHOD : POST
  * DESC ; get all train boxes specifict to a train
  * ROUTE : train/gettrainboxes
  */


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

/**
 * METHOD : POST
 * DESC : getting available seats in the train to show the client
 * ROUTE ; train/getseats
 * 
 */


const getAvailableSeats = async(req,res)=>{

  const{trainNumber,destination, seatClass} = req.body;

  //check the values before continue
  if(!trainNumber && !destination && !seatClass ){
   return res.status(500).json({code:500,msg:"train number, destination, and seatClass required"});
  } 

  let foundTrains = null;

  //checks whether train is available or not
  if(trainNumber){
      
    foundTrains = await trainModel.find({trainNumber:trainNumber});


  }
  else{
    foundTrains = await trainModel.find({destination:destination});
  }

  //if available generating a seatid for the available seats
  if(foundTrains){
    let foundSeats = [];

    //iterating the trains and boxes and seats
    for(let train of foundTrains){
      for(let trainBox of train.trainBoxes){

        let foundTrainBox = await getTrainBox(trainBox);
         foundTrainBox[0].seats.forEach((isOccupied,index)=>{

          if(!isOccupied){
            let seatClass = foundTrainBox[0].classOfBox;
            let trainBoxId = foundTrainBox[0].trainBoxNumber;
            let trainId = train.trainNumber;
            let seatId = index;
            let availableSeatId = `${seatClass.trim()}:${trainBoxId.toString().trim()}:${ trainId.toString().trim()}:${seatId.toString().trim()}`  
            foundSeats.push(availableSeatId);

          }
          else{
            
          }
         
        })
        
        }
      }
     return res.status(200).json({code:200,msg:"task is completed",data:foundSeats})
    }

  else{
   return res.status(404).json({code:404,msg:"found no trains"})
  }

}

///////////////////////////////////////////////////////////////////////////////////
/**.
 * METHOD : PUT
 * DESC : updates the selected seat by the user 
 * ROUTE : train/bookseat
 */
const bookSeatsWithArray = async(req,res)=>{

  const {array} = req.body;

  const results = [];

  for(let currentVal of array){ 
    results.push(await bookSeat(currentVal));
  }

  return res.status(200).json({code:200,data:results});

}

const unBookSeatWithArray = async(req,res)=>{
  const {array} = req.body;

  const results = [];

  for(let currentVal of array){ 
    results.push(await unBookSeat(currentVal));
  }

  return res.status(200).json({code:200,data:results});
}

//unbooks a seats
const unBookSeat = async (objectID) => {
  const IDs = objectID.split(':');

  let trainBoxid = parseInt(IDs[1]);
  let trainId = parseInt(IDs[2]);
  let seatIndex = parseInt(IDs[3]);
  let seatClass = IDs[0];

  console.log(`${seatClass}:${trainBoxid}:${trainId}:${seatIndex} `)

  if (IDs.length !== 4) {
    return { code: 500, msg: "invalid input" };
  }

  let foundTrain = null;

  let arrayResults = [];

  //checks whether train is available or not
  foundTrain = await trainModel.findOne({ trainNumber: trainId });

  //if available generating a seatid for the available seats
  if (foundTrain) {
    
    //iterating the trains and boxes and seats
    for (let trainBox of foundTrain.trainBoxes) {

      let foundTrainBox = await getTrainBox(trainBox);
      let currentSeats = foundTrainBox.seats
    
      currentSeats.forEach(async(isOccupied, index) => {
        //updating the train box with the reserved seat
        
       

        if (
          index === seatIndex &&
          foundTrainBox.classOfBox === seatClass &&
          foundTrainBox.trainBoxNumber === trainBoxid
        ) {
          currentSeats[index] = false;
          console.log(currentSeats);
          try{
            await trainBoxModel.updateOne({trainBoxNumber:trainBoxid},{seats:currentSeats});
            arrayResults.push({code:200,msg:objectID,data:true}) ;
          }catch(e){
            arrayResults.push({code:500,msg:objectID,data:false});
          }
          
        }

      })
      
    }

    return {code:200,msg:"task completed",data:arrayResults}
 
  }
  else{
    return {code:404,msg:"couldnt find the train"};
  }
};


//books a seat
const bookSeat = async (objectID) => {
  const IDs = objectID.split(':');

  let trainBoxid = parseInt(IDs[1]);
  let trainId = parseInt(IDs[2]);
  let seatIndex = parseInt(IDs[3]);
  let seatClass = IDs[0];

  console.log(`${seatClass}:${trainBoxid}:${trainId}:${seatIndex} `)

  if (IDs.length !== 4) {
    return { code: 500, msg: "invalid input" };
  }

  let foundTrain = null;

  let arrayResults = [];

  //checks whether train is available or not
  foundTrain = await trainModel.findOne({ trainNumber: trainId });

  //if available generating a seatid for the available seats
  if (foundTrain) {
    
    //iterating the trains and boxes and seats
    for (let trainBox of foundTrain.trainBoxes) {

      let foundTrainBox = await getTrainBox(trainBox);
      let currentSeats = foundTrainBox.seats
    
      currentSeats.forEach(async(isOccupied, index) => {
        //updating the train box with the reserved seat
        
       

        if (
          index === seatIndex &&
          foundTrainBox.classOfBox === seatClass &&
          foundTrainBox.trainBoxNumber === trainBoxid
        ) {
          currentSeats[index] = true;
          console.log(currentSeats);
          try{
            await trainBoxModel.updateOne({trainBoxNumber:trainBoxid},{seats:currentSeats});
            arrayResults.push({code:200,msg:objectID,data:true}) ;
          }catch(e){
            arrayResults.push({code:500,msg:objectID,data:false});
          }
          
        }

      })
      
    }

    return {code:200,msg:"task completed",data:arrayResults}
 
  }
  else{
    return {code:404,msg:"couldnt find the train"};
  }
};

///////////////////////////////////////////////////////////////////////////////////
/*
METHOD : GET
DESC : get train box
*/
const getTrainBox = async(ObjectId) =>{

  let foundTrainBox = null;
  try{
    foundTrainBox = await trainBoxModel.findOne({_id:ObjectId});
  }
  catch(e){
    return null;
  }
  

  return foundTrainBox;
}


const getTrains = async (req, res) => {
  console.log("controller hit");
  await trainModel
    .find({})
    .sort({ trainNumber: -1 })
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
  const { id,name,trainNumber } = req.body;

  let trainBoxesArray = [];

  console.log("controll is working");

  //validation
  if (!name && !trainNumber) return res.status(400).json({ msg: "name not found" });

  const outTrain = await trainModel.findOne({
    $or:[{name:name},{trainNumber:trainNumber}]
  });

  if (!outTrain) return res.json({ msg: "Train Does not exist" });


  //getting all trainboxes and assigns to an array
  const foundTrainBox = await trainBoxModel.find({});
  
  for(let currentTrainBox of foundTrainBox ){
    trainBoxesArray.push(currentTrainBox);
  }
  

  res.status(200).json({
    id: outTrain.trainNumber,
    name: outTrain.name,
    totalSeats:outTrain.totalSeats,
    trainBoxes: trainBoxesArray
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
  ,getTrains, addTrain, getTrain, deleteTrain 
  ,getAvailableSeats,
  bookSeat,
  bookSeatsWithArray,
  unBookSeatWithArray,
  createPrice

};
