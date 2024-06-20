const mongoose = require("mongoose");


const clubSchema = mongoose.Schema({
  image: {
    required: true,
    type: String, 
    
  },
  nameOfClub: {
    
    required: true,
    type: String,
    trim: true,
   
  },
  type: {
    required: true,
    type: String,

    
  },
  description:{
    type:String,
    required: true,
  },
  
  workDoneByClub: {
    type: String,
    default: "",
  },
  //cart

});

const Club=mongoose.model('Club',clubSchema);

module.exports=Club;    