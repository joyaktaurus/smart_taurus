import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_taurus/utils/my_theme.dart';

class SalesReportController extends GetxController {
  // Observable variable for the selected dropdown value
  var selectedValue = 'Weeks'.obs; // Default value is 'Weeks'

  // Function to update the selected value
  void updateSelectedValue(String value) {
    selectedValue.value = value;
  }

  var selectedIndex = RxInt(-1); // Initially no selection

  // Method to update the selected index
  void onTextClick(int index) {
    selectedIndex.value = index; // Update the selected index
  }

  final List<int> salesData = [30, 60, 50, 80, 40, 70]; // Example data

  List<BarChartGroupData> getBarChartData() {
    return List.generate(salesData.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: salesData[index].toDouble(),
            width: 30,
            borderRadius: BorderRadius.circular(0),
            gradient: LinearGradient(
              colors: [MyTheme.appColor, Colors.lightBlueAccent],
              // Gradient colors
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ],
      );
    });
  }

  // Bottom labels: Weekdays
  Widget getBottomTitles(double value, TitleMeta meta) {
    const labels = ['1 Nov', '2 Nov', '3 Nov', '4 Nov', '5 Nov', '6 Nov'];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        labels[value.toInt()],
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Left labels: Numerical values
  Widget getLeftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, // You can increase this value if needed
      child: Text(
        value.toInt().toString(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.visible, // Ensure it stays on one line
        ),
        softWrap: false, // Prevents text from breaking into multiple lines
      ),
    );
  }
}
