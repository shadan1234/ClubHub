// const express= require('express');
// const productRouter=express.Router();
// const {Product} = require('../models/product');
// const auth = require('../middlewares/auth');

// // /api/products?category=Essentials
// // /api/amazon?theme=dark
// // /api/products:category=Essential  params
// productRouter.get('/api/products',auth, async(req,res)=>{
//     try{
      
//     console.log(req.query.category);
//       const products=await Product.find({category :req.query.category});
//        res.json(products);
//     }catch(e){
//      res.status(500).json({error:e.message});
//     } 
//  });

// // Create a get request to search products and get them
// // /api/products/search/i
// productRouter.get('/api/products/search/:name',auth, async(req,res)=>{
//    try{
     
//    console.log(req.params.name);
//      const products=await Product.find({
//       name: {$regex:req.params.name, $options:"i"},
//      });
//      // iphone i
//       res.json(products);
//    }catch(e){
//     res.status(500).json({error:e.message});
//    } 
// });

// // create a post request route  to rate the product
// productRouter.post('/api/rate-product', auth, async (req, res) => {
//    try {
//      const { id, rating } = req.body;
//      let product = await Product.findById(id); // Correctly await the promise
 
//      if (!product) {
//        return res.status(404).json({ error: 'Product not found' });
//      }
 
//      if (!product.ratings) {
//        product.ratings = [];
//      }
 
//      const userId = req.user; // Assuming req.user is the user ID
 
//      // Check if the user has already rated the product
//      const existingRatingIndex = product.ratings.findIndex(r => r.userId.toString() === userId);
 
//      if (existingRatingIndex !== -1) {
//        // Update the existing rating
//        product.ratings[existingRatingIndex].rating = rating;
//      } else {
//        // Add a new rating
//        product.ratings.push({ userId: userId, rating: rating });
//      }
 
//      product = await product.save(); // Save the product with the updated ratings
//      res.json(product);
//    } catch (e) {
//      res.status(500).json({ error: e.message });
//    }
//  });

//  productRouter.get('/api/deal-of-day',auth,async(req,res)=>{
//        try {
//         let products= await Product.find({});
//         // sort the products based on rating and get the highest rating
//         // A->10
//         // B->30
//         // C->50     total rating comparision
//         // sort in descending order
//         products.sort((a,b)=>{
//           let aSum=0;
//           let bSum=0;
//            for(let i=0;i<a.ratings.length;i++){
//             aSum+=a.ratings[i].rating;
//           }
//           for(let i=0;i<b.ratings.length;i++){
//             bSum+=b.ratings[i].rating;
//           }
//           return aSum<bSum ?1:-1;
//         });
//         res.json(products[0]);
//        } catch (e) {
//         res.status(500).json({error:e.message});
//        }
//  });
 

// module.exports=productRouter;