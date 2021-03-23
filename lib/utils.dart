





  // Future<BitcoinWalletBalance> getBitcoinWalletBalance() async {
  //   String token = await storageService.getToken();
  //   String url = baseUrl + "/bitcoin-wallet/balance";
  //   http.Response response = await http.get(url, headers: setHeaders(token));

  //   if (response.statusCode == 200) {
  //     Map<String, dynamic> body = json.decode(response.body);
  //     // print(body);
  //     // print(body);
  //     // UserDetails.fromJson(body);
  //     if (body["success"]) {
  //       return BitcoinWalletBalance.fromJson(body);
  //     }
  //     // todo: add exception for no btc wallet created
  //   }
  //   throw (response.reasonPhrase);
  // }
//   Future<NairaWallet> getWalletDetails() async {
//     String url = baseUrl + "/naira-wallet";
//     final String token = await storageService.getToken();

//     http.Response response = await http.get(url, headers: setHeaders(token));
//     if (response.statusCode == 200) {
//       Map<String, dynamic> body = json.decode(response.body);
//       print(body);
// // todo change to isEmpty
//       if (body["data"]["password"]?.isEmpty ?? true) {
//         throw WalletError.Nopin;
//       }
//       if (body["success"]) {
//         return NairaWallet.fromJson(body["data"]);
//       }
//     }
//     throw (response.reasonPhrase);
//   }
