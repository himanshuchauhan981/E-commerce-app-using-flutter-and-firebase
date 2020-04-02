import React from 'react';
import { Router, Scene, Stack } from 'react-native-router-flux'

import InitialScreen from './Initial'

const Routes = () => {
   return (
      <Router>
         <Scene key="root">
            <Scene key="initialScreen" component={InitialScreen} initial hideNavBar />
         </Scene>
      </Router>
   )
}

export default Routes;
