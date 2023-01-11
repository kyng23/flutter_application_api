import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_api/service/data_service.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<DataService>> apiCall() async {
    var url =
        'https://www.7timer.info/bin/astro.php?lon=113.2&lat=23.1&ac=0&unit=metric&output=json&tzshift=0';
    var response = await http.get(Uri.parse(url));
    List<DataService> datas = [];

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        datas.add(DataService.fromJson(dataJson));
      }
    } else {
      throw Exception("Failed to Load");
    }
    return datas;
  }

  List<DataService> _datas = [];
  @override
  void initState() {
    apiCall().then((value) {
      setState(() {
        _datas.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather Datas")),
        body: ListView.builder(
            itemBuilder: ((context, index) {
              return Card(
                  child: Column(
                children: [Text(_datas[index].text), Text(_datas[index].title)],
              ));
            }),
            itemCount: 1));
  }
}
