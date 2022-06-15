// user model of database

const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: [true, "Please enter your name"],
  },
  email: {
    type: String,
    required: [true, "Please enter email"],
    trim: true,
    validate: {
      validator: (value) => {
        var re = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
        return re.test(value);
      },
      message: (props) => `${props.value} is not a valid email address!`,
    },
  },
  password: {
    type: String,
    required: [true, "Please enter passoword"],
    trim: true,
    validate: {
      validator: (value) => {
        return value.length > 5;
      },
      message: (props) => "password must be minimum 6 digit",
    },
  },
});

module.exports = mongoose.model("User", userSchema);
