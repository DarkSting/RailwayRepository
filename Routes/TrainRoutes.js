const router = require("express").Router();
const {
  getTrains,
  getTrain,
  deleteTrain,
  addTrain,
  putSeat
} = require("../Controllers/TrainControllers");
const { isAdmin, isAuthenticated } = require("../middlewares/auth");

router.get("/gettrain", getTrains);
router.post("/addtrain", addTrain);
router.post("/putseat", putSeat);
router.get("/gettrain", getTrain);
router.delete("/deletetrain", deleteTrain);

module.exports = router;
