const express = require("express");
const mongoose = require("mongoose");

const authRouter = require("./routes/auth");
const profileRouter = require("./routes/profile");
const adminRouter = require("./routes/admin");
const userRouter = require("./routes/user");
const applicationRouter = require("./routes/application");
const notificationRouter = require("./routes/notification");
const teamRouter = require("./routes/teams");
const messageRouter = require("./routes/message");
require('dotenv').config();

// INIT
const PORT = process.env.PORT || 3000;

const app = express();
const dbUrl = process.env.DATABASE_URL;

app.use(express.json());
app.use(authRouter);
app.use(profileRouter);
app.use(adminRouter);
app.use(applicationRouter);
app.use(userRouter);
app.use(notificationRouter);
app.use(teamRouter);
app.use(messageRouter);

// Connections
mongoose.connect(dbUrl).then(() => {
    console.log("Successfully connected");
}).catch((e) => {
    console.log(e);
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});
