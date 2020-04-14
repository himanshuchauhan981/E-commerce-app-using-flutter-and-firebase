const LocalStrategy = require('passport-local').Strategy
const { users } = require('../models')
const bcrypt = require('bcryptjs')

module.exports = (passport) => {
	passport.use(new LocalStrategy(
		(username, password, done) => {
			users.findOne({ email: username }, (err, user) => {
				if (err) return done(err)
				if (!user) {
					return done(null, false, { message: 'Incorrect Credentials' })
				}
				else {
					let userStatus = bcrypt.compareSync(password, user.password)
					if (userStatus) return done(null, user)
					else return done(null, false, { message: 'Incorrect Credentials' })
				}
			}).select({ 'username': 1, 'password': 1 })
		}
	))

	passport.serializeUser((user, done) => {
		done(null, user.id)
	})

	passport.deserializeUser((id, done) => {
		users.findById(id, (err, user) => {
			done(err, user)
		})
	})
}