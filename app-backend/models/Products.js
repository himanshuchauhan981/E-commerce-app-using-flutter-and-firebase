const mongoose = require('mongoose')

const Scehma = mongoose.Schema

const products = new Scehma({
  name : {
    type: String
  },
  category: {
    type: String
  },
  subCategory: {
    type: String
  },
  cost: {
    type: Number
  },
  availableQuantity: {
    type: Number
  },
  orderedQuantity: {
    type: Number
  },
  image: {
    type: String
  }
})

module.exports = mongoose.model('products',products)