const { categoryHandler } = require('../handlers')

const categoryController = {
  listSubCategory : async (req,res) =>{
    let response = await categoryHandler.listSubCategory(req,res)
    return response
  }
}

module.exports = categoryController