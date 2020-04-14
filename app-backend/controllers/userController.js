const {userHandler} = require('../handlers')

const userController  =  {
   signupUsers : async (req,res) =>{
      let response = await userHandler.signupUsers(req,res);
      return response
   }
}

module.exports = userController