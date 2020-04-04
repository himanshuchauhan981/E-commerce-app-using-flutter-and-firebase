import React, { Component } from 'react';
import { View, Text,StyleSheet,TextInput,TouchableOpacity } from 'react-native';
import { Actions } from 'react-native-router-flux'

import { ValidationService } from '../components/ValidationService'

class SignIn extends Component {

   constructor(props){
      super(props)

      this.state = {
         email: { error: null, value: '', type: 'generic' },
         password: { error: null, value: '', type: 'generic' }
      }

      this.onChangeText = ValidationService.onInputChange.bind(this)
      this.getFormValidation = ValidationService.getFormValidation.bind(this)
      this.submit = this.submit.bind(this)
   }

   signUp(){
      Actions.signup()
   }

   submit(){
      let error = this.getFormValidation()
      if(!error){

      }
   }

   renderError(id) {
      const stateValue = this.state[id]
      if (stateValue.error) {
         return <Text style={styles.error}>{stateValue.error}</Text>;
      }
   }

   render(){
      return(
         <View style={styles.loginCont}>
            <Text style={styles.loginText}>Sign In</Text>
            <View style={styles.inputCont}>
               <View>
                  <TextInput
                     style={styles.loginInput}
                     placeholder="Email or Phone number"
                     onChangeText={(text) => this.onChangeText('email', text)}
                  />
                  {this.renderError('email')}
               </View>
               <View>
                  <TextInput
                     style={styles.loginInput}
                     placeholder="Password"
                     secureTextEntry={true}
                     onChangeText={(text) => this.onChangeText('password', text)}
                  />
                  {this.renderError('password')}
               </View>
               <View style={styles.btnCont}>
                  <TouchableOpacity>
                     <Text style={styles.signInBtn}>Sign In</Text>
                  </TouchableOpacity>
                  <Text style={styles.signInText}>Or</Text>
                  <TouchableOpacity onPress={this.signUp}>
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
   },
   error: {
      position: 'absolute',
      bottom: 15,
      color: 'red',
      paddingLeft: 20
   }
})

export default SignIn