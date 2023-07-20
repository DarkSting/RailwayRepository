const mongoose = require("mongoose");

const EmployeeSchema = new mongoose.Schema({
  name: {
    type: String,
    required: [true,'please provide name'],
  },
  email: {
    type: String,
    required: [true,'please provide email'],
    unique: true,
  },
  password: {
    type: String,
    required: [true,'please provide password'],
  },
  role: {
    type: String,
    enum: ["admin", "manager", "clerk"],
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
  nic:{
    type:String,
    required:[true,'not provided nic']
  }
});

module.exports = mongoose.model("employee", EmployeeSchema);