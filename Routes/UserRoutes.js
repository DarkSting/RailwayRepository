const router = require("express").Router();
const {
  createUser,
  getUser,
  getAllUsers,
  deleteUser,
  returnCurrentUser,
  loginUser,
} = require("../Controllers/UserControllers");
const { isAdmin, isAuthenticated } = require("../Middlewares/authentication");
router.post("/adduser", createUser);
router.post("/getuser", getUser);
router.get("/getallusers", getAllUsers);
router.delete("/deleteuser", deleteUser);
router.post("/loginuser", loginUser);
//hello there im akash

module.exports = router;
