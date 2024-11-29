import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/api_resp.dart';
import '../../models/empdetails.dart';
import '../../models/order_status_model.dart';
import '../../services/order_status_services.dart';
import '../../services/user_services.dart';

class ProfileController extends GetxController {
  var employee = Employee().obs;
  var imagePath = ''.obs;
  var isLoading = true.obs;

  List<String> months = [
    "January 2024",
    "February 2024",
    "March 2024",
    "April 2024",
    "May 2024",
    "June 2024",
    "July 2024",
    "August 2024",
    "September 2024",
    "October 2024",
    "November 2024",
    "December 2024",
  ];

  // Selected month (default value)
  var selectedMonth = "November 2024".obs;
  var selectedIndex = Rx<int?>(null); // Track selected item index
  RxList<Order> orderListData = <Order>[].obs;

  RxBool isScreenProgress = true.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchOrderList() async {
    try {
      final ApiResp resp = await OrderStatusServices.getOrderList();
      if (resp.ok) {
        // Parse the order list data
        final orderStatusModel = OrderStatusModel.fromJson(resp.rdata);
        final ordersData = orderStatusModel.orders ?? [];

        // Assign the full Order data to orderListData
        orderListData.assignAll(ordersData);

        isScreenProgress.value = false; // Hide progress indicator
        print('Order data fetched successfully: ${orderListData.length} items');
      } else {
        // Handle API response failure
        isScreenProgress.value = false;
        print('Error fetching order data: ${resp.msgs}');
      }
    } catch (e) {
      // Handle errors during data fetching
      isScreenProgress.value = false;
      print('Error fetching order data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeDetails();
    fetchOrderList();
  }

  // Fetch employee details from the API
  void fetchEmployeeDetails() async {
    try {
      isLoading(true);
      var response = await EmpDetailServices.fetchEmpDetails(
          1); // Pass any needed parameter like shopId
      if (response.ok) {
        var jsonData = response.rdata; // Parse the API response
        var employeeData =
            LeadListing.fromJson(jsonData); // Use LeadListing to parse
        employee.value = employeeData.employee!; // Set employee data
        imagePath.value = employeeData.imagePath ?? '';
      } else {
        // Handle error or no data
        employee.value = Employee(); // Set empty data
      }
    } catch (e) {
      print("Error fetching employee details: $e");
    } finally {
      isLoading(false);
    }
  }
}
