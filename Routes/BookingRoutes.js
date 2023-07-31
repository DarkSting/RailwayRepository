const router = require("express").Router();
const { getBookings, createBooking } = require("../Controllers/BookingController");


const { isAdmin, isAuthenticated } = require("../middlewares/auth");

router.post("/makebook", createBooking);
router.post("/getbookings", getBookings);


module.exports = router;
