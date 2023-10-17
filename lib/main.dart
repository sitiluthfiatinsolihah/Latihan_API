import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final apiUrl =
        "http://localhost/latihan_fia/fia.php"; // Ganti dengan URL API PHP Anda

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final ready = json.decode(response.body);
      setState(() {
        data = List<Map<String, dynamic>>.from(ready);
        print(data);
      });
    } else {
      print("Gagal mengambil data dari API.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LATIHAN API SITI LUTHFIATIN SOLIHAH'),
        ),
        body: Center(
          child: data.isNotEmpty
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return Column(
                      children: <Widget>[
                        Image.network(item["gambar"]),
                        Text(item["nm_barang"]), // Ganti engan nama kolom yang sesuai
                        // Tambahkan tampilan lainnya sesuai kebutuhan
                      ],
                    );
                  },
                )
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
