const express = require('express')
const { userController } = require('../controllers')

module.exports = ()=>{
   const router = express.Router()

   router.post('/login',(req,res) =>{
      console.log('hello')
      res.statusCode = 200
      res.send({msg:'hello'})
   })

   router.post('/signup',
      userController.signupUsers
   )

   return router
}