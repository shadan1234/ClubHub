// const mongoose =require('mongoose');
// const { productSchema } = require('./product');

// const orderSchema=mongoose.Schema({
//     products:[
//         {
//             product:productSchema,
//             quantity:{
//                 type:Number,
//                 require:true,
//             }
    
//         }
//        ],
//    totalPrice:{
//     type:Number,
//     require:true
//    },
//    address:{
//     type:String,
//     require:true,
//    },

//    userId:{
//     require:true,
//     type:String,
//    },
//    orderedAt:{
//     require:true,
//     type:Number,
//    },
//    status:{
//     type:Number,
    
//     default:0,
//    }

 
// });
// const Order=mongoose.model('Order',orderSchema);
// module.exports=Order;