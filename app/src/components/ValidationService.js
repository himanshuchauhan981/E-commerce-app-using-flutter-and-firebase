import validatejs from 'validate.js'

import { validationDictionary } from './dictionary'
import validate from 'validate.js'

function onInputChange(id, value) {
   let oldValues = this.state[id]
   this.setState({
      [id]: {
         ...oldValues,
         value,
         error: getInputValidationState(value, oldValues['type'])
      }
   })
}

function getInputValidationState(value, type) { 
   const result = validatejs(
      { [type]: value },
      { [type]: validationDictionary[type] }
   )
   if (result) {
      return result[type][0]
   }
   return null
}

function getFormValidation() {
   let state = this.state

   let error = false
   for (const [key, value] of Object.entries(state)) {
      state[key].error = getInputValidationState(state[key].value,state[key].type)
      if(state[key].error){
         error = true
      }
   }
   this.setState(state)
   return error
}

export const ValidationService = {
   onInputChange,
   getInputValidationState,
   getFormValidation
};