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
  vendorId: {
    type: String,
    default: null
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
    type: String,
    default: null
  }
})

module.exports = mongoose.model('products',products)