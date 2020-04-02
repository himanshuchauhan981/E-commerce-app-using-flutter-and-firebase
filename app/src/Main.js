import React, { Component } from 'react'
import { View, Text, StatusBar, StyleSheet } from 'react-native'

import Routes from './components/Routes'

class Main extends Component {
   render() {
      return (
         <View style={styles.container}>
            <StatusBar
               backgroundColor="#768FFF"
            ></StatusBar>
            <Routes />
         </View>
      )
   }
}

const styles = StyleSheet.create({
   container: {
      flex: 1,
   }
});

export default Main