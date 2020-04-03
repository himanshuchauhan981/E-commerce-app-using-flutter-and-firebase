import React, { Component } from 'react';
import { View, Text,StyleSheet,TextInput,TouchableOpacity } from 'react-native';
import { Actions } from 'react-native-router-flux'

class SignIn extends Component {

   signUp(){
      Actions.signup()
   }

   render(){
      return(
         <View style={styles.loginCont}>
            <Text style={styles.loginText}>Sign In</Text>
            <View style={styles.inputCont}>
               <TextInput
                  style={styles.loginInput}
                  placeholder="Email or Phone number"
               />
               <TextInput
                  style={styles.loginInput}
                  placeholder="Password"
                  secureTextEntry={true}
               />
               <View style={styles.btnCont}>
                  <TouchableOpacity>
                     <Text style={styles.signInBtn}>Sign In</Text>
                  </TouchableOpacity>
                  <Text style={styles.signInText}>Or</Text>
                  <TouchableOpacity>
                     <Text style={styles.signInBtn}>Sign Up</Text>
                  </TouchableOpacity>
               </View>
            </View>
         </View>
      )
   }
}

const styles = StyleSheet.create({
   loginCont: {
      margin: 25
   },
   loginText: {
      fontSize: 45
   },
   inputCont: {
      paddingVertical: 70,
      paddingHorizontal: 30
   },
   loginInput: {
      alignSelf:'stretch',
      borderWidth:1,
      borderColor: 'black',
      marginBottom: 30,
      borderRadius: 40,
      paddingHorizontal: 20
   },
   btnCont: {
      paddingHorizontal: 30
   },
   signInBtn: {
      alignSelf: 'stretch',
      marginVertical: 10,
      paddingVertical: 13,
      backgroundColor:'#768FFF',
      borderRadius: 25,
      textAlign: 'center',
      fontSize: 20,
      color: 'white'
   },
   signInText: {
      textAlign: 'center',
      fontSize: 25,
      marginVertical: 20
   }
})

export default SignIn