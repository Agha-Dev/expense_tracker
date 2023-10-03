import 'dart:math';

import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_buttons.dart';
import 'package:expense_tracker/helpers/helper_fields.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:expense_tracker/models/user_model.dart';
import 'package:expense_tracker/screens/expenses/widgets/expenses_widget.dart';
import 'package:expense_tracker/services/navigation_services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../services/auth_services.dart';
import '../bottom_nav_bar/nav_bar.dart';

class ExpensesMain extends StatefulWidget {
  const ExpensesMain({super.key});

  @override
  State<StatefulWidget> createState() => ExpensesMainState();
}

class ExpensesMainState extends State {
  int touchedIndex = -1;
  TextEditingController description=TextEditingController();
  TextEditingController amount=TextEditingController();
  TextEditingController date=TextEditingController();
   DateTime selectedDate = DateTime.now();
  TextEditingController category=TextEditingController();
    UserModel? user;
    @override
    void initState() {
      super.initState();
      getUser();
    }
    getUser() async {
    final res = await Auth().getUserData();
    setState(() {
      user = res;
     
    });
  }
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
     
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom:60.0),
        child: FloatingActionButton(
          onPressed: () { 
            showModalBottomSheet(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20.0))),
                    context: context,
                    builder: (BuildContext context) {
                      return  SizedBox(
                        height: 850,
                        child: Column(
                          children: [
                           verticalSpaceresponsive(0.01, context), 
                           customtext("Add Expenses", textColor,20, FontWeight.bold),
                           verticalSpaceresponsive(0.005, context),
                           expensesTextFields("Description","Description", description, TextInputType.text),
                           verticalSpaceresponsive(0.005, context),
                           expensesTextFields("Amount","Amount", amount, TextInputType.number),
                           verticalSpaceresponsive(0.005, context),
                           customDropDownCategory(),
                           verticalSpaceresponsive(0.01, context),
                           DateSelectionWidget(),
                            verticalSpaceresponsive(0.015, context),
                           mainButton(context, "Save", () async {
                    final res = Auth().addToExpenses(user!.uid,
                         description.text, int.parse(amount.text), category.text,  Random().nextInt(1000).toString(),DateTime.now().toLocal());

                    if (res == 300) {
                      showSnackbarText(
                          "Not Added facing Technical Issues!", context);
                    } else {
                      showSnackbarText("Added To Expenses Successfuly", context);
                      Nav.pushNav(context,  CustomBottomBar());
                    }
                    
                  },)

                          ],
                        ),
                      );
                    },
                  );
           },
          child: Icon(Icons.add),
          backgroundColor: mainColor,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        ),
      ),
  
      backgroundColor: lightColor,
      body: SafeArea(
        child: ListView(
         physics:BouncingScrollPhysics(),
          children: [
            Column(
              children: [
                customtext("Expenses", mainColor, 26, FontWeight.bold),
                AspectRatio(
                  aspectRatio: 1.3,
                  child: Row(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: showingSections(touchedIndex),
                            ),
                          ),
                        ),
                      ),
                       indicatorsList(),
                      const SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
                customtext("Details", textColor, 22, FontWeight.bold),
                verticalSpaceresponsive(0.015, context),
                ListView.builder(
                  shrinkWrap:true,
                  physics:NeverScrollableScrollPhysics(),
                  itemCount:3,
                  itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: slideableContainer(width, context),
                      );  

                  }),
                verticalSpaceresponsive(0.03, context)
              ],
            ),
          ],
        ),
      ),
    );
  }
}