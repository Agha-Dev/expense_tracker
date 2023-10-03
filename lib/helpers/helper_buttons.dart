
  import 'package:flutter/material.dart';

import '../constants/constant_colors.dart';
import '../services/size_config_services.dart';
import 'helper_ui.dart';

SizedBox mainButton(BuildContext context,String title,VoidCallback fun) {
    return SizedBox(
                      height: getProportionateScreenHeight(56, context),
                      width: getProportionateScreenWidth(327, context),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColor,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: fun,
                          child: customtext(
                              title,
                              Colors.white,
                              16,
                              FontWeight.normal)),
                    );
  }