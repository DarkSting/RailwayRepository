const { createIntentent } = require('../Controllers/PaymentController');

const router = require('express').Router();



router.post('/makePayment',createIntentent);

module.exports = router;