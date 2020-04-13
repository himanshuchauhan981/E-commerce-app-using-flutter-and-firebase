class ValidateService{
  String isEmptyField(String value){
    if(value.isEmpty){
      return 'Required';
    }
    return null;
  }
}