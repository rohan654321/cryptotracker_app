import 'dart:async';

import 'package:cryptotracker_app/Models/CryptoCurrency.dart';
import 'package:cryptotracker_app/Models/localStorage.dart';
import 'package:flutter/material.dart';

import '../Models/Api.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  var isfavorite;

  MarketProvider() {
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await Api.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

      if (favorites.contains(newCrypto.id!)) {
        newCrypto.isfavorite = false;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners();

    // Timer(const Duration(seconds: 3), () {
    //   fetchData();
    //   debugPrint("Updated");
    // });
  }

  // Future<void> fetchChartsData(String id) async {
  //   List<dynamic> _markets = await Api.getMarketsCharts(id);
  //   List<String> favorites = await LocalStorage.fetchFavorites();

  //   List<CryptoCurrency> temp = [];
  //   for (var market in _markets) {
  //     CryptoCurrency newCrypto = CryptoCurrency.fromJson(market);

  //     if (favorites.contains(newCrypto.id!)) {
  //       newCrypto.isFavorite = true;
  //     }
  //     temp.add(newCrypto);
  //   }
  //   markets = temp;
  //   isLoading = false;
  //   notifyListeners();

  //   // Timer(const Duration(seconds: 3), () {
  //   //   fetchData();
  //   //   debugPrint("Updated");
  //   // });
  // }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto =
        markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  Future<void> addFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }

  Future<void> removeFavorite(CryptoCurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isfavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}
