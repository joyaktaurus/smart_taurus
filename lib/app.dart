


import 'models/customer_list_model.dart';
import 'models/lead_listing_model.dart';
import 'models/login_model.dart';
import 'models/product_listing_model.dart';
import 'models/task_listing_model.dart';

abstract class App{
  static const String appTitle = "Smart Taurus Marketing App";
  static const String appVersionName = "1.0.0";
  static String token = '';
  static EmployeeDetails user = EmployeeDetails();
  static List<Shop> cusdetails = [];
  static List<ShopShop> shop = [];
  static List<ProductListing> prodDetails = [];


}