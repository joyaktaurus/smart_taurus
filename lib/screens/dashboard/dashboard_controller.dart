import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/empdetails.dart';
import '../../services/user_services.dart';

class DashboardController extends GetxController {
  var employee = Employee().obs;
  var imagePath = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeDetails();
  }

  // Fetch employee details from the API
  void fetchEmployeeDetails() async {
    try {
      isLoading(true);
      var response = await EmpDetailServices.fetchEmpDetails(1);  // Pass any needed parameter like shopId
      if (response.ok) {
        var jsonData = response.rdata;  // Parse the API response
        var employeeData = LeadListing.fromJson(jsonData);  // Use LeadListing to parse
        employee.value = employeeData.employee!;  // Set employee data
        imagePath.value = employeeData.imagePath ?? '';
      } else {
        // Handle error or no data
        employee.value = Employee();  // Set empty data
      }
    } catch (e) {
      print("Error fetching employee details: $e");
    } finally {
      isLoading(false);
    }
  }
}


// The error occurs because the imagePath field is part of the EmpDetails
// class, not the Employee class. Since you're trying to access
// imagePath from the Employee object, it results in the error.
//
// To fix this, you'll need to pass the imagePath from the EmpDetails
// object to the view or use it directly from where EmpDetails is parsed in your controller.
//
// Here's the solution:
//
// Add imagePath as an observable in your controller (since it belongs to EmpDetails).
// Use this observable in your view when constructing the image URL.
// Modify the Controller:
// Update the DashboardController to store the imagePath as well.