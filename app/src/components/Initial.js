import React, { Component } from 'react';
import { StyleSheet, View, Text, Image, TouchableOpacity } from 'react-native';
import { Actions } from 'react-native-router-flux'

class InitialScreen extends Component {

	loginScreen(){
		Actions.login()
	}
	
	signupScreen(){
		Actions.signup()
	}
	
	render() {
		return (
			<View style={styles.container}>
				<Image style={styles.logo} source={require('../assets/logo.png')} />
				<Text style={styles.logoText}>Welcome to Shop mart</Text>
				<View style={styles.btnCont}>
					<TouchableOpacity onPress={this.loginScreen}>
						<Text style={styles.button}>Login</Text>
					</TouchableOpacity>
					<TouchableOpacity onPress={this.signupScreen}>
						<Text style={styles.button}>Signup</Text>
					</TouchableOpacity>
				</View>
			</View>
		)
	}
}

const styles = StyleSheet.create({
	logo: {
		width: 200,
		height: 200
	},
	container: {
		flex: 1,
		justifyContent: 'center',
		alignItems: 'center',
		backgroundColor: '#2962FF'
	},
	logoText: {
		fontSize: 30,
		fontWeight: 'bold',
		marginTop: 55
	},
	btnCont: {
		paddingVertical: 70
	},
	button: {
		width: 200,
		fontSize: 20,
		backgroundColor: '#768FFF',
		borderRadius: 25,
		marginVertical: 10,
		paddingVertical: 13,
		textAlign: 'center',
		color: 'white',
		letterSpacing: 2
	}
});

export default InitialScreen;
