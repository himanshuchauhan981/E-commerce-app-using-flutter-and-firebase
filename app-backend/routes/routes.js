const express = require('express')
const { userController,categoryController } = require('../controllers')

module.exports = ()=>{
   const router = express.Router()

   router.post('/login',
      userController.loginUsers
   )

   router.post('/signup',
      userController.signupUsers
   )

   router.get('/:category/sub',
      categoryController.listSubCategory
   )

   return router
}