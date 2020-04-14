const bcrypt = require('bcryptjs')
const passport = require('passport')

const { users } = require('../models')
const { token } = require('../auth')

const userHandler = {
   signupUsers : async (req,res) =>{
      let userDetails = req.body
      let userStatus = await users.find({ $or: [{ email: userDetails.email }, { mobileNumber: userDetails.mobileNumber }] })
      if(userStatus.length == 0){
         let salt = bcrypt.genSaltSync(10)
         let hash = bcrypt.hashSync(userDetails.password,salt)
         userDetails.password = hash
         let user = new users(userDetails)
         await user.save((err,user) =>{
            if(err){
               res.status(400).send('Error! Try again later')
            }
            else{
               res.status(200).send('New User created')
            }
         })

      }
      else{
         res.status(400).send('User already existed')
      }
   },

   loginUsers : async(req,res,next) =>{
      
      passport.authenticate('local',(err,user,info) =>{
         if (err) return next(err)
         if (!user) return res.status(401).send('Invalid Credentials')
         req.logIn(user, (err) => {
            if (err) { return next(err); }
            let  createdToken = token.createToken(user._id)
            return res.status(200).json({ token:createdToken })
        })
      })(req,res,next)
   }
}

module.exports = userHandler