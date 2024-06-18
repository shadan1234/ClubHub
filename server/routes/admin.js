// const express= require('express');
// const adminRouter=express.Router();
// const admin=require('../middlewares/admin');
// const {Product} = require('../models/product');
// const Order= require('../models/order');

// // Creating an Admin Middleware

// // Add product


// adminRouter.post('/admin/add-product',admin,async(req,res)=>{
    
//     try {
//         // console.log(req);
//         const {name,description,images,quantity,price,category}=req.body;
//         // console.log(category);
//         let product=new Product({
//             name,
//             description,
//             images, 
//             quantity,
//             price,
//             category
//         });
//         product=await product.save();
//         res.json(product);
//          // mongo db gives us our product but also add _id and __version
//         //  console.log(product);
//     } catch (e) {
//         res.status(500).json({error:e.message});
//     }
     
// })

// // Get all your products
// // admin/get-products
// adminRouter.get('/admin/get-products',admin, async(req,res)=>{
//    try{
//      // _id and description or any othere attribute can be used to filter out docs
//       const products=await Product.find({});
//       res.json(products);
//    }catch(e){
//     res.status(500).json({error:e.message});
//    } 
// });

// // Delete the product
// adminRouter.post('/admin/delete-product',admin,async(req,res)=>{
//     try {
//         const {id}=req.body;
//         let product=await Product.findByIdAndDelete(id);
       
//         res.json(product);

//     } catch (e) {
//         res.status(500).json({error:e.message});
//     }
// });

// adminRouter.get('/admin/get-orders',admin, async(req,res)=>{
//     try{
   
//        const orders=await Order.find({});
//        res.json(orders);
//     }catch(e){
//      res.status(500).json({error:e.message});
//     } 
//  });
//  adminRouter.post('/admin/change-order-status',admin,async(req,res)=>{
//     try {
//         const {id,status}=req.body;
//         let order=await Order.findById(id);
//         order.status=status;
//         order=await order.save();
//         res.json(order);

//     } catch (e) {
//         res.status(500).json({error:e.message});
//     }
// });

// adminRouter.get('/admin/analytics',admin,async (req,res)=>{
//    try {
//     const orders=await Order.find({});
//     let totalEarnings=0;
//     for(let i=0;i<orders.length;i++){
//         for(let j=0;j<orders[i].products.length;j++){
//             totalEarnings+=orders[i].products[j].quantity * orders[i].products[j].product.price;
//         }
//     }
//     // category wise order fetching
//    let mobileEarnings= await fetchCategoryWiseProduct('Mobiles');
//    let essentialsEarnings= await fetchCategoryWiseProduct('Essentials');
//    let applianceEarnings= await fetchCategoryWiseProduct('Appliances');
//    let booksEarnings= await fetchCategoryWiseProduct('Books');
//    let fashionEarnings= await fetchCategoryWiseProduct('Fashion');
//    let earnings={
//     totalEarnings,
//     mobileEarnings,
//     essentialsEarnings,
//     applianceEarnings,
//     booksEarnings,
//     fashionEarnings
    

//    };
//     res.json(earnings);
    
//    } catch (e) {
//     res.status(500).json({error:e.message});
//    }
// })

// async function fetchCategoryWiseProduct(category){
//   let categoryOrders=await Order.find({
//     'products.product.category' : category
//   })
//   let earnings=0;
//   for(let i=0;i<categoryOrders.length;i++){
//     for(let j=0;j<categoryOrders[i].products.length;j++){
//         earnings+=categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
//     }
// }
// return earnings;
// }


// module.exports=adminRouter;