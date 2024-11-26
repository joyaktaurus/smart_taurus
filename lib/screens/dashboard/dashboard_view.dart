
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:smart_taurus/components/rounded_loader.dart';
import 'package:smart_taurus/screens/task_listing/task_list_controller.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../utils/local_store.dart';
import '../../utils/my_theme.dart';
import '../../utils/my_utils.dart';
import '../../utils/routes.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(TaskListingController());
    return GestureDetector(
        onTap: () {
          MyUtils.hideKeyboard();
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            //  leading:Icon(Icons.menu_outlined, color: MyTheme.appColor,),
            title: Text(
              'Dashboard',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Stack(
                  children: [
                    IconButton(
                      icon: Stack(
                        children: [
                          Icon(Icons.notifications, color: MyTheme.appColor),
                          if (controller.unseenTaskCount.value > 0)
                            Positioned(
                              right: 0,
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.red,
                                child: Text(
                                  '${controller.unseenTaskCount.value}',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ),
                        ],
                      ),
                      onPressed: () {
                        Get.toNamed(Routes.taskListing)?.then((_) {
                          final taskListingController = Get.find<TaskListingController>();
                          taskListingController.onViewTasks(); // Reset count when viewed
                        });
                      },
                    ),
                    // IconButton(
                    //   icon: Stack(
                    //     children: [
                    //       Icon(Icons.notifications),
                    //       if (controller.unseenTaskCount.value > 0)
                    //         Positioned(
                    //           right: 0,
                    //           child: CircleAvatar(
                    //             radius: 8,
                    //             backgroundColor: Colors.red,
                    //             child: Text(
                    //               '${controller.unseenTaskCount.value}',
                    //               style: TextStyle(
                    //                   color: Colors.white, fontSize: 12),
                    //             ),
                    //           ),
                    //         ),
                    //     ],
                    //   ),
                    //   onPressed: () {
                    //     // Navigate to the notification page
                    //     Get.toNamed(Routes.taskListing);
                    //     // Reset unseen count once notifications are viewed
                    //     controller.resetUnseenCount();
                    //   },
                    // ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.logout, color: MyTheme.appColor),
                onPressed: () {
                  LocalStore.clearData();
                  Get.offNamed(Routes.login);
                },
              ),
            ],

            centerTitle: true, // Ensure the title is centered
          ),
          drawer: Drawer(
            // backgroundColor: Colors.blue[100],
            // Set your desired background color here
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: MyTheme.appColor, // Header background color
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          // Observe changes in the loading state and employee data
                          if (controller.isLoading.value) {
                            return Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: RoundedLoader(),
                                )); // Show loader while fetching data
                          }
                          if (controller.employee.value.name == null) {
                            return Center(child: Text("No data available"));
                          }
                          return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(children: [
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: 65,
                                          width: 65,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: controller.employee.value
                                                  .profilePic !=
                                                  null
                                                  ? NetworkImage(
                                                  '${controller.imagePath.value}/${controller.employee.value.profilePic}')
                                                  : AssetImage(
                                                  "assets/images/img.png")
                                              as ImageProvider,
                                              fit: BoxFit
                                                  .cover, // Ensures the image covers the circle area
                                            ),
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //     width: Get.width * 0.02),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text(
                                          controller.employee.value.email ?? '',
                                          style: TextStyle(
                                              fontSize: 16, color: Colors.white),
                                        ),
                                      ),
                                    ])
                              ]));
                        })
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Home'),
                    onTap: () {
                      // Navigate to Home or Dashboard
                      Get.back(); // Close drawer
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.task),
                    title: Text('Tasks'),
                    onTap: () {
                      Get.toNamed(
                          Routes.taskListing); // Replace with your profile route
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.people_alt_outlined),
                    title: Text('Customers'),
                    onTap: () {
                      Get.toNamed(
                          Routes.customerList); // Replace with your settings route
                    },
                  ),
                  // ListTile(
                  //   leading: Icon(Icons.shopping_cart_outlined),
                  //   title: Text('Orders'),
                  //   onTap: () {
                  //     Get.toNamed(
                  //         Routes.addOrder); // Replace with your support route
                  //   },
                  // ),
                  // ListTile(
                  //   leading: Icon(Icons.add_task_outlined),
                  //   title: Text('Order Status'),
                  //   onTap: () {
                  //     Get.toNamed(
                  //         Routes.orderDetails); // Replace with your support route
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(Icons.monetization_on_outlined),
                    title: Text('Expenses'),
                    onTap: () {
                      Get.toNamed(
                          Routes.expenses); // Replace with your support route
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      LocalStore.clearData();
                      Get.offNamed(Routes.login); // Navigate to login screen
                    },
                  ),
                ],
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 0.3, // Height of the grey divider
                  decoration: BoxDecoration(
                    color: Colors.grey, // Grey color for the line
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 1), // Adds elevation effect
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  // Observe changes in the loading state and employee data
                  if (controller.isLoading.value) {
                    return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: RoundedLoader(),
                        )); // Show loader while fetching data
                  }
                  if (controller.employee.value.name == null) {
                    return Center(child: Text("No data available"));
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Container(
                            width: double.infinity,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // Shadow offset
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors
                                                    .black12), // Grey border
                                          ),
                                          child: Center(
                                            child: Container(
                                              height: 65,
                                              width: 65,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: controller.employee.value
                                                      .profilePic !=
                                                      null
                                                      ? NetworkImage(
                                                      '${controller.imagePath.value}/${controller.employee.value.profilePic}')
                                                      : AssetImage(
                                                      "assets/images/img.png")
                                                  as ImageProvider,
                                                  fit: BoxFit
                                                      .cover, // Ensures the image covers the circle area
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.02),
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(top: 15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Hey, ${controller.employee.value.name}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 17),
                                              ),
                                              Text(
                                                controller.employee.value.job ??
                                                    '',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(Routes.profileView);
                                    },
                                    child: Text(
                                      "....",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 130,
                            // Adjust the container height if needed
                            width: 800,
                            // Adjust the width to decrease the overall size
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: MyTheme.appColor,
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 80, // Decreased width
                                        height: 80, // Decreased height
                                        child: SfRadialGauge(
                                          axes: [
                                            RadialAxis(
                                              pointers: [
                                                RangePointer(
                                                  value: 50,
                                                  width: 8,
                                                  cornerStyle:
                                                  CornerStyle.bothCurve,
                                                  gradient: const SweepGradient(
                                                    colors: [
                                                      Color(0xFFFFFFFF),
                                                      Color(0xFFFFFFFF)
                                                    ],
                                                    stops: [0.1, 0.4],
                                                  ),
                                                )
                                              ],
                                              axisLineStyle: AxisLineStyle(
                                                thickness: 8,
                                                color: Colors.red[600],
                                              ),
                                              startAngle: 5,
                                              endAngle: 5,
                                              showLabels: false,
                                              showTicks: false,
                                              annotations: [
                                                GaugeAnnotation(
                                                  widget: Text(
                                                    "4/7",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      // Adjusted the font size for the text
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  angle: 270,
                                                  positionFactor:
                                                  0.1, // Adjusted to fit inside the smaller gauge
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Daily Visits",
                                        style: TextStyle(
                                          fontSize: 16,
                                          // Adjusted the font size for the text
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                  Obx(() {
                                    if (controller.isLoading.value) {
                                      return Center(child: CircularProgressIndicator());
                                    }

                                    double progress = (controller.completedTaskCount.value /
                                        (controller.totalTaskCount.value == 0
                                            ? 1
                                            : controller.totalTaskCount.value)) *
                                        100;

                                    return Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: SfRadialGauge(
                                            axes: [
                                              RadialAxis(
                                                pointers: [
                                                  RangePointer(
                                                    value: progress,
                                                    width: 8,
                                                    cornerStyle: CornerStyle.bothCurve,
                                                    gradient: const SweepGradient(
                                                      colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
                                                      stops: [0.1, 0.4],
                                                    ),
                                                  )
                                                ],
                                                axisLineStyle: AxisLineStyle(
                                                  thickness: 8,
                                                  color: Colors.red[600],
                                                ),
                                                startAngle: 5,
                                                endAngle: 5,
                                                showLabels: false,
                                                showTicks: false,
                                                annotations: [
                                                  GaugeAnnotation(
                                                    widget: Text(
                                                      "${controller.completedTaskCount.value}/${controller.totalTaskCount.value}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    angle: 270,
                                                    positionFactor: 0.1,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          "Daily Tasks",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
                Container(
                    width: double.infinity,
                    height: Get.height * 0.15,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 23.0, right: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Leads",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.taskListing);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.task,
                                      color: MyTheme.appColor,
                                      size: 30,
                                    ),
                                    // Image.asset(
                                    //   "assets/images/tasks.png",
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Tasks",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.leadSubmit);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.table_view_sharp,
                                      color: MyTheme.appColor,
                                      size: 30,
                                    ),

                                    // Image.asset(
                                    //   "assets/images/leadform.png",
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Lead/Visits",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.customerList);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.people_alt_outlined,
                                      color: MyTheme.appColor,
                                      size: 30,
                                    ),

                                    // Image.asset(
                                    //   "assets/images/customers.png",
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Customers",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(height: Get.height * 0.001),
                Container(
                    width: double.infinity,
                    height: Get.height * 0.15,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Sales CRM",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.productView);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.production_quantity_limits,
                                    color: MyTheme.appColor,
                                    size: 30,
                                  ),

                                  // Image.asset(
                                  //   "assets/images/products.png",
                                  // ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Products",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width * 0.01),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.orderTakeView,
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.shopping_cart_outlined,
                                    color: MyTheme.appColor,
                                    size: 30,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Orders",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: Get.width * 0.0001),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.leadListing);
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.add_task_outlined,
                                    color: MyTheme.appColor,
                                    size: 30,
                                  ),

                                  // Image.asset(
                                  //   "assets/images/leadlisting.png",
                                  // ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Order Status",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.grey[700]),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
                SizedBox(height: Get.height * 0.001),
                // Container(
                //     width: double.infinity,
                //     height: Get.height * 0.15,
                //     margin: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(15),
                //       color: Colors.white,
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.grey.withOpacity(0.3),
                //           spreadRadius: 1,
                //           blurRadius: 5,
                //           offset: Offset(0, 3), // Shadow offset
                //         ),
                //       ],
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.only(left: 18.0),
                //           child: Text(
                //             "Sales CRM",
                //             style: TextStyle(
                //                 fontSize: 16, fontWeight: FontWeight.w600),
                //           ),
                //         ),
                //         SizedBox(height: Get.height * 0.02),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             GestureDetector(
                //               onTap: () {
                //                 Get.toNamed(Routes.productView);
                //               },
                //               child: Column(
                //                 children: [
                //                   Icon(
                //                     Icons.production_quantity_limits,
                //                     color: MyTheme.appColor,
                //                     size: 30,
                //                   ),
                //
                //                   // Image.asset(
                //                   //   "assets/images/products.png",
                //                   // ),
                //                   SizedBox(height: 5),
                //                   Text(
                //                     "Products",
                //                     style: TextStyle(
                //                         fontSize: 16, color: Colors.grey[700]),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             SizedBox(width: Get.width * 0.01),
                //             GestureDetector(
                //               onTap: () {
                //                 Get.toNamed(Routes.addOrder, arguments: {
                //                   'productName': '',
                //                   // Default or placeholder value
                //                   'finalAmount': 0.0,
                //                   // Default value
                //                 });
                //               },
                //               child: Column(
                //                 children: [
                //                   Icon(
                //                     Icons.shopping_cart_outlined,
                //                     color: MyTheme.appColor,
                //                     size: 30,
                //                   ),
                //
                //                   // Image.asset(
                //                   //   "assets/images/order.png",
                //                   // ),
                //                   SizedBox(height: 5),
                //                   Text(
                //                     "Orders",
                //                     style: TextStyle(
                //                         fontSize: 16, color: Colors.grey[700]),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             SizedBox(width: Get.width * 0.0001),
                //             GestureDetector(
                //               onTap: () {
                //                 Get.toNamed(Routes.leadListing);
                //               },
                //               child: Column(
                //                 children: [
                //                   Icon(
                //                     Icons.add_task_outlined,
                //                     color: MyTheme.appColor,
                //                     size: 30,
                //                   ),
                //
                //                   // Image.asset(
                //                   //   "assets/images/leadlisting.png",
                //                   // ),
                //                   SizedBox(height: 5),
                //                   Text(
                //                     "Order Status",
                //                     style: TextStyle(
                //                         fontSize: 16, color: Colors.grey[700]),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         )
                //       ],
                //     )),
                // SizedBox(height: Get.height * 0.001),
                Container(
                    width: double.infinity,
                    height: Get.height * 0.15,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: Offset(0, 3), // Shadow offset
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0, top: 10),
                            child: Text(
                              "Expenses",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.toNamed(Routes.taskListing);
                              //   },
                              //   child: Column(
                              //     children: [
                              //       Image.asset(
                              //         "assets/images/tasks.png",
                              //       ),
                              //       SizedBox(height: 5),
                              //       Text(
                              //         "Tasks",
                              //         style: TextStyle(
                              //             fontSize: 16, color: Colors.grey[700]),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(width: 26),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.expenses);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.price_change_outlined,
                                      color: MyTheme.appColor,
                                      size: 30,
                                    ),

                                    // Image.asset(
                                    //   "assets/images/expenses.png",
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Expenses",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: Get.width * 0.11),
                              GestureDetector(
                                onTap: () {
                                     Get.toNamed(Routes.salesReport);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.document_scanner_outlined,
                                      color: MyTheme.appColor,
                                      size: 30,
                                    ),
                                    // Image.asset(
                                    //   "assets/images/products.png",
                                    // ),
                                    SizedBox(height: 5),
                                    Text(
                                      "Sales Report",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
                SizedBox(height: Get.height * 0.02),
              ],
            ),
          ),
        ));
  }
}

// Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//             onTap: () {
//               Get.toNamed(Routes.customerList);
//             },
//             child: Text("Customer List Page")),
//         GestureDetector(
//             onTap: () {
//               Get.toNamed(Routes.leadSubmit);
//             },
//             child: Text("Lead Form Page")),
//       ],
//     ))

//
// IconButton(
//               icon: Icon(Icons.notification_add_outlined, color: MyTheme.appColor),
//               onPressed: () {
//                 Get.toNamed(Routes.taskListing);
//               },
//             ),
//             Positioned(
//               right: 0,
//               top: 14,
//               left: 14,
//               child: Obx(() => controller.unseenTaskCount.value > 0
//                   ? CircleAvatar(
//                 radius: 8,
//                 backgroundColor: Colors.red,
//                 child: Text(
//                   '${controller.unseenTaskCount.value}',
//                   style: TextStyle(color: Colors.white, fontSize: 10),
//                 ),
//               )
//                   : SizedBox.shrink()),
//             ),

// Padding(
//   padding:  EdgeInsets.only(top: 15.0),
//   child: Stack(
//     children: [
//       Icon(Icons.notifications),
//       Positioned(
//         right: 0,
//         child: Obx(() => controller.unseenTaskCount.value > 0
//             ? CircleAvatar(
//           radius: 8,
//           backgroundColor: Colors.red,
//           child: Text(
//             '${controller.unseenTaskCount.value}',
//             style: TextStyle(color: Colors.white, fontSize: 10),
//           ),
//         )
//             : SizedBox.shrink()),
//       ),
//     ],
//   ),
// ),