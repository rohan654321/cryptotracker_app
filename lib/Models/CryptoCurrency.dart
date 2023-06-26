class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  num? high24;
  num? low24;
  num? priceChange24;
  num? priceChangePercentage24;
  num? circulatingSupply;
  num? ath;
  num? atl;
  bool? isfavorite = false;

  CryptoCurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentPrice,
      required this.marketCap,
      required this.marketCapRank,
      required this.high24,
      required this.low24,
      required this.priceChange24,
      required this.priceChangePercentage24,
      required this.circulatingSupply,
      required this.ath,
      required this.atl});

  factory CryptoCurrency.fromJson(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        currentPrice: double.parse(map["current_price"].toString()),
        marketCap: double.parse(map["market_cap"].toString()),
        marketCapRank: map["market_cap_rank"],
        high24: map["high_24h"] ?? 0,
        low24: map["low_24h"] ?? 0,
        priceChange24: map["price_change_24h"] ?? 0,
        priceChangePercentage24: map["price_change_percentage_24h"] ?? 0,
        circulatingSupply: map["circulating_supply"] ?? 0,
        ath: map["ath"] ?? 0,
        atl: map["atl"] ?? 0);
  }
}
