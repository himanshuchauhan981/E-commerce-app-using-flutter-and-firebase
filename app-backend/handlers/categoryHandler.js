const { category } = require('../models')

const categoryHandler = {
  listSubCategory : async (req,res) =>{
    let categoryName = req.params.category.toLowerCase()
    let subCategoryList = await category.findOne({categoryName:categoryName}).select({subCategory:1,image:1})
    res.status(200).send(subCategoryList)
  }
}

module.exports = categoryHandler