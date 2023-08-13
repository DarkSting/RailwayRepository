const { createIntentent } = require('../Controllers/PaymentController');
const { sendmail } = require('../controllers/MailController');

const router = require('express').Router();


router.post('/makePayment',createIntentent);
router.post('/sendmail',sendmail);

module.exports = router;