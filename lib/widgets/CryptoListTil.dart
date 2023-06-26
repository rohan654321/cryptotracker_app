import 'package:cryptotracker_app/Pages/DetailsPages.dart';
import 'package:flutter/material.dart';

import '../Models/CryptoCurrency.dart';

class CryptoListTil extends StatelessWidget {
  final CryptoCurrency currentCrypto;
  CryptoListTil({super.key, required this.currentCrypto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                        id: currentCrypto.id!,
                        likes: [],
                        themeMode: ThemeMode.dark,
                        currentCrypto: currentCrypto,
                      )));
        },
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(currentCrypto.image!),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                currentCrypto.name! + "#${currentCrypto.marketCapRank!}",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        subtitle: Text(currentCrypto.symbol!.toUpperCase()),
        trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹" + currentCrypto.currentPrice!.toStringAsFixed(4),
                style: TextStyle(
                  color: Color(0xff0395eb),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Builder(
                builder: (context) {
                  num priceChange = currentCrypto.priceChange24!;
                  num priceChangePercentage =
                      currentCrypto.priceChangePercentage24!;

                  if (priceChange < 0) {
                    //negative
                    return Text(
                      "${priceChangePercentage.toStringAsFixed(2)}%(${priceChange.toStringAsFixed(4)})",
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    //positive
                    return Text(
                      "+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(4)})",
                      style: TextStyle(color: Colors.green),
                    );
                  }
                },
              ),
            ]));
  }
}
