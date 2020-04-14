const jwt = require('jsonwebtoken')

const tokenUtil = {
  createToken: (id) => {
    let privateKey = 'gRG9lIiwiaWF0IjoxNTE2MjM5'
    let object = {
      userId: id
    }
    var token = jwt.sign(object, privateKey, { expiresIn: '10h' })
    return token
  }
}


module.exports = tokenUtil