const { category,products } = require('../models')

const categoryHandler = {
  listSubCategory : async (req,res) =>{
    let categoryName = req.params.category.toLowerCase()
    let subCategoryList = await category.findOne({categoryName:categoryName}).select({subCategory:1,image:1})
    res.status(200).send(subCategoryList)
  },

  listNewItems : async (req,res) =>{
    let randomNumber = Math.floor(Math.random()*20) + 1;
    let newItems = await products.find().skip(randomNumber).limit(5).select({image:1,name:1});
    res.status(200).send(newItems)
  },

  listAllItems : async (req,res) =>{
    let allItems = await products.find().limit(15).select({image:1, cost:1,name:1})
    res.status(200).send(newItems)
  }
}

module.exports = categoryHandler