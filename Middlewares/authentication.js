const jwt = require('jsonwebtoken');

const authenticateUser = (req,res,next)=>{

   const token = req.cookies.jwt;

   if(token){

    jwt.verify(token,process.env.SECRET,(err,decoded)=>{

        if(err){
            console.log(err.message);
            return res.status(500).json({msg:"token not recognized"});
        }
        else{
            req.body._id = decoded.id;
            next()
        }

    })

   }


}


const maxAge = 2*60*60

const createToken = (id,station)=>{

    return jwt.sign({id:id,station:station},process.env.SECRET,{expiresIn:maxAge})

}


module.exports = {authenticateUser,createToken}