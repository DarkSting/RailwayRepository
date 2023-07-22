const router = require("express").Router();
const {
  createUser,
  getUser,
  getAllUsers,
  deleteUser,
  returnCurrentUser,
} = require("../Controllers/UserControllers");
const { isAdmin, isAuthenticated } = require("../middlewares/auth");
router.post("/adduser", createUser);
router.get("/getuser", getUser);
router.get("/getallusers", getAllUsers);
router.delete("/deleteuser", deleteUser);
router.get("/return/current", isAuthenticated, returnCurrentUser);
//hello there im akash

module.exports = router;
