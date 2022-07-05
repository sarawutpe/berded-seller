import 'dart:async';

import 'package:berded_seller/src/app.dart';
import 'package:berded_seller/src/constants/constants.dart';
import 'package:berded_seller/src/models/search_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SearchAppBar extends StatefulWidget {
  final String title;
  final Function(String) onSearchSubmit;
  final VoidCallback? onClose;

  SearchAppBar({Key? key, required this.title, required this.onSearchSubmit, this.onClose}) : super(key: key);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _searchPhonecontroller = TextEditingController();
  final SearchModel _searchModel = SearchModel();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  String searchPre = 'ขึ้นต้นด้วย';
  String searchSum = 'ผลรวม';
  String searchPriceGap = 'ช่วงราคา';
  String searchOperator = 'เครือข่าย';
  String searchType = 'ชนิด';
  String searchKind = 'ประเภท';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        height: double.infinity,
        child: Column(
          children: [
            AppBar(
                backgroundColor: Colors.red,
                title: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 2,
                  child: Container(
                    padding: const EdgeInsets.only(top: 6, right: 10, bottom: 6, left: 10),
                    child: TextFormField(
                      onChanged: (text) => _searchChanged(context, text),
                      keyboardType: TextInputType.phone,
                      // maxLength: 10,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d{1,10}'))],
                      controller: _searchPhonecontroller,
                      autofocus: false,
                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: widget.title,
                        hintStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ),
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                      onPressed: () {
                        // if (!_searchModel.isEmpty()){
                        //   ConfirmDialog(
                        //     context: context,
                        //     title: 'ยกเลิกผลการค้นหาหรือไม่',
                        //     onPress: ()  {
                        //       Navigator.pop(navigatorState.currentContext!);
                        //       widget.onSearchSubmit(SearchModel().toString());
                        //     },
                        //   );
                        // }
                        _searchPhonecontroller.clear();
                        widget.onClose!();
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      )),
                ]),
            // Search menu container
            Container(
              width: double.infinity,
              height: 160,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(
                    0,
                    3,
                  ),
                ),
              ]),
              child: Scrollbar(
                controller: _scrollController,
                isAlwaysShown: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSearchPre(),
                      _buildSearchSum(),
                      _buildSearchPriceGap(),
                      _buildSearchOperator(),
                      _buildSearchType(),
                      _buildSearchKind(),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => widget.onClose!(),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchPre() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // dropdown
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchPre,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.looks_one_rounded),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchPre) {
                    setState(() {
                      _searchModel.search_pre = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchPre = newValue;
                    });

                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchPreList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchPre != Constants.searchPreList[0]) {
                  setState(() {
                    searchPre = Constants.searchPreList[0];
                  });
                  _searchModel.search_pre = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_pre?.isEmpty ?? true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSum() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchSum,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.summarize),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchSum) {
                    setState(() {
                      _searchModel.search_sum = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchSum = newValue;
                    });

                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchSumList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchSum != Constants.searchSumList[0]) {
                  setState(() {
                    searchSum = Constants.searchSumList[0];
                  });
                  _searchModel.search_sum = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_sum?.isEmpty ?? true),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchPriceGap() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchPriceGap,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchPriceGap) {
                    setState(() {
                      _searchModel.search_price_gap = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchPriceGap = newValue;
                    });
                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchPriceGapList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchPriceGap != Constants.searchPriceGapList[0]) {
                  setState(() {
                    searchPriceGap = Constants.searchPriceGapList[0];
                  });
                  _searchModel.search_price_gap = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_price_gap?.isEmpty ?? true),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearchOperator() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchOperator,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.signal_cellular_alt),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchOperator) {
                    setState(() {
                      _searchModel.search_operator = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchOperator = newValue;
                    });
                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchOperatorList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchOperator != Constants.searchOperatorList[0]) {
                  setState(() {
                    searchOperator = Constants.searchOperatorList[0];
                  });
                  _searchModel.search_operator = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_operator?.isEmpty ?? true),
            )
          ],
        ),
      ),
    );
  }

  _buildSearchType() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchType,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.local_activity),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchType) {
                    setState(() {
                      _searchModel.search_type = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchType = newValue;
                    });
                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchTypeList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchType != Constants.searchTypeList[0]) {
                  setState(() {
                    searchType = Constants.searchTypeList[0];
                  });
                  _searchModel.search_type = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_type?.isEmpty ?? true),
            )
          ],
        ),
      ),
    );
  }

  _buildFilterTextStyle(String value) {
    return TextStyle(
      color: value.contains(" : ") ? Colors.black : Colors.black.withOpacity(0.5),
      fontWeight: value.contains(" : ") ? FontWeight.bold : FontWeight.normal,
    );
  }

  _buildSearchKind() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: searchKind,
                elevation: 16,
                isExpanded: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.emoji_symbols),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != searchKind) {
                    setState(() {
                      _searchModel.search_kind = newValue.split(" : ").length > 1 ? newValue.split(" : ")[1] : "";
                      searchKind = newValue;
                    });
                    widget.onSearchSubmit(_searchModel.toString());
                  }
                },
                items: Constants.searchKindList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value.isNotEmpty ? value : null,
                    child: Row(
                      children: [
                        Text(
                          value.split(" : ")[0],
                          style: _buildFilterTextStyle(value),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            // clear dropdown value
            GestureDetector(
              onTap: () {
                if (searchKind != Constants.searchKindList[0]) {
                  setState(() {
                    searchKind = Constants.searchKindList[0];
                  });
                  _searchModel.search_kind = '';
                  widget.onSearchSubmit(_searchModel.toString());
                }
              },
              child: _buildClearButton(_searchModel.search_kind?.isEmpty ?? true),
            )
          ],
        ),
      ),
    );
  }

  _buildClearButton(bool active) {
    return Container(
        height: double.maxFinite,
        margin: EdgeInsets.only(left: 4.0),
        padding: EdgeInsets.all(8.0),
        child: Icon(
          Icons.restart_alt_rounded,
          size: 20,
          color: active ? Colors.grey.shade200 : Colors.grey.shade600,
        ));
  }

  _searchChanged(context, String text) {
    if (_debounce != null && _debounce!.isActive) {
      logger.d("Cancel last timer");
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(seconds: 1), () {
      logger.d('=> ready!');
      // start query
      _searchModel.search_phone = text;
      widget.onSearchSubmit(_searchModel.toString());
      FocusScope.of(context).requestFocus(new FocusNode());
    });
  }
}
