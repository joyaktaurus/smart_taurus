import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/empdetails.dart';
import '../../services/user_services.dart';

class DashboardController extends GetxController {
  var employee = Employee().obs; // Observable employee object
  var imagePath = ''.obs; // Store image path from EmpDetails
  var isLoading = true.obs; // Loading indicator

  @override
  void onInit() {
    super.onInit();
    fetchEmployeeDetails(); // Fetch the employee details when the controller is initialized
  }

  // Fetch employee details from API
  void fetchEmployeeDetails() async {
    try {
      isLoading(true);
      var response = await EmpDetailServices.fetchEmpDetails(1); // Pass the shopId here
      if (response.ok) {
        // Parse the employee data from the API response
        var empDetails = EmpDetails.fromJson(response.rdata);
        if (empDetails.employee != null && empDetails.employee!.isNotEmpty) {
          employee.value = empDetails.employee!.first; // Set the first employee details
          imagePath.value = empDetails.imagePath ?? ''; // Set the image path from EmpDetails
        }
      } else {
        // Handle error or display a message
        print("Error fetching employee details");
      }
    } finally {
      isLoading(false); // Stop loading after API call
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