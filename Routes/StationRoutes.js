const { createStation,getStation, getStations, getStationsByID } = require('../Controllers/StationControllers');

const router = require('express').Router();


router.post('/createstation',createStation);
router.post('/getstation',getStation);
router.get('/getstations',getStations);
router.post('/getstationsbyid',getStationsByID);


module.exports = router;