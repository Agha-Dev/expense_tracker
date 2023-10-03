import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_buttons.dart';
import 'package:expense_tracker/helpers/helper_fields.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:expense_tracker/models/expenses_model.dart';
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
  String category="";
  List<Expenses>? expensesData = [];
  List<Expenses> expense = [];
    getUser() async {
    final res = await Auth().getUserData();
    setState(() {
      user = res;
     
    });
  }
  Future getCart() async {
    final expensesList = await Auth().getExpensesData(user!.uid);
    setState(() {
      expensesData = expensesList;
    });
  }
    UserModel? user;
    @override
    void initState() {
      super.initState();
      getUser();
      getCart();
    }
  
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return user == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        :  Scaffold(
     
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                             verticalSpaceresponsive(0.01, context), 
                             customtext("Add Expenses", textColor,20, FontWeight.bold),
                             verticalSpaceresponsive(0.005, context),
                             expensesTextFields("Description","Description", description, TextInputType.text),
                             verticalSpaceresponsive(0.005, context),
                             expensesTextFields("Amount","Amount", amount, TextInputType.number),
                             verticalSpaceresponsive(0.005, context),
                              Padding(
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
                          
                                  onChanged: (val) {
                                  setState(() {
                                    category=val.name.toString();
                                  });
                                  
                                  },
                                ),
                              ),
                            ),
                          ),
                             verticalSpaceresponsive(0.01, context),
                             DateSelectionWidget(),
                              verticalSpaceresponsive(0.015, context),
                             mainButton(context, "Save", () async {
                                            final res = Auth().addToExpenses(user!.uid,
                           description.text, int.parse(amount.text), category,  Random().nextInt(1000).toString(),DateTime(selectedDate.year, selectedDate.month, selectedDate.day));
                        
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
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                            .collection('user')
                            .doc(user!.uid)
                            .collection('expenses')
                            .snapshots(),
                            
                  builder: (context, snapshot) {
                    int i=0;
                    if (snapshot.hasData) {
                           
                            List<Expenses> expensesItemsam = [];
                            for (var element in snapshot.data!.docs) {
                              expensesItemsam.add(Expenses.fromJson(
                                  element.data() as Map<String, dynamic>));
                             
                              expense.add(expensesItemsam[i]);
                              i++;
                            }

                    return ListView.builder(
                      shrinkWrap:true,
                      physics:NeverScrollableScrollPhysics(),
                      itemCount:expensesItemsam.length,
                      itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: slideableContainer(width, context, expensesItemsam[index].category, expensesItemsam[index].amount.toString(), "${expensesItemsam[index].date.toDate().day.toString()}-${expensesItemsam[index].date.toDate().month.toString()}-${expensesItemsam[index].date.toDate().year.toString()}", expensesItemsam[index].description,(){
                              Auth().deleteFromExpenses(user!.uid, "${snapshot.data?.docs[index].id}");
                            },(){}),
                          );  
                
                      });
                    }
                    return const Center(
                              child: CircularProgressIndicator());
                  }
                  
                ),
                verticalSpaceresponsive(0.03, context)
              ],
            ),
          ],
        ),
      ),
    );
  }
}