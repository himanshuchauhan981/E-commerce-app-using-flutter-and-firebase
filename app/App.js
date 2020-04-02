import React, { Component } from 'react';
import { StyleSheet, View } from 'react-native';

import Main from './src/Main'

class App extends Component {
	render() {
		return (
			<View style={styles.container}>
				<Main />
			</View>

		)
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1
	}
});

export default App;
