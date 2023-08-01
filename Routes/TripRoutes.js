const { createTrip } = require('../Controllers/TripControllers');

const router = require('express').Router();



router.post('/createtrip',createTrip);

module.exports = router;