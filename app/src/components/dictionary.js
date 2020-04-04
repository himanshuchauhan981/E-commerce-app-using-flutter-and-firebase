export const validationDictionary = {
   email: {
      presence: {
         allowEmpty: false,
         message: "^Required"
      },
      email: {
         message: "^Invalid Email"
      }
   },

   generic: {
      presence: {
         allowEmpty: false,
         message: "^Required"
      }
   },
   
   password: {
      presence: {
         allowEmpty: false,
         message: "^Required"
      },
      length: {
         minimum: 6,
         message: "^Password must be at least 6 characters long"
      }
   },

   phone: {
      presence: {
         allowEmpty: false,
         message: "^Required"
      },
      format: {
         pattern: /^([8-9]{1})([0-9]{9})/,
         message: "^ Invalid Mobile number"
      }
   }
}