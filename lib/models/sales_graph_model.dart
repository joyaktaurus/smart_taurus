import 'dart:convert';

SalesGraphModel salesGraphModelFromJson(String str) => SalesGraphModel.fromJson(json.decode(str));

String salesGraphModelToJson(SalesGraphModel data) => json.encode(data.toJson());

class SalesGraphModel {
  String? message;
  int? totalSalesCountToday;
  String? totalQuantitySoldToday;
  List<WeeklySalesReport>? weeklySalesReport;
  int? totalWeeklyRevenueSum;
  int? totalWeeklyQuantitySum;
  String? year;
  Map<String, MonthlySalesReport>? monthlySalesReport;
  int? totalMnRevenueSum;
  int? totalMnQuantitySum;
  String? yearRange;
  List<YearlySalesReport>? yearlySalesReport;
  int? totalYrRevenueSum;
  int? totalYrQuantitySum;

  SalesGraphModel({
    this.message,
    this.totalSalesCountToday,
    this.totalQuantitySoldToday,
    this.weeklySalesReport,
    this.totalWeeklyRevenueSum,
    this.totalWeeklyQuantitySum,
    this.year,
    this.monthlySalesReport,
    this.totalMnRevenueSum,
    this.totalMnQuantitySum,
    this.yearRange,
    this.yearlySalesReport,
    this.totalYrRevenueSum,
    this.totalYrQuantitySum,
  });

  factory SalesGraphModel.fromJson(Map<String, dynamic> json) => SalesGraphModel(
    message: json["message"],
    totalSalesCountToday: json["total_sales_count_today"],
    totalQuantitySoldToday: json["total_quantity_sold_today"],
    weeklySalesReport: List<WeeklySalesReport>.from(json["weekly_sales_report"].map((x) => WeeklySalesReport.fromJson(x))),
    totalWeeklyRevenueSum: json["total_weekly_revenue_sum"],
    totalWeeklyQuantitySum: json["total_weekly_quantity_sum"],
    year: json["year"],
    monthlySalesReport: Map.from(json["monthly_sales_report"]).map((k, v) => MapEntry<String, MonthlySalesReport>(k, MonthlySalesReport.fromJson(v))),
    totalMnRevenueSum: json["total_mn_revenue_sum"],
    totalMnQuantitySum: json["total_mn_quantity_sum"],
    yearRange: json["year_range"],
    yearlySalesReport: List<YearlySalesReport>.from(json["yearly_sales_report"].map((x) => YearlySalesReport.fromJson(x))),
    totalYrRevenueSum: json["total_yr_revenue_sum"],
    totalYrQuantitySum: json["total_yr_quantity_sum"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total_sales_count_today": totalSalesCountToday,
    "total_quantity_sold_today": totalQuantitySoldToday,
    "weekly_sales_report": List<dynamic>.from(weeklySalesReport!.map((x) => x.toJson())),
    "total_weekly_revenue_sum": totalWeeklyRevenueSum,
    "total_weekly_quantity_sum": totalWeeklyQuantitySum,
    "year": year,
    "monthly_sales_report": Map.from(monthlySalesReport!).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "total_mn_revenue_sum": totalMnRevenueSum,
    "total_mn_quantity_sum": totalMnQuantitySum,
    "year_range": yearRange,
    "yearly_sales_report": List<dynamic>.from(yearlySalesReport!.map((x) => x.toJson())),
    "total_yr_revenue_sum": totalYrRevenueSum,
    "total_yr_quantity_sum": totalYrQuantitySum,
  };
}

class MonthlySalesReport {
  String? month;
  dynamic totalRevenue;
  dynamic totalQuantitySold;

  MonthlySalesReport({
    this.month,
    this.totalRevenue,
    this.totalQuantitySold,
  });

  factory MonthlySalesReport.fromJson(Map<String, dynamic> json) => MonthlySalesReport(
    month: json["month"],
    totalRevenue: json["total_revenue"],
    totalQuantitySold: json["total_quantity_sold"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "total_revenue": totalRevenue,
    "total_quantity_sold": totalQuantitySold,
  };
}

class WeeklySalesReport {
  DateTime? date;
  int? totalRevenue;
  int? totalQuantitySold;

  WeeklySalesReport({
    this.date,
    this.totalRevenue,
    this.totalQuantitySold,
  });

  factory WeeklySalesReport.fromJson(Map<String, dynamic> json) => WeeklySalesReport(
    date: DateTime.parse(json["date"]),
    totalRevenue: json["total_revenue"],
    totalQuantitySold: json["total_quantity_sold"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "total_revenue": totalRevenue,
    "total_quantity_sold": totalQuantitySold,
  };
}

class YearlySalesReport {
  int? year;
  dynamic totalRevenue;
  dynamic totalQuantitySold;

  YearlySalesReport({
    this.year,
    this.totalRevenue,
    this.totalQuantitySold,
  });

  factory YearlySalesReport.fromJson(Map<String, dynamic> json) => YearlySalesReport(
    year: json["year"],
    totalRevenue: json["total_revenue"],
    totalQuantitySold: json["total_quantity_sold"],
  );

  Map<String, dynamic> toJson() => {
    "year": year,
    "total_revenue": totalRevenue,
    "total_quantity_sold": totalQuantitySold,
  };
}
