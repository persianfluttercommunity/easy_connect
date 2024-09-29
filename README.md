# easy_connect

A Flutter package for making api requests easy to use and simple including bearer token authentication.

## Usage

[Example](https://github.com/persianfluttercommunity/easy_connect/blob/master/example/lib/main.dart)

To use this package :

* add the dependency to your [pubspec.yaml](https://github.com/persianfluttercommunity/easy_connect/blob/master/pubspec.yaml) file.

```yaml
  dependencies:
    flutter:
      sdk: flutter
    easy_connect: latest version
```

### How to use

```dart
import 'package:easy_connect/easy_connect.dart';
import 'package:flutter/material.dart';

// you can make a map of your app requests
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
    // in this simple step you get data from api
    var response = await Api(requests["fact"]!).connect();
    // and update ui
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
            // call api function above
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

```

# License
Copyright (c) 2020 Sayed Mohammad Amin Emrani

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
