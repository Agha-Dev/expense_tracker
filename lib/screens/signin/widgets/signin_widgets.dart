
  import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:flutter/material.dart';

import '../../../helpers/helper_ui.dart';

GestureDetector titleNavigation(String title,String subtitle,VoidCallback fun) {
    return GestureDetector(
                      onTap: fun,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: customtext(
                               title,
                                textColor,
                                12,
                                FontWeight.normal),
                          ),
                          customtext(
                              subtitle,
                              mainColor,
                              12,
                              FontWeight.normal),
                        ],
                      ),
                    );
  }
  
  GestureDetector rightText(String title,VoidCallback fun) {
    return GestureDetector(
                      onTap:fun,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            customtext(
                                title,
                                greyColor,
                                12,
                                FontWeight.bold),
                          ],
                        ),
                      ),
                    );
  }