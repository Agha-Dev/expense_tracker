import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../constants/constant_colors.dart';

Padding customtextfields(bool obsecure, String label, String hint,
    TextEditingController controller, bool sicon, TextInputType inputtype,bool showpass,VoidCallback fun) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    child: TextFormField(
      keyboardType: inputtype,
      controller: controller,
      obscureText: obsecure,
      cursorColor: mainColor,
      decoration: InputDecoration(
          suffixIcon: sicon == true
              ? InkWell(
                onTap: fun,
                child:  Icon(
                   showpass==false? Icons.remove_red_eye:Icons.visibility_off,
                    color: greyColor,
                  ),
              )
              : null,
          labelText: label,
          hintText: hint,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 107, 108, 110)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mainColor))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Field can't be Empty";
        }
        return null;
      },
    ),
  );
}

Padding expensesTextFields( String label, String hint,
    TextEditingController controller, TextInputType inputtype,) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    child: TextFormField(
      keyboardType: inputtype,
      controller: controller,
      cursorColor: mainColor,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 107, 108, 110)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mainColor))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Field can't be Empty";
        }
        return null;
      },
    ),
  );
}
Padding dateFields( String label, String hint,
    TextEditingController controller, TextInputType inputtype,) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    child: TextFormField(
      keyboardType: inputtype,
      readOnly:true,
      controller: controller,
      cursorColor: mainColor,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          labelStyle:
              const TextStyle(color: Color.fromARGB(255, 107, 108, 110)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(10),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: mainColor))),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "Field can't be Empty";
        }
        return null;
      },
    ),
  );
}
Padding customDropDownCategory() {
  return Padding(
    padding: const  EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    child: Container(
      height: 58,
      decoration: BoxDecoration(
         border: Border.all(color:greyColor),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: DropDownTextField(
          initialValue: "Select Category",
          listSpace: 10,          
          listPadding: ListPadding(top: 10),
          textFieldDecoration: const InputDecoration(
            border: InputBorder.none),
          enableSearch: false,
          validator: (value) {
            if (value == null) {
              return "Required field";
            } else {
              return null;
            }
          },
          dropDownList: const [
            DropDownValueModel(name: 'Select Category', value: "value1"),
            DropDownValueModel(name: 'Food', value: "value2"),
            DropDownValueModel(name: 'Transportation', value: "value3"),
            DropDownValueModel(name: 'Entertainment', value: "value4"),
            DropDownValueModel(name: 'Studies', value: "value5"),
        
          ],
          listTextStyle: const TextStyle(color: Color.fromARGB(255, 107, 108, 110)),
          dropDownItemCount: 5,
  
          onChanged: (val) {},
        ),
      ),
    ),
  );
}