import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_taurus/utils/my_theme.dart';
import 'package:intl/intl.dart';

import '../../models/api_resp.dart';
import '../../models/sales_graph_model.dart';
import '../../models/sales_graph_model.dart';
import '../../models/sales_graph_model.dart';
import '../../models/sales_graph_model.dart';
import '../../services/sales_graph_services.dart';

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
  RxBool isScreenProgress = true.obs;

  var weeklyData = <WeeklySalesReport>[].obs;
  var monthlyData = <MonthlySalesReport>[].obs;
  var yearlyData = <YearlySalesReport>[].obs; // Store Order data
  var weekDates = <String>[].obs; // Stores weekly sales report dates
  var selectedWeekDate = ''.obs; // Default value for second dropdown

  void setWeekDates(List<WeeklySalesReport> weeklyData) {
    weekDates.value = weeklyData.map((report) => report.date).cast<String>().toList();
  }

  @override
  void onInit() {
    super.onInit();
    String startDate = getStartDate();  // Dynamically fetched
    String endDate = getEndDate();      // Dynamically fetched
    String year = DateTime.now().year.toString();
    fetchSalesData(getStartDate(), getEndDate(), DateTime.now().year.toString());
  }

  String getStartDate() {
    // Return first day of current week or month dynamically
    DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-01";  // Start of month
  }

  String getEndDate() {
    DateTime now = DateTime.now();
    return "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day}";  // Current date
  }
  Future<void> fetchSalesData(String startDate, String endDate, String year) async {
    try {
      final ApiResp resp = await SalesGraphServices.fetchGraphDetails(startDate, endDate, year);
      if (resp.ok) {
        final salesData = SalesGraphModel.fromJson(resp.rdata);

        weeklyData.assignAll(salesData.weeklySalesReport ?? []);
        monthlyData.assignAll(salesData.monthlySalesReport?.values.toList() ?? []);
        yearlyData.assignAll(salesData.yearlySalesReport ?? []);

        setWeekDates(weeklyData); // Populate weekDates list

        isScreenProgress.value = false;
      }
      else {
        isScreenProgress.value = false;
        print('Error: ${resp.msgs}');
      }
    } catch (e) {
      isScreenProgress.value = false;
      print('Error: $e');
    }
  }

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
