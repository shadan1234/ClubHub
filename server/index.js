const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
const dotenv = require("dotenv");

const authRouter = require("./routes/auth");
const profileRouter = require("./routes/profile");
const adminRouter = require("./routes/admin");
const userRouter = require("./routes/user");
const applicationRouter = require("./routes/application");
const notificationRouter = require("./routes/notification");
const teamRouter = require("./routes/teams");
const messageRouter = require("./routes/message");

// Load environment variables
dotenv.config();

const PORT = process.env.PORT || 3000; 
const dbUrl = process.env.DATABASE_URL;

// Ensure DATABASE_URL is loaded
if (!dbUrl) {
  throw new Error("DATABASE_URL is not defined in the environment variables.");
}

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use(authRouter);
app.use(profileRouter);
app.use(adminRouter);
app.use(applicationRouter);
app.use(userRouter); 
app.use(notificationRouter);
app.use(teamRouter);
app.use(messageRouter);

// Connections
mongoose.connect(dbUrl, { useNewUrlParser: true, useUnifiedTopology: true })
  .then(() => {
    console.log("Successfully connected to the database");
  })
  .catch((e) => {
    console.error("Database connection error:", e);
  });

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});
