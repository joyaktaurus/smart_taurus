import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../models/customer_detail_model.dart';
import '../../models/product_listing_model.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'add_order_controller.dart';

class AddOrderView extends GetView<AddOrderController> {
  final String productName;
  final double finalAmount;

  const AddOrderView({
    Key? key,
    required this.productName,
    required this.finalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ProductListing> addedProducts = <ProductListing>[].obs;
    return GestureDetector(
      onTap: () {
        MyUtils.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Center(
            child: Text(
              'Add Order',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notification_add_outlined,
                  color: Colors.black),
              onPressed: () {
                Get.toNamed(Routes.dashBoard);
              },
            ),
          ],
          centerTitle: true,
        ),
        drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 0.3,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.deepPurpleAccent,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              // Show the dropdown by fetching customer data
                              controller.showDropdown
                                  .toggle(); // Toggle dropdown visibility
                              controller.initialCustomersList();
                            },
                            icon: const Icon(Icons.add),
                            color: Colors.deepPurpleAccent,
                          ),
                          const Text(
                            "Add Party",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      Obx(() {
                        // Show the selected shop name if any shop is selected
                        if (controller.selectedShop.isNotEmpty) {
                          final selectedShop =
                              controller.customerData.firstWhere(
                            (shop) =>
                                shop.intShopId.toString() ==
                                controller.selectedShop.value,
                          );
                          return Text(
                            selectedShop.shopName ?? 'Unnamed Shop',
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          );
                        }
                        return const SizedBox();
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                // Show dropdown only when `showDropdown` is true
                if (controller.showDropdown.isTrue) {
                  if (controller.isScreenProgress.isTrue) {
                    return const CircularProgressIndicator();
                  }
                  if (controller.customerData.isEmpty) {
                    return const Text('No shops available');
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.deepPurpleAccent, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        hint: const Text('Select Shop'),
                        value: controller.selectedShop.isNotEmpty
                            ? controller.selectedShop.value
                            : null,
                        // Selected value from the dropdown
                        items: controller.customerData.map((shop) {
                          return DropdownMenuItem<String>(
                            value: shop.intShopId.toString(),
                            child: Text(shop.shopName ?? 'Unnamed Shop'),
                          );
                        }).toList(),
                        onChanged: (selectedValue) {
                          // Handle shop selection and hide dropdown
                          controller.selectShop(selectedValue!);
                          controller.showDropdown.value =
                              false; // Hide the dropdown
                          print('Selected shop: $selectedValue');
                        },
                      ),
                    ),
                  );
                } else {
                  return const SizedBox(); // Hide dropdown when not active
                }
              }),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Products",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                      fontSize: 18),
                ),
              ),
            Container(
              height: 300,
              width: 800,
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                        Container(
                          color: Colors.white, // Background color for the list tile
                          margin: const EdgeInsets.symmetric(vertical: 4.0), // Add margin for spacing between tiles
                          child: Padding(
                            padding: const EdgeInsets.all(4.0), // Padding inside each tile
                            child: ListTile(
                              title: Text(
                                productName,
                                style: TextStyle(fontSize: 16),
                              ),

                              trailing: Text(
                                "\$${finalAmount.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 16),
                              ),
                              tileColor: Colors.white, // Background color inside the ListTile
                              dense: true, // Makes the ListTile more compact
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to product listing to add a product
                    Get.toNamed(Routes.productListing)?.then((result) {
                      if (result != null && result is ProductListing) {
                        // Assuming `result` contains the selected product
                        addedProducts.add(result); // Add the product to the list
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurpleAccent),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          "Add Product",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Final Amount",
                    style: MyTheme.regularTextStyle(
                      fontSize: Get.height * .016,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    "",
                    style: MyTheme.regularTextStyle(
                      fontSize: Get.height * .016,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
