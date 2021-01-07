# E-commerce app using Flutter and Firebase
Flutter app for client's ecommerce bussiness.

## Getting Started

It is an complete e-commerce mobile app which is designed using flutter. It uses firebase as a backend for CRUD operations.

## Tool Used
- Flutter
- Firebase

## Steps to reproduce the project in your environment
- Download and setup the flutter SDK
- Install flutter plugin in your editor(preferably Android Studio).
- Create your own firebase project and make sure that package name in firebase app should be same as application id which is in android gradle file.
- Download google-service.json file and paste inside **/android/app** directory.
- Run flutter get/ pub get for getting dependencies.
- Press run button in Android studio to install the apk
- The project will now be running in your device.

## Steps to write sample products data in firebase
- For product images, drop down all the images from **assets/mock_images** folder to the firebase storage without creating any folder structure inside firebase storage.
- For product data, make following changes in **main.dart** file

```
initialRoute:'/admin',
```
- Hot reload your app. After this, click on button to write product data in firebase cloud firestore.


## Features of this flutter app

- Home
  * Main Products Carousel
  * Featured products carousel
  * Products Grid view

- Products
  * Products List view
  * Products Details view
  * Color picker
  * Size picker (optional)
  * Share to Messenger, Whatsapp, Wechat, Twitter, E-mail, Copy Link, etc.
  * Wishlist

- Shopping Cart
  * Add to Cart functionality
  * Remove from Cart
  * Edit Shopping Cart
  * Order History
  * Reorder functionality

- Checkout Experience
  * Shopping Cart
  * Shipping Address
  * Shipping Methods
  * Payment Methods
  * Add New Card
  * Place Order

- Customer Profile
  * Account details
  * Edit Profile Details
  * Setting
  * Contact us

 - Customer Management
   * Registration with Email & Password
   * Login with E-mail & Password
   * Google Sign In (Left to achieve)
   * Logout


- Backend
  * Database system with Firebase Firestore
  * User management with Firebase Authentication
  
