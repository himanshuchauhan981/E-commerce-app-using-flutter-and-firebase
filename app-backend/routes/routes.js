const express = require('express')
const { userController } = require('../controllers')

module.exports = ()=>{
   const router = express.Router()

   router.post('/login',
      userController.loginUsers
   )

   router.post('/signup',
      userController.signupUsers
   )

   return router
}