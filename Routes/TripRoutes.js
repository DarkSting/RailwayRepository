const { createTrip, getTrips, getCurrentTrips } = require('../Controllers/TripControllers');

const router = require('express').Router();



router.post('/createtrip',createTrip);
router.get('/gettrips',getTrips);
router.get('/getcurrenttrips',getCurrentTrips);

module.exports = router;