import 'package:cryptotracker_app/Models/CryptoCurrency.dart';
import 'package:cryptotracker_app/Provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final ThemeMode themeMode;
  final CryptoCurrency currentCrypto;
  final String id;
  final List<String> likes;

  const DetailsPage(
      {Key? key,
      required this.id,
      required this.likes,
      required this.currentCrypto,
      required this.themeMode})
      : super(key: key);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool isLiked = false;
  @override
  void get initState {
    super.initState;
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });
  }

  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(detail,
            style: TextStyle(
              fontSize: 17,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider = Provider.of<MarketProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Consumer<MarketProvider>(
          builder: (context, MarketProvider, child) {
            CryptoCurrency currentCrypto =
                MarketProvider.fetchCryptoById(widget.id);

            return RefreshIndicator(
              onRefresh: () async {
                await MarketProvider.fetchData();
              },
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(currentCrypto.image!),
                    ),
                    title: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                currentCrypto.name! +
                                    "#${currentCrypto.marketCapRank!}",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                            ),
                            LikeButton(
                                size: 25,
                                circleColor: const CircleColor(
                                    start: Color(0xFFE26D13),
                                    end: Color(0xFFE26D13)),
                                bubblesColor: const BubblesColor(
                                    dotPrimaryColor: Color(0xFFE26D13),
                                    dotSecondaryColor: Color(0xFFE26D13)),
                                likeBuilder: ((isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: (currentCrypto.isfavorite == true)
                                        ? Colors.red
                                        : (ThemeData == ThemeData.dark)
                                            ? Colors.white
                                            : Colors.grey,
                                    size: 25,
                                  );
                                }),
                                onTap: (isLiked) async {
                                  if ((currentCrypto.isfavorite == false)) {
                                    await marketProvider
                                        .addFavorite(currentCrypto);
                                    return isLiked = currentCrypto.isfavorite!;
                                  } else {
                                    await marketProvider
                                        .removeFavorite(currentCrypto);
                                    return isLiked = currentCrypto.isfavorite!;
                                  }
                                })
                            // SizedBox(
                            //   width: 200,
                            // ),
                            // (currentCrypto.isFavorite == false)
                            //     ? GestureDetector(
                            //         onTap: () {
                            //           marketProvider.addFavorite(currentCrypto);
                            //         },
                            //         child: Icon(
                            //           CupertinoIcons.heart,
                            //           size: 18,
                            //         ))
                            //     : GestureDetector(
                            //         onTap: () {
                            //           marketProvider
                            //               .removeFavorite(currentCrypto);
                            //         },
                            //         child: Icon(
                            //           CupertinoIcons.heart_fill,
                            //           size: 18,
                            //           color: Colors.red,
                            //         ),
                            //       ),
                          ],
                        ),
                        Text(
                          currentCrypto.name! +
                              "(${currentCrypto.symbol!.toUpperCase()})",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      "₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
                      style: TextStyle(
                        color: Color(0xff0395eb),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Change(24th)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
                              style: TextStyle(color: Colors.red, fontSize: 23),
                            );
                          } else {
                            //positive
                            return Text(
                              "+${priceChangePercentage.toStringAsFixed(2)}%(+${priceChange.toStringAsFixed(4)})",
                              style:
                                  TextStyle(color: Colors.green, fontSize: 23),
                            );
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Market Cap",
                          "₹ " + currentCrypto.marketCap!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "Market Cap Rank",
                          "#" + currentCrypto.marketCapRank.toString(),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Low 24",
                          "₹ " + currentCrypto.low24!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "High 24",
                          "₹ " + currentCrypto.high24!.toStringAsFixed(4),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Circulating Supply",
                          currentCrypto.circulatingSupply!.toInt().toString(),
                          CrossAxisAlignment.start),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "All Time Low",
                          currentCrypto.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "All Time high",
                          currentCrypto.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      )),
    );
  }
}
