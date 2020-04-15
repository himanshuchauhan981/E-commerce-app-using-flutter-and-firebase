const faker = require('faker')
const dotenv = require('dotenv')
const csv = require('csv-parser')
const fs = require('fs')
const bcrypt = require('bcryptjs')
dotenv.config()

const { users, products } = require('./models')
require('./db').connection

function createMockData() {
  // saveUserMockData()
  createProductMockData()

}

function createProductMockData(){
  
  fs.createReadStream('./csv/PRODUCTS_MOCK_DATA.csv')
    .pipe(csv())
    .on('data', async(productDetails) =>{
      let price = parseInt(faker.commerce.price())
      
      productDetails['available'] = parseInt(productDetails['available'])
      productDetails['ordered'] = parseInt(productDetails['ordered'])
      productDetails['cost'] = price
      
      let newProduct = new products(productDetails)
      await newProduct.save((err,product) =>{
        if(err){
          console.log('Product not created')
        }
        else{
          console.log('Product created successfully')
        }
      })
    })
}

function saveUserMockData() {
  fs.createReadStream('./csv/USERS_MOCK_DATA.csv')
    .pipe(csv())
    .on('data',async (userDetails) => {
      let userStatus = await users.find({ $or: [{ email: userDetails.email }, { mobileNumber: userDetails.mobileNumber }] })
      if(userStatus.length == 0){
        let salt = bcrypt.genSaltSync(10)
        let hash = bcrypt.hashSync(userDetails.password,salt)
        userDetails.password = hash
        let user = new users(userDetails)
        await user.save((err,user) =>{
           if(err){
             console.log('User not saved')
           }
           else{
              console.log('New User created')
           }
        })

     }
     else{
        console.log('User already existed')
     }
    })
    .on('end', () => {
      console.log('CSV file successfully processed');
    });
}

createMockData()