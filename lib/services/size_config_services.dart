import 'package:flutter/material.dart';

double getProportionateScreenHeight(double inputHeight,context) {
  return (inputHeight / 812.0) * MediaQuery.of(context).size.height;
}

double getProportionateScreenWidth(double inputWidth,context) {
  return (inputWidth / 375.0) * MediaQuery.of(context).size.width;
}
