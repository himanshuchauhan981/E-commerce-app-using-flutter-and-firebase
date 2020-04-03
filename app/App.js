import React, { Component } from 'react';
import { StyleSheet, View } from 'react-native';
import { Provider } from 'react-redux'
import { PersistGate } from 'redux-persist/integration/react'

import Main from './src/Main'
import persist from './src/config/store'

const persistStore = persist()

class App extends Component {
	render() {
		return (
			<Provider store={persistStore.store}>
				<PersistGate loading={null} persistor={persistStore.persistor}>
				<View style={styles.container}>
					<Main />
				</View>
				</PersistGate>
			</Provider>
		)
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1
	}
});

export default App;
