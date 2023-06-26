import 'package:cryptotracker_app/Models/CryptoCurrency.dart';
import 'package:cryptotracker_app/Provider/market_provider.dart';
import 'package:cryptotracker_app/widgets/CryptoListTil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, MarketProvider, child) {
      List<CryptoCurrency> favorites = MarketProvider.markets
          .where((element) => element.isfavorite == true)
          .toList();
      if (favorites.length > 0) {
        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            CryptoCurrency currentCrypto = favorites[index];
            return CryptoListTil(currentCrypto: currentCrypto);
          },
        );
      } else {
        return Center(
          child: Text(
            "No Favorites Yet",
            style: TextStyle(color: Colors.grey, fontSize: 20),
          ),
        );
      }

      // return Text(favorites.length.toString());
    });
  }
}
