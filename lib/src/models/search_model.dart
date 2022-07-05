import 'dart:convert';

import 'package:berded_seller/src/app.dart';

class SearchModel {
  SearchModel({
    this.search_phone,
    this.search_pre,
    this.search_sum,
    this.search_price_gap,
    this.search_operator,
    this.search_type,
    this.search_kind,

  });

  String? search_phone;
  String? search_pre;
  String? search_sum;
  String? search_price_gap;
  String? search_operator;
  String? search_type;
  String? search_kind;

  isNullOrEmpty(String? value) {
    return value == null || value == "";
  }


  bool isEmpty() {
    return isNullOrEmpty(search_phone) &&
        isNullOrEmpty(search_pre) &&
        isNullOrEmpty(search_sum) &&
        isNullOrEmpty(search_price_gap) &&
        isNullOrEmpty(search_operator) &&
        isNullOrEmpty(search_type) &&
        isNullOrEmpty(search_kind);
    }


  getValue(String? org) {
    if (org == null || org == "" || org.length < 0) {
      return "all";
    }
    return org;
  }

  getSearchPhoneValue(String? org) {
    if (org == null || org == "" || org.length < 0) {
      return '';
    }
    return org;
  }


  @override
  String toString() {
    // TODO: implement toString
    final search = "https://www.berded.in.th/portal/dashboard/?action=search&search_phone=${getSearchPhoneValue(search_phone)}&search_pre=${getValue(
        search_pre)}&search_sum=${getValue(search_sum)}&search_price_gap=${getValue(search_price_gap)}&search_operator=${getValue(search_operator)}&search_type=${getValue(
        search_type)}&search_kind=${getValue(search_kind)}";
    // logger.d('=> $search');
    return search;
  }
}