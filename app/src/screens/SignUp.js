import React, { Component } from 'react';
import { Text, View, StyleSheet, TextInput, TouchableOpacity } from 'react-native';
import { Actions } from 'react-native-router-flux'
import { ValidationService } from '../components/ValidationService'


class SignUp extends Component {
   constructor(props) {
      super(props)

      this.state = {
         firstName: { error: null, value: '', type: 'generic' },
         lastName: { error: null, value: '', type: 'generic' },
         email: { error: null, value: '', type: 'email' },
         mobileNumber: { error: null, value: '', type: 'phone' },
         password: { error: null, value: '', type: 'password' }
      }

      this.onChangeText = ValidationService.onInputChange.bind(this)
      this.getFormValidation = ValidationService.getFormValidation.bind(this)
      this.submit = this.submit.bind(this)
   }

   login() {
      Actions.login()
   }

   renderError(id) {
      const stateValue = this.state[id]
      if (stateValue.error) {
         return <Text style={styles.error}>{stateValue.error}</Text>;
      }
   }

   submit(){
      let error = this.getFormValidation()
      if(!error){

      }
      
   }

   render() {
      return (
         <View style={styles.signupCont}>
            <Text style={styles.signUpText}>Sign Up</Text>
            <View style={styles.inputCont}>
               <View>
                  <TextInput
                     style={styles.signupInput}
                     placeholder="First Name"
                     onChangeText={(text) => this.onChangeText('firstName', text)}
                  />
                  {this.renderError('firstName')}
               </View>
               <View>
                  <TextInput
                     style={styles.signupInput}
                     placeholder="Last Name"
                     onChangeText={(text) => this.onChangeText('lastName', text)}
                  />
                  {this.renderError('lastName')}
               </View>
               <View>
                  <TextInput
                     style={styles.signupInput}
                     placeholder="Email"
                     onChangeText={(text) => this.onChangeText('email', text)}
                  />
                  {this.renderError('email')}
               </View>
               <View>
                  <TextInput
                     style={styles.signupInput}
                     placeholder="Mobile Number"
                     keyboardType="number-pad"
                     onChangeText={(text) => this.onChangeText('mobileNumber', text)}
                  />
                  {this.renderError('mobileNumber')}
               </View>
               <View>
                  <TextInput
                     style={styles.signupInput}
                     placeholder="Password"
                     secureTextEntry={true}
                     onChangeText={(text) => this.onChangeText('password', text)}
                  />
                  {this.renderError('password')}
               </View>
               <View style={styles.btnCont}>
                  <TouchableOpacity onPress={this.submit}>
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
   },
   error: {
      position: 'absolute',
      bottom: 15,
      color: 'red',
      paddingLeft: 20
   }
})

export default SignUp