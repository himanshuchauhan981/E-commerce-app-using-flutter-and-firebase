const express = require('express')

module.exports = ()=>{
   const router = express.Router()

   router.post('/login',(req,res) =>{
      res.status(200).send({msg:'hello'})
   })

   return router
}