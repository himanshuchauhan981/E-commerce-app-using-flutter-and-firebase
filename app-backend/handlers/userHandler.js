const bcrypt = require('bcryptjs')
const {users} = require('../models')
const userHandler = {
   signupUsers : async (req,res) =>{
      let userDetails = req.body
      let userStatus = await users.find({ $or: [{ email: userDetails.email }, { username: userDetails.mobileNumber }] })
      if(userStatus.length == 0){
         let salt = bcrypt.genSaltSync(10)
         let hash = bcrypt.hashSync(userDetails.password,salt)
         userDetails.password = hash

         let user = new users(userDetails)
         await user.save((err,user) =>{
            if(err){
               console.log('error : ',err);
            }
            else{
               res.status(200)
            }
         })

      }
      else{
         res.status(400).send('User already existed')
      }
   }
}

module.exports = userHandler