const stripePayment = require('stripe')(process.env.SECRET_KEY);



/**
 * 
 * METHOD : POST
 * ROUTE : payment/makePayment
 * DESC : takes the clients ticket price amount and fowards to the stripe payment 
 * 
 */
const createIntentent = async(req,res)=>{

  
  console.log("payment invoked")
    const{amount}=req.body;

    console.log(amount)

    if(!amount) return res.status(500).json({error:"amount required to proceed"});

    const paymentIntent = await stripePayment.paymentIntents.create({
    amount: parseInt(amount*100),
    currency: 'LKR',
    

  },function(error,paymentIntent){

    if(error!=null) return res.status(500).json(error);

    else{
      return res.status(200).json({
        paymentIntent: paymentIntent.client_secret,
        paymentIntentData: paymentIntent,
        amount : (amount),
        currency: "LKR"
      })
    }
  });

} 


module.exports = {createIntentent};
