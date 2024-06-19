const express = require("express");
const mongoose=require("mongoose");

const authRouter = require("./routes/auth");
const profileRouter = require("./routes/profile");
// const adminRouter = require("./routes/admin");
// const productRouter = require("./routes/product");
// const userRouter = require("./routes/user");

// INIT 
const PORT = process.env.PORT ||  3000; // convention to use 3000 can be any no.

const app = express(); // express initialization
const DB="mongodb+srv://superAdmin:superAdmin123@cluster0.adtmt60.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";


app.use(express.json());
app.use(authRouter);
app.use(profileRouter);
// app.use(adminRouter);
// app.use(productRouter);
// app.use(userRouter);



// Connections
 mongoose.connect(DB).then(()=>{
    console.log("Successfully connected");
 })
 .catch((e)=>{console.log(e);})


app.listen(PORT,"0.0.0.0", () => {
  console.log(`connected at port ${PORT} hello`);
});

//127.0.0.1
