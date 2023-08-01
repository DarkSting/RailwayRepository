const { createStation,getStation, getStations } = require('../Controllers/StationControllers');

const router = require('express').Router();


router.post('/createstation',createStation);
router.post('/getstation',getStation);
router.get('/getstations',getStations);

module.exports = router;