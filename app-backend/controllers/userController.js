const {userHandler} = require('../handlers')

const userController  =  {
   signupUsers : async (req,res) =>{
      let response = await userHandler.signupUsers(req,res)
      return response
   },
   loginUsers : async (req,res,next) =>{
      const response = await userHandler.loginUsers(req,res,next)
      return response
   }
}

module.exports = userController