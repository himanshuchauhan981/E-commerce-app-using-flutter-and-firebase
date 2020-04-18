const { categoryHandler } = require('../handlers')

const categoryController = {
  categoryItems : async (req,res) =>{
    let response = await categoryHandler.categoryItems(req,res)
    return response
  }
}

module.exports = categoryController