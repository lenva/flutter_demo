import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'simple_page_widgets.dart';
import 'tap_repair_v112.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    FlutterBoost.singleton.registerPageBuilders({
      'embeded': (pageName, params, _)=>EmbededFirstRouteWidget(),
      'first': (pageName, params, _) => FirstRouteWidget(),
      'second': (pageName, params, _) => SecondRouteWidget(),
      'tab': (pageName, params, _) => TabRouteWidget(),
      'platformView': (pageName, params, _) => PlatformRouteWidget(),
      'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),
      ///可以在native层通过 getContainerParams 来传递参数
      'flutterPage': (pageName, params, _) {
        print("flutterPage params:$params");

        return FlutterRouteWidget(params:params);
      },
    });
    FlutterBoost.singleton.addBoostNavigatorObserver(TestBoostNavigatorObserver());

    BoostContainerLifeCycleObserver observer = (state, setting) {
      if (ContainerLifeCycle.Appear == state) {
        TapGestureRepairV112State currentState = _tapRepairKey.currentState;
        currentState?.repairPointer();
      }
    };
    FlutterBoost.singleton.observersHolder.addObserver(observer);
  }

  GlobalKey _tapRepairKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return TapGestureRepairV112(
      key: _tapRepairKey,
      child: MaterialApp(
        title: 'Flutter Boost example',
        builder: FlutterBoost.init(postPush: _onRoutePushed),
        home: Container(color: Colors.white),
      ),
    );
  }

  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {
  }
}
class TestBoostNavigatorObserver extends NavigatorObserver{
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {

    print("flutterboost#didPush");
  }

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("flutterboost#didPop");
  }

  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    print("flutterboost#didRemove");
  }

  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    print("flutterboost#didReplace");
  }
}

