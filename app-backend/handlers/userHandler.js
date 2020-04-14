const userHandler = {
   signupUsers : (req,res) =>{
      console.log(req.body)
      res.send({msg:'hello'})
   }
}

module.exports = userHandler