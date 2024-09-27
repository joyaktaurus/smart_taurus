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

class AddOrderVieww extends GetView<AddOrderController> {
  const AddOrderVieww(
      {Key? key, required this.productName, required this.finalAmount})
      : super(key: key);

  final String productName;
  final double finalAmount;

  @override
  Widget build(BuildContext context) {
    Get.put(
        AddOrderController(productName: productName, finalAmount: finalAmount));

    return GestureDetector(
      onTap: () {
        MyUtils.hideKeyboard();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display added products
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.products.length,
                    itemBuilder: (context, index) {
                      final product = controller.products[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[300],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(product.productName ?? ''),
                                      // Display price based on quantity
                                      Text(
                                          "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}"),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 130,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.green,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // Decrement quantity and update price
                                          controller.countDecrement(product);
                                        },
                                        icon: Icon(Icons.remove,
                                            color: Colors.white, size: 20),
                                      ),
                                      Text(
                                        "${product.quantity}",
                                        // Display the quantity
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Increment quantity and update price
                                          controller.countIncrement(product);
                                        },
                                        icon: Icon(Icons.add,
                                            color: Colors.white, size: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              // Button to add a product
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: GestureDetector(
                  onTap: () {
                    // Navigate to ProductListingView and wait for the result (the selected product)
                    Get.toNamed(Routes.productListing)?.then((result) {
                      if (result != null && result is ProductListing) {
                        controller
                            .addProduct(result); // Add product and update UI
                      }
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurpleAccent,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add),
                          color: Colors.white,
                        ),
                        SizedBox(width: 100),
                        Text("Add Product",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ),
              ),

              // Final Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Final Amount"),
                  Obx(() {
                    return Text(
                        "\$${controller.finalAmount.value.toStringAsFixed(2)}");
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
    Get.put(
        AddOrderController(productName: productName, finalAmount: finalAmount));
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
          child: SingleChildScrollView(
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
                            controller.selectedShop(selectedValue!);
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
                  height: 400,
                  width: 800,
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return ListView.builder(
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          final product = controller.products[index];

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(product.productName ?? ''),
                                          // Display price based on quantity
                                          Text(
                                              "\$${(double.tryParse(product.price ?? '0')! * product.quantity).toStringAsFixed(2)}"),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 130,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.green,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              // Decrement quantity and update price
                                              controller
                                                  .countDecrement(product);
                                            },
                                            icon: Icon(Icons.remove,
                                                color: Colors.white, size: 20),
                                          ),
                                          Text(
                                            "${product.quantity}",
                                            // Display the quantity
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              // Increment quantity and update price
                                              controller
                                                  .countIncrement(product);
                                            },
                                            icon: Icon(Icons.add,
                                                color: Colors.white, size: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to ProductListingView and wait for the result (the selected product)
                      Get.toNamed(Routes.productListing)?.then((result) {
                        if (result != null && result is ProductListing) {
                          controller
                              .addProduct(result); // Add product and update UI
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Final Amount",
                        style: MyTheme.regularTextStyle(
                          fontSize: Get.height * .016,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          "\$${controller.finalAmount.value.toStringAsFixed(2)}",
                          style: MyTheme.regularTextStyle(
                            fontSize: Get.height * .016,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.0),
                  child: GestureDetector(
                    onTap: () {
                      controller.submitOrder();
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.deepPurpleAccent),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
