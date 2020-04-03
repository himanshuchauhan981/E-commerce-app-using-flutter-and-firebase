import React from 'react';
import { Router, Scene } from 'react-native-router-flux'

import InitialScreen from './Initial'
import SignIn from '../screens/SignIn'
import SignUp from '../screens/SignUp'

const Routes = () => {
   return (
      <Router>
         <Scene key="root">
            <Scene key="initialScreen" component={InitialScreen} initial hideNavBar />
            <Scene key="login" component={SignIn} />
            <Scene key="signup" component={SignUp} />
         </Scene>
      </Router>
   )
}

export default Routes;
