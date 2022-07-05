const express = require("express");
const router = express.Router();

router.use("/", require("./seller_core_api"));
router.use("/authen", require("./seller_authen_api"));
router.use("/branch", require("./seller_core_api"));

module.exports = router;
