const router = require("express").Router();
const {
  getTrains,
  getTrain,
  deleteTrain,
  addTrain,
  putSeat
} = require("../Controllers/TrainControllers");
const { isAdmin, isAuthenticated } = require("../middlewares/auth");

router.get("/getTrain", getTrains);
router.post("/addTrain", addTrain);
router.post("/putSeat", putSeat);
router.get("/getTrain", getTrain);
router.delete("/delTrain", deleteTrain);

module.exports = router;
