const router = require("express").Router();
const { createRoute,getRoute, getRoutes} = require("../Controllers/TrainRouteControllers");

router.post("/createroute", createRoute);
router.post("/getroute", getRoute);
router.get("/getroutes", getRoutes);

module.exports = router;