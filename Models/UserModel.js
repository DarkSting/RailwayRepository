const mongoose = require('mongoose');
const bcrypt = require('bcrypt')

const userSchema = new mongoose.Schema({
  userName: {
    type: String,
    trim: true,
    unique:[true,'user name is already exists'],
    maxlength: 50,
  },
  email: {
    type: String,
    maxlength: 100,
    unique: true,
  },
  encry_password: {
    type: String,
    required:[true,'password not provided']
  },
  phone: {
    type: String,
    trim: true,
    unique: true,
  },
 firstName:{
  type:String,
  required:[true,'firstname is not provided']
 },
 lastName:{
  type:String,
  required:[true,'lastname is not provided']
 },

  DOB:{
    type:Date,
    default:Date.now

  },
  createdAt:{
    type:Date,


  }
});

userSchema.statics.login = async function(username,password){

  const user = await this.findOne({userName:username});
  if(user){
    const auth = await bcrypt.compare(password,user.password);
    
    if(auth){
      return user;
    }

    throw Error('incorrect password');

  }

  throw Error('user not found');
}

userSchema.pre('save', async function () {
  if(this.encry_password!==""){
    const salt = await bcrypt.genSalt();
    this.encry_password= await bcrypt.hash(this.encry_password, salt);
    console.log(this.password);
  }
    
  });
  

const UserModel = mongoose.model("users", userSchema);

module.exports = {
  
  UserModel,
  userSchema

};