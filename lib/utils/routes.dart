import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../screens/add_order/add_order_bindings.dart';
import '../screens/add_order/add_order_view.dart';
import '../screens/customer_detail/customer_detail_bindings.dart';
import '../screens/customer_detail/customer_detail_view.dart';
import '../screens/customer_list/customer_list_bindings.dart';
import '../screens/customer_list/customer_list_view.dart';
import '../screens/dashboard/dashboard_bindings.dart';
import '../screens/dashboard/dashboard_view.dart';
import '../screens/expenses/expenses_bindings.dart';
import '../screens/expenses/expenses_view.dart';
import '../screens/lead_form/lead_form_bindings.dart';
import '../screens/lead_form/lead_form_view.dart';
import '../screens/leads_listing/lead_listing_bindings.dart';
import '../screens/leads_listing/lead_listing_view.dart';
import '../screens/login/login_bindings.dart';
import '../screens/login/login_view.dart';
import '../screens/onboarding_screen.dart';
import '../screens/product_list/product_list_bindings.dart';
import '../screens/product_list/product_list_view.dart';
import '../screens/splash_screen.dart';
import '../screens/task_listing/task_list_bindings.dart';
import '../screens/task_listing/task_list_view.dart';


class Routes {
  static const splash = '/';
  static const login = '/login';
  static const onboarding = '/onBoarding';
  static const dashBoard = '/dashboard';
  static const customerList = '/customerList';
  static const leadSubmit = '/leadSubmit';
  static const customerDetail = '/customerDetail';
  static const leadListing = '/leadListing';
  static const productListing = '/productListing';
  static const taskListing = '/taskListing';
  static const expenses = '/expenses';
  static const addOrder = '/addOrder';


  static final routes = [
    GetPage(
      name: splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: onboarding,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      binding: LoginViewBindings(),
      name: login,
      page: () =>  LoginView(),
    ),
    GetPage(
      binding: DashboardBindings(),
      name: dashBoard,
      page: () =>  DashboardView(),
    ),
    GetPage(
      binding: CustomerlistdBindings(),
      name: customerList,
      page: () => CustomerListView(),

    ),
    GetPage(
      binding: LeadSubmitBindings(),
      name: leadSubmit,
      page: () =>  LeadSubmit(),
    ),
    GetPage(
      binding: CustomerDetaildBindings(),
      name: customerDetail,
      page: () =>  CustomerDetailView(),
    ),
    GetPage(
      binding: LeadListingBindings(),
      name: leadListing,
      page: () =>  LeadListingView(),
    ),
    GetPage(
      binding: ProductListingBindings(),
      name: productListing,
      page: () =>  ProductListingView(),
    ),
    GetPage(
      binding: TaskListingBindings(),
      name: taskListing,
      page: () =>  TaskListingView(),
    ),
    GetPage(
      binding: ExpenseBindings(),
      name: expenses,
      page: () =>  ExpenseView(),
    ),
    GetPage(
      binding: AddOrderBindings(),
      name: addOrder,
      page: () =>  AddOrderView(),
    ),
  ];

}