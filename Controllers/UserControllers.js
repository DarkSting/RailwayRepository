const {UserModel} = require("../Models/UserModel");
const cookie = require('cookie');
const {authenticateUser, createToken} = require('../Middlewares/authentication');

/*
method : POST
route : /api/user/
description: to create a user
*/
const createUser = async (req, res) => {
  const{
    userName,
    email,
    password,
    phone,
    firstName,
    lastName,



} = req.body

console.log(req.body);


try{

var newUser = new UserModel({
    userName:userName,
    email:email,
    phone:phone,
    encry_password:password,
    firstName:firstName,
    lastName:lastName,

     
})

const result = await newUser.save()
return res.status(201).json(result);

}
catch(error){
return res.status(500).json({msg:error.message,code:500});
}
};

/*
method: GET
route: /api/user/:id
description: get's a single user given the id
*/
const getUser = async (req, res) => {
  const { userID } = req.body;

  console.log(userID);

  // validation
  if(!userID){
    return res.status(500).json({code:500,msg:"id and username not defined"})
  }

  let foundUser = null

  if(userID){
    foundUser = await UserModel.findOne({
      _id: userID.trim()});
  }
  else{
    
    foundUser = await UserModel.findOne({userName:userName});
  }



  // user not available
  if (!foundUser) return res.json({ msg: "User not Available" });

  // returns user
  return res.json({
    name:foundUser.firstName+" "+foundUser.lastName,
    email:foundUser.email,
    phone:foundUser.phone,
    nic:foundUser.nic,
    userName:foundUser.userName,
    DOB:foundUser.DOB
  });

};

/*
method: GET
route: /api/user/
description: get's all the users
*/
const getAllUsers = async (req, res) => {
  await UserModel
    .find({})
    .then((users) => {
      return res.status(200).json({
        users,
      });
    })
    .catch((err) => res.json({ err }));
};

/*
method: DELETE
route: /api/user/
description: deletes a single user given the id
*/
const deleteUser = async (req, res) => {
  const { id, userName } = req.body;

  // validation
  if(id!==undefined && userName!==undefined){
    return res.status(500).json({code:500,msg:"id and username not defined"})
  }

  let delUser = null

  if(id){
    delUser = await UserModel.findOne({
      _id: id});
  }
  else{
    
    delUser = await UserModel.findOne({userName:userName});
  }


  // user not available
  if (!delUser) return res.json({ msg: "User not Available" });

  // deletion

  

  if (!delUser) return res.json({ msg: "User Does not exist" });

  delUser
    .deleteOne()
    .then((deletedUser) => {
      return res.json({
       deleteUser
      });
    })
    .catch((err) => res.json({ err }));
};

/*
method: GET
route: /api/user/return
description: deletes a single user given the id
*/
const returnCurrentUser = async (req, res) => {
  const { token } = req.cookies;

  if (!token) return res.json({ msg: "Token Does not Exist" });

  try {
    var decoded = jwt.verify(token, process.env.TOKENKEY);
  } catch (err) {
    console.log(err);
  }
  const userExist = await user
    .findOne({ email: decoded.email })
    .catch((err) => console.log(err));

  if (!userExist) return res.json({ msg: "User Does not Exist" });

  return res.json({
    name: userExist.name,
    email: userExist.email,
    is_admin: userExist.is_admin,
    phone: userExist.phone,
    id: userExist._id,
  });
};

const loginUser = async(req,res)=>{

  const{userName,password} = req.body;

  try{
    const foundUser = await UserModel.login(userName,password);

    console.log(foundUser._id);
   if(!foundUser){
    return res.status(404).json({error:"user is not valid"});
   }

   res.setHeader('set-cookie', [
    cookie.serialize('_id', foundUser._id),
  ]);
    return res.status(200).json(foundUser);


  }catch(e){
    return res.status(500).json({msg:e.message});
  }
  
}



// exporting the modules
module.exports = {
  createUser,
  getUser,
  getAllUsers,
  deleteUser,
  returnCurrentUser,
  loginUser
};
