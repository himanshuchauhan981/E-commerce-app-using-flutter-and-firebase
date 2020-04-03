import React from 'react';
import { Router, Scene } from 'react-native-router-flux'

import InitialScreen from './Initial'
import SignIn from '../screens/SignIn'
const Routes = () => {
   return (
      <Router>
         <Scene key="root">
            <Scene key="initialScreen" component={InitialScreen} initial hideNavBar />
            <Scene key="login" component={SignIn} />
         </Scene>
      </Router>
   )
}

export default Routes;
