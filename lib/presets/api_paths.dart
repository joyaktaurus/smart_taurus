import 'package:smart_taurus/models/empdetails.dart';

abstract class ApiPaths {
  static const baseUrl = "http://seowebsites.in/Smart_Taurus/smart_taurus/api/v1";
  static const login = '/login';
  static const customerList = '/get-shop';
  static const leadformSubmit = '/shop-register';
  static const leadListing = '/get-lead';
  static const productListing = '/get-products';
  static const taskListing = '/get-task';
  static const taskUpdate = '/update-task';
  static const shopSearch = '/shop-search';
  static const Expenses = '/add-expenses';
  static const NewLead = '/add-lead';
   static const AddOrderSubmit = '/add-order';
  static const EmpDetails = '/get-employee';
  static const productSearch = '/product-search';

}
