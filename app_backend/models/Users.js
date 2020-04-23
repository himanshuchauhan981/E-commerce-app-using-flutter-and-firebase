const mongoose = require('mongoose')

const Schema = mongoose.Schema

const users = new Schema({
   firstName: {
      type: String,
      required: [true, 'First name is required']
   },

   lastName: {
      type: String,
      required: [true, 'Last name is required']
   },

   email: {
      type: String,
      required: [true, 'Email ID is required'],
      validate: {
         validator: (email) => {
            return /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(email)
         },
         message: 'Invalid Email ID'
      }
   },
   password: {
      type: String,
      required: [true, 'Password is required'],
      minlength: [6, 'Minimum length of password should be 6']
   },
   mobileNumber:{
      type: String,
      required:[true,'Mobile number is required'],
      validate: {
         validator : (mobileNumber) =>{
            if(mobileNumber.length != 10){
               return false;
            }
            return true;
         },
         message:'Invalid Mobile number'
      }
   }
})

module.exports = mongoose.model('users',users)