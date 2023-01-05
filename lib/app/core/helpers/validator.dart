// matching various patterns for kinds of data
// todo recuperer les valeur pour translation

import 'package:get/get.dart';

class Validator {
  final labels;
  Validator(this.labels);

  // Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  // RegExp regex = new RegExp(pattern as String);
  String? email(String value) {
    if (!value.isEmail) {
      return 'Email is invalid';
    }
    return null;
  }

  // Pattern pattern = r'^.{6,}$€¤£';
  // RegExp regex = new RegExp(pattern as String);
  String? password(String value) {
    if (!value.isNotEmpty && value.toString().length <= 8)
      return 'password better length minimum 8 characters';
    else
      return null;
  }

  // Pattern pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
  // RegExp regex = new RegExp(pattern as String);
  String? name(String value) {
    if (!value.toString().isNotEmpty && value.toString().length <= 3)
      return 'user name is invalid';
    else
      return null;
  }

  String? number(String value) {
    Pattern pattern = r'^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return labels.validator.number;
    else
      return null;
  }

  String? amount(String value) {
    Pattern pattern = r'^\d+$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return labels.validator.amount;
    else
      return null;
  }

  String? notEmpty(String value) {
    Pattern pattern = r'^\S+$';
    RegExp regex = new RegExp(pattern as String);
    if (!regex.hasMatch(value))
      return labels.validator.notEmpty;
    else
      return null;
  }
}
