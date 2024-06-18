// const express = require("express");
// const userRouter = express.Router();
// const auth = require("../middlewares/auth");
// const { Product } = require("../models/product");
// const User = require("../models/user");
// const Order = require("../models/order");


// userRouter.post("/api/add-to-cart", auth, async (req, res) => {
//   try {
//     const { id } = req.body;
//     const product = await Product.findById(id);
//     let user = await User.findById(req.user);

//     if (user.cart.length == 0) {
//       user.cart.push({ product, quantity: 1 });
//     } else {
//       let isProductFound = false;
//       for (let i = 0; i < user.cart.length; i++) {
//         if (user.cart[i].product._id.equals(product._id)) {
//           // object comparision
//           isProductFound = true;
//           break;
//         }
//       }
//       if (isProductFound) {
//         let producttt = user.cart.find((productt) =>
//           productt.product._id.equals(product._id)
//         );
//         producttt.quantity += 1;
//       } else {
//         user.cart.push({ product, quantity: 1 });
//       }
//     }
//     user = await user.save();
//     res.json(user);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });
// userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
//   try {
//     const { id } = req.params;
//     const product = await Product.findById(id);
//     let user = await User.findById(req.user);

//     for (let i = 0; i < user.cart.length; i++) {
//       if (user.cart[i].product._id.equals(product._id)) {
//         if (user.cart[i].quantity == 1) {
//           user.cart.splice(i, 1);
//         } else {
//           user.cart[i].quantity -= 1;
//         }
//       }
//     }

//     user = await user.save();
//     res.json(user);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// // save user address
// userRouter.post("/api/save-user-address", auth, async (req, res) => {
//   try {
//     let user = await User.findById(req.user);
//     const { address } = req.body;
//     user.address = address;

//     user = await user.save();
//     res.json(user);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });
// // ordering product
// userRouter.post("/api/order", auth, async (req, res) => {
//   try {

//     const { cart,totalPrice,address } = req.body;
   
//     let products=[];
//     for(let i=0;i<cart.length;i++){
//       let product= await Product.findById(cart[i].product._id);
//       if(product.quantity>=cart[i].quantity){
//         product.quantity-=cart[i].quantity;
//         products.push({product,quantity:cart[i].quantity,});
//         await product.save();
//       }else{
//         res.status(400).json({msg: `${product.name} is out of stock`});
//       }
//     }
//    let user=await User.findById(req.user);
//    user.cart=[];
//    user=await user.save();
//    let order =new Order({
//     products,
//     totalPrice,
//     address,
//     userId:req.user,
//     orderedAt:new Date().getTime(),
//    })
//    order=await order.save();
//     res.json(order);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// userRouter.get('/api/orders/me',auth,async(req,res)=>{
//   try {
//     let orders=await Order.find({userId:req.user});
//     res.json(orders);
//   } catch (e) {
//     res.status(500).json({error:e.message});
//   }
// })


// module.exports = userRouter;
