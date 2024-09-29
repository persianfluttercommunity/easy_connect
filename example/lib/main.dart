import 'package:easy_connect/easy_connect.dart';
import 'package:flutter/material.dart';

Map<String, ApiRequest> requests = {
  "fact": ApiRequest(
    route: "/fact", // or "fact"
    type: RequestType.get, // or RequestType.post or ...
  ),
};

void main() {
  // set easy_connect config
  setEasyConnectConfig(EasyConnectConfig(
    url: "https://catfact.ninja",
    timeout: const Duration(seconds: 10), // is optional
  ));
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String fact = "";
  bool progress = false;

  Future<void> getNewFact() async {
    setState(() => progress = true);
    var response = await Api(requests["fact"]!).connect();
    setState(() {
      progress = false;
      fact = response.content["fact"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getNewFact();
          },
          child: const Text("Fact"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: progress ? const CircularProgressIndicator() : Text(fact),
          ),
        ),
      ),
    );
  }
}
