const mongoose = require('mongoose')

mongoose.set('useNewUrlParser', true)
mongoose.set('useUnifiedTopology', true)

const url = `mongodb://${process.env.MONGO_HOSTNAME}:${process.env.MONGO_PORT}/${process.env.MONGO_DB}`

mongoose.connect(url, (err, conn) => {
   if (err) {
      console.log('Mongo error ', err)
   }
   else {
      console.log('Mongoose Connection is Successful')
   }
})