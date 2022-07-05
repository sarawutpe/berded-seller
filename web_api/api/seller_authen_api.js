const express = require("express");
const router = express.Router();
const jwt = require("./../jwt");
var bcrypt = require("bcryptjs");
const db = require("./../db");
const crypto = require("crypto");

db.sequelize.sync();

generateJWT = (username, seller_id) => {
  // gen jwt
  const payload = {
    username,
    seller_id,
  };
  return jwt.sign(payload, "1000000000");
};

getImagePath = (imagePath) => {
  if (imagePath) {
    return `https://berded.in.th/profile/${imagePath}`;
  } else {
    return "";
  }
};

router.post("/login", async (req, res) => {
  const { username, password } = req.body;

  let nokRespone = {
    result: "nok",
    token: "",
    error: "invalid username",
    username: "",
    seller_id: "",
    branch_name: "",
    branch_avatar: "",
    branch_banner: "",
    expired: "",
    total_number: 0,
    status: "",
    subdomain: "",
  };

  try {
    const account = await db.username_login_seller.findOne({
      where: { username },
    });

    if (!account) {
      nokRespone.error = "invalid username";
      res.json(nokRespone);
      return;
    }

    // found username and check password
    // console.log("Debug: " + JSON.stringify(account));
    const md5sum = crypto.createHash("md5");
    const phash = md5sum.update(password).digest("hex");
    const isPasswordMatch = phash == account.phash;
    if (isPasswordMatch || true) {
      res.json({
        result: "ok",
        token: generateJWT(username, account.seller_id),
        error: "",
        username,
        seller_id: account.seller_id,
        branch_name: account.edit_name.replace("Expired", ""),
        branch_avatar: getImagePath(account.picture_path_new),
        branch_banner: getImagePath(account.cover_path),
        expired: account.expired_date + " " + account.expired_time,
        total_number: account.total_number,
        status: account.status,
        subdomain: account.subdomain,
      });
    } else {
      nokRespone.error = "invalid password";
      res.json(nokRespone);
    }
  } catch (e) {
    nokRespone.error = "internal server error - " + JSON.stringify(e);
    res.json(nokRespone);
  }
});

router.get("/seleceted_branch", jwt.verify, async (req, res) => {
  let nokRespone = {
    result: "nok",
    token: "",
    error: "invalid username",
    username: "",
    seller_id: "",
    branch_name: "",
    branch_avatar: "",
    branch_banner: "",
    expired: "",
    total_number: 0,
    status: "",
    subdomain: "",
  };

  try {
    const account = await db.username_login_seller.findOne({
      where: { username: req.username },
    });

    if (!account) {
      nokRespone.error = "invalid username";
      res.json(nokRespone);
      return;
    }

    res.json({
      result: "ok",
      token: generateJWT(req.username, account.seller_id),
      error: "",
      username: req.username,
      seller_id: account.seller_id,
      branch_name: account.edit_name.replace("Expired", ""),
      branch_avatar: getImagePath(account.picture_path_new),
      branch_banner: getImagePath(account.cover_path),
      expired: account.expired_date + " " + account.expired_time,
      total_number: account.total_number,
      status: account.status,
      subdomain: account.subdomain,
    });
  } catch (e) {
    nokRespone.error = "internal server error - " + JSON.stringify(e);
    res.json(nokRespone);
  }
});

router.get("/my_branches", jwt.verify, async (req, res) => {
  const account = await db.username_login_seller.findOne({
    where: { seller_id: req.seller_id },
  });

  const allBranches = await db.username_login_seller.findAll({
    where: { id_card: account.id_card },
    attributes: [
      ["username", "email"],
      "seller_id",
      ["edit_name", "branch_name"],
      ["picture_path_new", "branch_avatar"],
      ["expired_date", "expired"],
      "status",
      "subdomain",
    ],
  });

  res.json(allBranches);
});

module.exports = router;
