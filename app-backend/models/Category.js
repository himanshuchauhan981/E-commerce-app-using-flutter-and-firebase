const mongoose = require('mongoose')

const Scehma = mongoose.Schema

const category = new Scehma({
  categoryName: {
    type: String
  },
  image: {
    type: String
  },
  subCategory:[]
},{collection:'category'})

module.exports = mongoose.model('category',category)