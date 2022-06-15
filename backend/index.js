const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routes/auth");

const app = express();

// using middleware
app.use(express.json());
app.use(authRouter);

//
app.get("/", (req, res) => {
  //   res.send("Working");
  res.json({ Working: "Working" });
});

// started server
app.listen(process.env.PORT || 3000, () => {
  console.log("server is listening on port 3000");
});

// connecting to database
try {
  const db_url = "mongodb://127.0.0.1:27017/auth";
  mongoose.connect(db_url, () => {
    console.log("connected to database..");
  });
} catch (error) {
  console.log(error);
}
