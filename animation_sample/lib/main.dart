import 'package:animation_sample/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      _notificationService.init(context: context);
      return;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
