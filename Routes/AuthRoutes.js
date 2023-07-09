const { loginUser, logoutUser } = require("../Controllers/AuthController");
const router = require("express").Router();

router.post("/login", loginUser);
router.get("/logout", logoutUser);

module.exports = router;
