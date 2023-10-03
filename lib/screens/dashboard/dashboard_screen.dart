import 'package:expense_tracker/constants/constant_colors.dart';
import 'package:expense_tracker/helpers/helper_ui.dart';
import 'package:expense_tracker/screens/dashboard/widgets/dasboard_widgets.dart';
import 'package:expense_tracker/screens/expenses/widgets/expenses_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
 List<Color> gradientColors = [
    Colors.cyanAccent,
    Colors.blueAccent,
  ];
 int touchedIndex = -1;
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:lightColor,
      body: SafeArea(
        child: Column(
          children: [
             customtext("Expenses Tracker", mainColor,26, FontWeight.bold),
            verticalSpaceresponsive(0.01, context),  
            customtext("Monthly", textColor,22, FontWeight.bold),
            verticalSpaceresponsive(0.01, context),    
            Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 18,
                      left: 12,
                      top: 24,
                      bottom: 12,
                    ),
                    child: LineChart(
                      showAvg ? avgData() : mainData(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 34,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'avg',
                      style: TextStyle(
                        fontSize: 12,
                        color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            verticalSpaceresponsive(0.03, context),
            customtext("Weekly", textColor,22, FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}