const router = require("express").Router();
const { createBooking } = require("../Controllers/BookingController");
const {
  getTrains,
  getTrain,
  deleteTrain,
  addTrain,
  putSeat,
  getAvailableSeats,
  bookSeat,
  bookSeatsWithArray,
  unBookSeatWithArray,
  createPrice
} = require("../Controllers/TrainControllers");
const { isAdmin, isAuthenticated } = require("../middlewares/auth");

router.post("/gettrain", getTrain);
router.post("/gettrains", getTrains);
router.post("/addtrain", addTrain);
router.post("/putseat", putSeat);
router.post("/gettrains", getTrains);
router.delete("/deletetrain", deleteTrain);
router.put("/bookseats",bookSeatsWithArray);
router.put("/unbookseats",unBookSeatWithArray);
router.post("/getavailableseats",getAvailableSeats);
router.post("/createprice", createPrice);
router.post("/createbooking", createBooking);


module.exports = router;
