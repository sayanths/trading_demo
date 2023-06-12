import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/core/color/color.dart';
import 'package:trading_app/feature/home_view/model/stock_data.dart';
import 'package:trading_app/feature/home_view/model/wish_list.dart';
import 'package:trading_app/feature/home_view/view_model/home_view.dart';
import 'package:trading_app/responsive/responsive.dart';
import 'package:trading_app/routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apc.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              height: Responsive.heightMultiplier! * 40,
              width: Responsive.widthMultiplier! * 95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    const Color.fromARGB(255, 95, 163, 26).withOpacity(0.5),
                    const Color.fromARGB(255, 101, 120, 83).withOpacity(0.3),
                    // Apc.lime.withOpacity(0.2),
                    const Color.fromARGB(255, 101, 120, 83).withOpacity(0.2),
                  ])),
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.heightMultiplier! * 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatarWidgetForAppBAR(
                        child1: Icon(IconlyBold.profile),
                      ),
                      Text(
                        'Trade Brain',
                        style: TextStyle(
                            color: Apc.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textMultiplier! * 2.3),
                      ),
                      GestureDetector(
                        onTap: () {
                          Routes.push(screen: '/SearchView');
                        },
                        child: const CircleAvatarWidgetForAppBAR(
                          child1: Icon(
                            IconlyBold.search,
                            size: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    '${50556}',
                    style: TextStyle(
                        color: Apc.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.textMultiplier! * 5),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonWithDraw(
                          ontap: () {},
                          color: const Color.fromARGB(255, 1, 206, 1),
                          title: 'Deposit'),
                      ButtonWithDraw(
                          ontap: () {}, color: Apc.red, title: 'Withdraw')
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.heightMultiplier! * 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.widthMultiplier! * 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PortFolioWidget(
                    title: 'Portfolio',
                    color: Apc.white,
                    doule: Responsive.textMultiplier! * 2.5,
                    fontWeight: FontWeight.w800,
                  ),
                  PortFolioWidget(
                    title: 'View All',
                    color: Apc.white.withOpacity(0.7),
                    doule: Responsive.textMultiplier! * 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Responsive.heightMultiplier! * 3,
            ),
            Consumer<HomeProvider>(
              builder: (context, value, _) => StreamBuilder<List<StockData>>(
                stream: value.fetchStockData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dataList = snapshot.data!;
                    log(dataList.toString());
                    return Wrap(
                      children: List.generate(dataList.length, (index) {
                        final item = dataList[index];
                        final dateTime = item.dateTime;
                        final openPrice = item.open;
                        final highPrice = item.high;
                        final lowPrice = item.low;
                        final closePrice = item.close;
                        final volume = item.volume;

                        return Container(
                          margin: const EdgeInsets.all(5),
                          height: Responsive.heightMultiplier! * 25,
                          width: Responsive.widthMultiplier! * 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Date & Time: $dateTime'),
                                Text('Open: $openPrice '),
                                Text('High: $highPrice '),
                                Text('Low: $lowPrice  '),
                                Text('Close: $closePrice'),
                                Text('Volume: $volume '),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Apc.textColor,
                                      child: IconButton(
                                        onPressed: () async {
                                          value.wishListAdded(true);
                                          bool val = true;
                                          final data = WishlistModel(
                                            id: DateTime.now()
                                                .microsecondsSinceEpoch
                                                .toInt(),
                                            close: closePrice,
                                            high: highPrice,
                                            low: lowPrice,
                                            open: openPrice,
                                            timestamp: dateTime,
                                            volume: volume,
                                            whistListAdded: val,
                                          );

                                          await value
                                              .addWaterDetails(data)
                                              .whenComplete(() async {
                                            await value.getAllWaterDbDetails();
                                          });
                                        },
                                        icon: const Icon(
                                          IconlyBold.heart,
                                          color: Apc.white,
                                        ),
                                      ),
                                    ),
                                    const Text(''),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Apc.white),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PortFolioWidget extends StatelessWidget {
  final String title;
  final FontWeight? fontWeight;
  final double? doule;
  final Color color;
  const PortFolioWidget({
    super.key,
    required this.title,
    this.fontWeight,
    this.doule,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(color: color, fontWeight: fontWeight, fontSize: doule),
    );
  }
}

class ButtonWithDraw extends StatelessWidget {
  final Color color;
  final String title;
  final void Function()? ontap;
  const ButtonWithDraw({
    super.key,
    required this.color,
    required this.title,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: Responsive.heightMultiplier! * 7,
        width: Responsive.widthMultiplier! * 35,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                color: Apc.white, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWidgetForAppBAR extends StatelessWidget {
  final Widget child1;

  const CircleAvatarWidgetForAppBAR({
    super.key,
    required this.child1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Apc.white.withOpacity(0.5),
            radius: 20,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Apc.white,
              child: child1,
            ),
          ),
        ],
      ),
    );
  }
}

class StockSymbol {
  final String symbol;
  final String name;

  StockSymbol({required this.symbol, required this.name});

  factory StockSymbol.fromJson(Map<String, dynamic> json) {
    return StockSymbol(
      symbol: json['1. symbol'] ?? '',
      name: json['2. name'] ?? '',
    );
  }
}
