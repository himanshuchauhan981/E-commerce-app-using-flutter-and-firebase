import 'dart:collection';

import 'package:app_frontend/services/validateService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShippingAddressInput extends StatefulWidget {
  final void Function (String key,dynamic value) setAddressValues;

  ShippingAddressInput(this.setAddressValues);
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
      hintText: hintText,
      prefixIcon: Icon(textIcon),
    );
  }

  @override
  Widget build(BuildContext context) {
    ValidateService _validateService = new ValidateService();
    return Column(
      children: <Widget>[
        Theme(
          child: TextFormField(
            style: TextStyle(fontSize: 16.0),
            decoration: customBorder('Full Name',Icons.person),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('fullName',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            style: TextStyle(fontSize: 16.0),
            decoration: customBorder('Mobile number',Icons.call),
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"^[^._]+$"))
            ],
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('mobileNumber',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black)
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            style: TextStyle(fontSize: 16.0),
            decoration: customBorder('PIN code', Icons.code),
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"^[^._]+$"))
            ],
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('pinCode',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            style: TextStyle(fontSize: 16.0),
            decoration: customBorder('Flat, House no, Apartment', Icons.home),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) =>widget.setAddressValues('address',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            style: TextStyle(fontSize: 16.0),
            decoration: customBorder('Area, Colony, Street, Sector, Village', Icons.location_city),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('area',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            decoration: customBorder('Landmark', Icons.location_city),
            style: TextStyle(fontSize: 16.0),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('landMark',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            decoration: customBorder('City', Icons.location_city),
            style: TextStyle(fontSize: 16.0),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('city',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
        SizedBox(height: 15.0),
        Theme(
          child: TextFormField(
            decoration: customBorder('State', Icons.location_city),
            style: TextStyle(fontSize: 16.0),
            keyboardType: TextInputType.text,
            validator: (value) => _validateService.isEmptyField(value),
            onSaved: (String val) => widget.setAddressValues('state',val)
          ),
          data: Theme.of(context).copyWith(primaryColor: Colors.black),
        ),
      ],
    );
  }
}
