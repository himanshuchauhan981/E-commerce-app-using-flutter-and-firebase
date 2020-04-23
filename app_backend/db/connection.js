const mongoose = require('mongoose')

mongoose.set('useNewUrlParser', true)
mongoose.set('useUnifiedTopology', true)

let MONGO_HOSTNAME = process.env.MONGO_HOSTNAME
let MONGO_PORT = process.env.MONGO_PORT
let MONGO_DB = process.env.MONGO_DB

const url = `mongodb://${MONGO_HOSTNAME}:${MONGO_PORT}/${MONGO_DB}`

mongoose.connect(url, (err, conn) => {
   if (err) {
      console.log('Mongo error ', err)
   }
   else {
      console.log('Mongoose Connection is Successful')
   }
})