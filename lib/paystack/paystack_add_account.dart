import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/paystack/paystack_split_pay.dart';
import 'package:project/ui/utils/color_utils.dart';
// import 'package:project/ui/utils/color_utils.dart';
import 'package:project/ui/utils/flush_bar_utils.dart';
import 'package:project/ui/utils/log_utils.dart';

class PaystackAddBankAccountScreen extends StatefulWidget {
  @override
  _PaystackAddBankAccountScreenState createState() =>
      _PaystackAddBankAccountScreenState();
}

class _PaystackAddBankAccountScreenState
    extends State<PaystackAddBankAccountScreen> {
  String _selectedBank;
  bool isBankSelected = false;
  String bank;
  TextEditingController _textEditingController = TextEditingController();
  List<String> banks = [];
  final TextStyle _textFieldStyle = TextStyle(
      color: Color(0xffB5BBC9), fontSize: 13, fontWeight: FontWeight.w600);

  // List<String> _getListOfBanks() {
  //   snapshot.data.forEach((key, value) {
  //     banks.add(key);
  //   });
  //   return banks;
  // }
  String bankCode;
  bool isGettingName = false;
  String accountNumber;
  bool nameGotten = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add account",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<Map<String, String>>(
          future: PayStackpayment.getAllBanks(),
          builder: (context, snapshot) {
            //             List<String> _getListOfBanks() {
            //   snapshot.data.forEach((key, value) {
            //     banks.add(key);
            //   });
            //   return banks;
            // }
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            List<String> _getListOfBanks() {
              snapshot.data.forEach((key, value) {
                banks.add(key);
              });
              return banks;
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  onChanged: () async {
                    if (_formKey.currentState.validate()) {
                      logger.d(accountNumber);
                      logger.d(bankCode);
                      try {
                        setState(() {
                          isGettingName = true;
                          nameGotten = false;
                        });
                        String resp = await PayStackpayment.getAccountName(
                            int.tryParse(accountNumber), (bankCode));
                        _textEditingController.text = resp;
                        setState(() {
                          isGettingName = false;
                          nameGotten = true;
                        });
                        showFlushBarWidget(resp).show(context);
                      } catch (e) {
                        setState(() {
                          isGettingName = false;
                          nameGotten = false;
                        });
                        showFlushBarWidget(e).show(context);
                      }
                    }
                  },
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Select bank")),
                      DropdownSearch<String>(
                        enabled: !isGettingName,
                        onSaved: (item) {
                          bank = item;
                        },
                        isFilteredOnline: false,

                        mode: Mode.BOTTOM_SHEET,
                        // label: "Bank Name",
                        maxHeight: 300,
                        items: _getListOfBanks(),

                        onChanged: (String item) {
                          setState(() {
                            _selectedBank = item;
                            bankCode = snapshot.data[item];
                            logger.d(bankCode);
                            isBankSelected = true;
                          });
                        },
                        validator: (input) {
                          if (input == null) return "select bank";
                          return input.trim().isEmpty ? "select bank" : null;
                        },

                        selectedItem: _selectedBank,
                        errorBuilder: (context, child, _) {
                          return Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                Text("Error occured"),
                                SizedBox(height: 10),
                                RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Close"),
                                    color: Theme.of(context).primaryColor),
                              ]));
                        },
                        showSearchBox: true,
                        dropdownSearchDecoration: InputDecoration(
                          //  helperText: "Bank Name",
                          prefixText: isBankSelected ? "" : "Bank Name",

                          prefixStyle: _textFieldStyle.copyWith(
                            fontSize: 13,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        ),
                        searchBoxDecoration: InputDecoration(
                            focusColor: Colors.teal,
                            hintText: "Search",
                            isCollapsed: true,
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey.withOpacity(.2),
                            // border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 20, 8, 10),
                            // labelText: "Search",
                            helperStyle:
                                TextStyle(color: Colors.grey.withOpacity(.2))),
                        popupTitle: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            // color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 40),
                                Spacer(),
                                Text(
                                  'Select Bank',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).primaryColor),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            ),
                          ),
                        ),

                        popupShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // enabled: !nameGotten,
                        readOnly: isGettingName,
                        validator: (input) {
                          String trimmedInput = input.trim();
                          if (int.tryParse(trimmedInput) == null) {
                            return "invalid account number";
                          } else if (trimmedInput.length != 10) {
                            return "must be 10 characters";
                          }
// PayStackpayment
                          accountNumber = trimmedInput;
                          return null;
                        },
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Account Number',
                          labelStyle: _textFieldStyle,
                        ),
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !nameGotten
                          ? SizedBox()
                          : TextFormField(
                              controller: _textEditingController,
                              validator: (str) {
                                if (str.isEmpty) {
                                  return "invalid";
                                }
                                return null;
                              },
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Account Name',
                                labelStyle: _textFieldStyle,
                              ),
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                      isGettingName ? CircularProgressIndicator() : Offstage(),
                      SizedBox(
                        height: 20,
                      ),
                      if (nameGotten)
                        CupertinoButton(
                            color: primaryColor,
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                logger.d("validated");
                              }
                            })
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
