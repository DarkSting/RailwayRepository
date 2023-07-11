const mongoose = require("mongoose");

const loyaltySchema = new mongoose.Schema({
  tier: {
    type: Number,
    default: 1,
  },
  discount: {
    type: Number,
    default: 10,
  },
  priorityBooking: {
    type: Boolean,
    default: true,
  },
  loungeAccess: {
    type: Boolean,
    default: true,
  },
  rewardPointsPerDollar: {
    type: Number,
    default: 1000,
  },


});

module.exports = mongoose.model("loyalty", loyaltySchema);
