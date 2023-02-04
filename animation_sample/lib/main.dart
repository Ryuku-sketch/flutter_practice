import 'package:animation_sample/notification_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final NotificationService _notificationService = NotificationService();
  @override
  void initState() {
    super.initState();
    _notificationService.init(context: context);
    // WidgetsBinding.instance.addObserver();
  }

  // void listenNotifications() =>
  //     _notificationService.notificationStream.stream.listen((event) {
  //       callBackFunction(event);
  //     });
  // void callBackFunction(NotificationResponse? payload) {
  //   print('This is just callback??');
  // }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // FlutterAppBadger.removeBadge();
      print('App is resumed');
    }
    if (state == AppLifecycleState.paused) {
      print('App is paused');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.all(15),
                child: PushNotification(
                  icon: const Icon(Icons.notification_important),
                  label: 'Push Notification Test1',
                  onPress: () {
                    print('Pushed Test1');
                    _notificationService.sendPushNotification(
                        id: 0,
                        title: 'Test1',
                        body:
                            'This should be running since the taskDue is within 3days',
                        payLoad: 'Result as expected',
                        now: DateTime.parse('20230204'),
                        taskDue: DateTime.parse('20230205'));
                  },
                )),
            Padding(
                padding: const EdgeInsets.all(15),
                child: PushNotification(
                  icon: const Icon(Icons.home),
                  label: 'Push Notification Test2',
                  onPress: () {
                    print('Pushed Test2');
                    _notificationService.sendPushNotification(
                        id: 0,
                        title: 'Test2',
                        body:
                            'It will not be running because taskDue is not within 3 days',
                        payLoad: 'Should not be running',
                        now: DateTime.now(),
                        taskDue: DateTime.parse('20240205'));
                  },
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PushNotification extends StatefulWidget {
  const PushNotification(
      {required this.icon,
      required this.label,
      required this.onPress,
      Key? key})
      : super(key: key);

  final Icon icon;
  final String label;
  final VoidCallback onPress;

  @override
  State<PushNotification> createState() => _PushNotification();
}

class _PushNotification extends State<PushNotification> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: widget.onPress,
        icon: widget.icon,
        label: Text(widget.label));
  }
}
