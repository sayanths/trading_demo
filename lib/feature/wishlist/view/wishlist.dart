import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:trading_app/core/color/color.dart';
import 'package:trading_app/feature/home_view/view_model/home_view.dart';
import 'package:trading_app/responsive/responsive.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Apc.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 27, 52, 0),
        elevation: 0,
        leading: const Text(''),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, value, _) => value.waterDbList.isEmpty
            ? const Center(
                child: Text(
                  'No added to fav',
                  style: TextStyle(color: Apc.white),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: value.waterDbList.length,
                itemBuilder: (context, index) {
                  final item = value.waterDbList[index];
                  final dateTime = item.timestamp;
                  final openPrice = item.open;
                  final highPrice = item.high;
                  final lowPrice = item.low;
                  final closePrice = item.close;
                  final volume = item.volume;

                  return Container(
                    margin: const EdgeInsets.all(5),
                    height: Responsive.heightMultiplier! * 18,
                    width: Responsive.widthMultiplier! * 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Date & Time: ${dateTime ?? 'N/A'}'),
                          Text('Open: ${openPrice ?? 'N/A'}'),
                          Text('High: ${highPrice ?? 'N/A'}'),
                          Text('Low: ${lowPrice ?? 'N/A'}'),
                          Text('Close: ${closePrice ?? 'N/A'}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                backgroundColor: Apc.textColor,
                                child: IconButton(
                                  onPressed: () async {
                                    await value
                                        .deleteWaterDetails(index)
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
                              const Text('')
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),

      //  Column(
      //   children: [
      //     Wrap(
      //       children: List.generate(5, (index) {
      //         return Container(
      //           margin: const EdgeInsets.all(10),
      //           height: Responsive.heightMultiplier! * 18,
      //           width: Responsive.widthMultiplier! * 40,
      //           decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(8),
      //               color: const Color.fromARGB(255, 255, 255, 255)),
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 const CircleAvatar(),
      //                 const Text('lowPrice'),
      //                 const Text('Price'),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     CircleAvatar(
      //                       backgroundColor: Apc.textColor,
      //                       child: IconButton(
      //                           onPressed: () {},
      //                           icon: const Icon(
      //                             Icons.add,
      //                             color: Apc.white,
      //                           )),
      //                     ),
      //                     const Text('')
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         );
      //       }),
      //     ),
      //   ],
      // ),
    );
  }
}
