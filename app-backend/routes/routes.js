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

   router.get('/items/new',
      categoryController.listNewItems
   )

   return router
}