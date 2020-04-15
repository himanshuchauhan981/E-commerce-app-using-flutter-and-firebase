const mongoose = require('mongoose')

const Scehma = mongoose.Schema

const products = new Scehma({
  name : {
    type: String
  },
  category: {
    type: String
  },
  vendorId: {
    type: String,
    default: null
  },
  cost:{
    type: Number
  },
  available:{
    type: Number
  },
  ordered: {
    type: Number
  },
  image: {
    type: String,
    default: null
  },
  descriptiom: {
    type: Array
  }
})

module.exports = mongoose.model('products',products)