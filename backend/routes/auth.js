// all http methods like get/post
const express = require("express");
const router = express.Router();
const bcrypt = require("bcryptjs");
const User = require("../models/user");
const jwt = require("jsonwebtoken");
require("dotenv").config();

// creating account/sign up
router.post("/signup", async (req, res) => {
  try {
    let user = new User({
      name: req.body.name,
      email: req.body.email,
      password: req.body.password,
    });
    const dbUser = await User.findOne({ email: user.email });
    // if user is already exist
    if (dbUser) {
      return res
        .status(400)
        .json({ error: "User with this email is already exist" });
    }
    // creating hash of password
    var salt = bcrypt.genSaltSync(10);
    var hashPassword = bcrypt.hashSync(user.password, salt);

    // changing user password to hash password
    user.password = hashPassword;

    // save user to database
    user = await user.save();

    // returning user object _id
    return res.status(200).json(user);
  } catch (error) {
    return res.status(500).json({ error: error.message });
  }
});

// sign in
router.post("/signin", async (req, res) => {
  try {
    const user = new User({
      email: req.body.email,
      password: req.body.password,
    });

    const dbUser = await User.findOne({ email: user.email });
    // if user is not exist
    if (!dbUser) {
      return res.status(400).json({ error: "User not exist" });
    }

    // verifying client password with database hash password
    let isPasswordMatched = bcrypt.compareSync(user.password, dbUser.password);
    if (!isPasswordMatched) {
      return res.status(400).json({ error: "Incorrect password" });
    }

    // creating a jwt token
    const jwtToken = jwt.sign({ id: dbUser._id }, process.env.JWT_KEY);

    // returning user name, email and jwt token
    return res.json({
      name: dbUser.name,
      email: dbUser.email,
      token: jwtToken,
    });
  } catch (error) {
    return res.send(500).json({ error: error.message });
  }
});

module.exports = router;
