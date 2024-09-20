
import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  String get toCaption {
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    if (now.day == day && now.month == month && now.year == year) {
      return 'Today ${DateFormat('h:m a').format(this)}';
    }

    if (yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year) {
      return 'Yesterday ${DateFormat('h:m a').format(this)}';
    }

    if (now.year == year) {
      return DateFormat('MMM d, h:m a').format(this);
    }

    return DateFormat('d-MMM-y h:m a').format(this);
  }

  String get toCaptionDateOnly {
    final now = DateTime.now();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    if (now.day == day && now.month == month && now.year == year) {
      return 'Today';
    }

    if (yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year) {
      return 'Yesterday';
    }

    if (now.year == year) {
      return DateFormat('MMM d').format(this);
    }

    return DateFormat('d-MMM-y').format(this);
  }
}

extension StringValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidName() {
    if (isEmpty) return false;
    return RegExp(r"^[a-zA-Z\s]*$", unicode: true).hasMatch(this);
  }

  bool isValidMobileNumber() {
    if (isEmpty) return false;
    return !(RegExp(r"[a-zA-Z]+", unicode: true).hasMatch(this)) &&
        !(length < 6 || length > 15);
  }

  Map<String, dynamic> isValidUserName() {
    if (isEmpty) {
      return {'isValid': false, 'message': 'Please provide a username'};
    }
    if (contains(' ')) {
      return {
        'isValid': false,
        'message': 'username should not contain any space'
      };
    }
    //if(this.length<6) return {'isValid':false,'message':'Password must be minimum 6 characters long'};

    return {'isValid': true, 'message': ''};
  }

  Map<String, dynamic> isValidPassword() {
    if (isEmpty) {
      return {'isValid': false, 'message': 'Please provide a password'};
    }
    if (contains(' ')) {
      return {
        'isValid': false,
        'message': 'Password should not contain any space'
      };
    }
    //if(this.length<6) return {'isValid':false,'message':'Password must be minimum 6 characters long'};

    return {'isValid': true, 'message': ''};
  }
}

final formatCurrency = NumberFormat.simpleCurrency();

class DateHelper {
  static String parseformatDate(var dt, [String? format]) {
    var dateformat = DateFormat(format);
    DateFormat apidatedateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    try {
      return dateformat.format(apidatedateFormat.parse(dt));

      // DateFormat(_format).format(DateTime.parse(_dt));
    } catch (e) {
      try {
        return DateFormat(format).format(DateTime.parse(dt));
      } catch (e2) {
        return '<ErrDate>';
      }
    }
  }
}
