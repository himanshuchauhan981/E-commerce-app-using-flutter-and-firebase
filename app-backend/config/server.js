const dotenv = require('dotenv')
const express = require('express')
const cors = require('cors')
const app = express()

var corsOptions = {
   origin: 'http://localhost:8088',
   optionsSuccessStatus: 200
}

// app.use(cors(corsOptions))

const bodyParser = require('body-parser')
const session = require('express-session')
const cookieParser = require('cookie-parser')
const passport = require('passport')

dotenv.config()
const { HOST, PORT,MONGO_HOSTNAME } = require('./config')
require('../db').connection
const { routes } = require('../routes')

app.use(cookieParser())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use(session({
   secret: 'keyboard cat',
   resave: false,
   saveUninitialized: true,
   cookie: { secure: true }
}))

app.use('/', routes())

app.use(passport.initialize())
app.use(passport.session())

app.listen(PORT, HOST, (err) => {
   if (err) console.log(err)
   else console.log(`Running on ${HOST}:${PORT}`)
})