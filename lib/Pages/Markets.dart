import 'package:cryptotracker_app/widgets/CryptoListtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/CryptoCurrency.dart';
import '../Provider/market_provider.dart';

class Markets extends StatefulWidget {
  static var isfavorite;

  const Markets({super.key});

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      if (marketProvider.isLoading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (marketProvider.markets.length > 0) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: marketProvider.markets.length,
                itemBuilder: (context, index) {
                  CryptoCurrency currentCrypto = marketProvider.markets[index];
                  return CryptoListTil(
                    currentCrypto: currentCrypto,
                  );
                }),
          );
        } else {
          return Text("Data not Found");
        }
      }
    });
  }
}
