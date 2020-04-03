import React, { Component } from 'react';
import { Text, View, StyleSheet, TextInput, TouchableOpacity } from 'react-native';
import { Actions } from 'react-native-router-flux'

class SignUp extends Component {

   login(){
      Actions.login()
   }

   render() {
      return (
         <View style={styles.signupCont}>
            <Text style={styles.signUpText}>Sign Up</Text>
            <View style={styles.inputCont}>
               <TextInput
                  style={styles.signupInput}
                  placeholder="First Name"
               />
               <TextInput
                  style={styles.signupInput}
                  placeholder="Last Name"
               />
               <TextInput
                  style={styles.signupInput}
                  placeholder="Email"
               />
               <TextInput
                  style={styles.signupInput}
                  placeholder="Mobile Number"
               />
               <TextInput
                  style={styles.signupInput}
                  placeholder="Password"
                  secureTextEntry={true}
               />
               <View style={styles.btnCont}>
                  <TouchableOpacity>
                     <Text style={styles.signUpBtn}>Sign Up</Text>
                  </TouchableOpacity>
                  <Text style={styles.text}>Or</Text>
                  <TouchableOpacity onPress={this.login}>
                     <Text style={styles.signUpBtn}>Sign In</Text>
                  </TouchableOpacity>
               </View>
            </View>
         </View>
      )
   }
}

const styles = StyleSheet.create({
   signupCont: {
      padding: 25
   },
   signUpText: {
      fontSize: 45
   },
   inputCont: {
      paddingVertical: 40,
      paddingHorizontal: 30
   },
   signupInput: {
      alignSelf: 'stretch',
      borderWidth: 1,
      borderColor: 'black',
      marginBottom: 30,
      borderRadius: 40,
      paddingHorizontal: 20
   },
   btnCont: {
      paddingHorizontal: 30
   },
   signUpBtn: {
      alignSelf: 'stretch',
      marginVertical: 10,
      paddingVertical: 13,
      backgroundColor: '#768FFF',
      borderRadius: 25,
      textAlign: 'center',
      fontSize: 20,
      color: 'white'
   },
   text: {
      textAlign: 'center',
      fontSize: 25,
      marginVertical: 15
   }
})

export default SignUp