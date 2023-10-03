 import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
//PIE CHART WITH DETAILS
List<PieChartSectionData> showingSections(int touchedIndex) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blueAccent,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellowAccent,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:textColor,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purpleAccent,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: textColor,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color:Colors.greenAccent,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color:textColor,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
  // INDICATORS LIST
  Column indicatorsList() {
    return const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Indicator(
                        color: Colors.blueAccent,
                        text: 'Food',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.yellowAccent,
                        text: 'Transportation',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.purpleAccent,
                        text: 'Entertainment',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Indicator(
                        color: Colors.greenAccent,
                        text: 'Studies',
                        isSquare: true,
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  );
  }
  //SLIDEABLE CONTAINER

  Slidable slideableContainer(double width, BuildContext context,String category,String amount,String date,String description,VoidCallback delete,VoidCallback edit) {
    return Slidable(
  key: const ValueKey(0),
  startActionPane: ActionPane(
  motion: const ScrollMotion(),
  dismissible: DismissiblePane(onDismissed: () {}),
  children:  [
    SlidableAction(
      onPressed:(context){
        delete;
      },
      backgroundColor: Color(0xFFFE4A49),
      foregroundColor: Colors.white,
      icon: Icons.delete,
      label: 'Delete',
    ),
  ],
),

endActionPane:  ActionPane(
  motion: ScrollMotion(),
  children: [
    SlidableAction(
      onPressed: (context) {
        delete();
      },
      backgroundColor: Color(0xFF0392CF),
      foregroundColor: Colors.white,
      icon: Icons.edit_document,
      label: 'Edit',
    ),
  ],
),
child:  Padding(
  padding: const EdgeInsets.only(left:8.0,right:8),
  child: Container(
    width:width,
    decoration:BoxDecoration(
      color: Color(0xffedeeded),
      borderRadius: BorderRadius.circular(20),   
    ),
  child: Padding(
    padding: const EdgeInsets.only(left:8.0,right:8),
    child: Column(
      children: [
        verticalSpaceresponsive(0.01, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customtext(category, textColor, 20, FontWeight.bold),
            customtext("$amount AED", textColor, 22, FontWeight.bold),
          ],
        ),
        Row(mainAxisAlignment:MainAxisAlignment.start,
        children: [
          customtext(date,mainColor, 18, FontWeight.bold)
        ],
        ),
        verticalSpaceresponsive(0.01, context),
         Row(mainAxisAlignment:MainAxisAlignment.start,
        children: [
          SizedBox(
            width:width*0.90,
            child: customtext(description,textColor, 14, FontWeight.normal))
        ],
        ),
        verticalSpaceresponsive(0.015, context)
      ],
    ),
  ),  
    
    ),
)
);
  }
  class DateSelectionWidget extends StatefulWidget {
  @override
  _DateSelectionWidgetState createState() => _DateSelectionWidgetState();
}

class _DateSelectionWidgetState extends State<DateSelectionWidget> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    dateController.text = "${selectedDate.toLocal()}".split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:16.0,left:16),
      child: SizedBox(
        height: 58.0, 
        child: TextFormField(
          readOnly: true,
          controller: dateController,
          decoration: InputDecoration(
            labelText: 'Date',
            contentPadding: EdgeInsets.symmetric(vertical: 18.0,horizontal:5),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onTap: () => _selectDate(context),
        ),
      ),
    );
  }
}