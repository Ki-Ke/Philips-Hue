import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'rest.dart';

void main() => runApp(PhilipsHue());

class PhilipsHue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Philips Hue Notifier',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(title: 'Philips Hue'),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String ip;
  String internalipaddress;
  IPResponse ipDetails;
  Future<GetUserId> username;
  bool isNewUser;

  @override
  void initState() {
    super.initState();
    _getPrefs();
  }

  Future<bool> _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user') == '' ? true : false;
  }

  void _setUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ipDetails = await fetchIp();
    setState(() {
      internalipaddress = ipDetails.internalipaddress;
      ip = ipDetails.id;
    });
    prefs.setString('user', username.toString());
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
            Text(
              '$internalipaddress',
            ),
            Text(
              '$ip',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setUser,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
