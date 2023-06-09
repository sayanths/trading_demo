import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/core/color/color.dart';
import 'package:trading_app/feature/home_view/view_model/home_view.dart';
import 'package:trading_app/responsive/responsive.dart';

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
                      const CircleAvatarWidgetForAppBAR(),
                      Text(
                        'Trade Brain',
                        style: TextStyle(
                            color: Apc.white,
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.textMultiplier! * 2.3),
                      ),
                      const CircleAvatarWidgetForAppBAR(),
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
            Consumer<HomeProvider>(
              builder: (context, value, _) => StreamBuilder<List<dynamic>>(
                stream: value.dataStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final dataList = snapshot.data!;
                    // Display the streamed data
                    return Wrap(
                      children: List.generate(10, (index) {
                        final item = dataList[index];
                        final dateTime = item['timestamp'];
                        final openPrice = item['open'];
                        final highPrice = item['high'];
                        final lowPrice = item['low'];
                        final closePrice = item['close'];
                        final volume = item['volume'];
                        return Container(
                          margin: const EdgeInsets.all(10),
                          height: Responsive.heightMultiplier! * 18,
                          width: Responsive.widthMultiplier! * 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(255, 255, 255, 255)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(),
                                const Text('lowPrice'),
                                const Text('Price'),
                                //                    Text('Date & Time: ${dateTime ?? 'N/A'}'),
                                // Text('Open: ${openPrice ?? 'N/A'}'),
                                // Text('High: ${highPrice ?? 'N/A'}'),
                                // Text('Low: ${lowPrice ?? 'N/A'}'),
                                // Text('Close: ${closePrice ?? 'N/A'}'),
                                // Text('Volume: ${volume ?? 'N/A'}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [CircleAvatar(), Text('')],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                    // ListView.builder(
                    //   itemCount: dataList.length,
                    //   itemBuilder: (context, index) {
                    //     final item = dataList[index];
                    //     return ListTile(
                    //       title: Text('Item ${index + 1}'),
                    //       subtitle: Text(item.toString()),
                    //     );
                    //   },
                    // );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
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
  const CircleAvatarWidgetForAppBAR({
    super.key,
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
            child: const CircleAvatar(
              radius: 15,
              backgroundColor: Apc.white,
            ),
          ),
        ],
      ),
    );
  }
}
