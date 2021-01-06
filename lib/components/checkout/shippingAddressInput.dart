import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:app_frontend/services/validateService.dart';

class ShippingAddressInput extends StatefulWidget {
  final HashMap addressValues;
  final void Function () validateInput;

  ShippingAddressInput(this.addressValues, this.validateInput);
  @override
  _ShippingAddressInputState createState() => _ShippingAddressInputState();
}

class _ShippingAddressInputState extends State<ShippingAddressInput> {
  HashMap addressValues = new HashMap();

  InputDecoration customBorder(String hintText, IconData textIcon){
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black)
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent)
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent)
      ),
      hintText: hintText,
      prefixIcon: Icon(textIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    ValidateService _validateService = new ValidateService();
    return Column(
      children: <Widget>[
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0),
              decoration: customBorder('Full Name',Icons.person),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['name'] = val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0),
              decoration: customBorder('Mobile number',Icons.call),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^[^._]+$")),
                LengthLimitingTextInputFormatter(10)
              ],
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['mobileNumber'] = val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black)
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0),
              decoration: customBorder('PIN code', Icons.code),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r"^[^._]+$")),
                LengthLimitingTextInputFormatter(6)
              ],
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['pinCode']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0),
              decoration: customBorder('Flat, House no, Apartment', Icons.home),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) =>widget.addressValues['address']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0),
              decoration: customBorder('Area, Colony, Street, Sector, Village', Icons.location_city),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['area']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              decoration: customBorder('Landmark', Icons.location_city),
              style: TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['landMark']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              decoration: customBorder('City', Icons.location_city),
              style: TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['city']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 80.0,
          child: Theme(
            child: TextFormField(
              decoration: customBorder('State', Icons.location_city),
              style: TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.text,
              validator: (value) => _validateService.isEmptyField(value),
              onSaved: (String val) => widget.addressValues['state']= val
            ),
            data: Theme.of(context).copyWith(primaryColor: Colors.black),
          ),
        ),
        ButtonTheme(
          minWidth: MediaQuery.of(context).size.width /3.2,
          child: OutlineButton(
            onPressed: (){
              widget.validateInput();
            },
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            borderSide: BorderSide(color: Colors.black,width: 1.8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
        )
      ],
    );
  }
}
