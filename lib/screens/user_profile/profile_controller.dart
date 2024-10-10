
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/empdetails.dart';
import '../../services/user_services.dart';

class ProfileController extends GetxController {
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



