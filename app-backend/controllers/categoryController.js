const { categoryHandler } = require('../handlers')

const categoryController = {
  listSubCategory : async (req,res) =>{
    let response = await categoryHandler.listSubCategory(req,res)
    return response
  },

  listNewItems : async (req,res) =>{
    let response = await categoryHandler.listNewItems(req,res)
    return response
  },

  listAllItems : async (req,res) =>{
    let response = await categoryHandler.listAllItems(req,res)
    return response
  }
}

module.exports = categoryController