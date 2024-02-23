import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout/layout.dart';
import 'package:melonkemo/pages/sushiro/sushiro_main_provider.dart';
import 'package:provider/provider.dart';

class SushiroPocMainPage extends StatefulWidget {
  const SushiroPocMainPage({Key? key}) : super(key: key);

  @override
  State<SushiroPocMainPage> createState() => _SushiroPocMainPageState();
}

class _SushiroPocMainPageState extends State<SushiroPocMainPage> {
  late final SushiroMainProvider _provider;

  double tableWidth = 30;

  final LayoutValue<double> areaWidth = LayoutValue.builder((layout) {
    return layout.width <= 500 ? layout.width : 500;
  });

  double cardSize(BuildContext context) =>
      (areaWidth.resolve(context) - tableWidth - 100) / 2;

  @override
  void initState() {
    _provider = SushiroMainProvider();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return ChangeNotifierProvider(
      create: (_) => _provider,
      builder: (BuildContext ct, Widget? widget) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  width: areaWidth.resolve(ct),
                  margin: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Container(
                        width: areaWidth.resolve(ct),
                        height: 30,
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: cardSize(ct),
                              height: cardSize(ct) * 3,
                              child: _listView(ct)),
                          Container(
                              width: tableWidth,
                              height: cardSize(ct) * 3,
                              color: Colors.black),
                          Container(
                              width: cardSize(ct),
                              height: cardSize(ct),
                              color: Colors.grey)
                          //_listView(ct)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _listView(BuildContext context) {
    return ListView.separated(
      shrinkWrap: false,
      itemCount: 3,
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        width: 25,
        height: 25,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _peopleListItem(context);
      },
    );
    // return ListView(
    //   physics: const NeverScrollableScrollPhysics(),
    //   children: [
    //     _peopleListItem(context),
    //     _peopleListItem(context),
    //     _peopleListItem(context),
    //   ],
    // );
  }

  Widget _peopleListItem(BuildContext context) {
    return Container(
      width: cardSize(context),
      height: cardSize(context),
      color: Colors.blue,
    );
  }
}
