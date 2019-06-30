import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas Akhir Flutter Fundamelntal',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('OSG04028 - Mohamad Arif Mujaki'),
        ),
        body: Center(
          child: FutureBuilder<IPModel>(
            future: getDataIP(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('IP Address : ${snapshot.data.ip}'),
                    Text('City : ${snapshot.data.city}'),
                    Text('Region : ${snapshot.data.region}'),
                    Text('Country : ${snapshot.data.countryName}'),
                    Text('Provider : ${snapshot.data.org}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }

  Future<IPModel> getDataIP() async {
    http.Response res = await http.get('https://ipapi.co/json');
    // Respone from https://ipapi.co/json
    /*
      {
        "ip": "114.124.205.18",
        "city": "Jakarta",
        "region": "Jakarta",
        "region_code": "JK",
        "country": "ID",
        "country_name": "Indonesia",
        "continent_code": "AS",
        "in_eu": false,
        "postal": null,
        "latitude": -6.1741,
        "longitude": 106.8296,
        "timezone": "Asia/Jakarta",
        "utc_offset": "+0700",
        "country_calling_code": "+62",
        "currency": "IDR",
        "languages": "id,en,nl,jv",
        "asn": "AS23693",
        "org": "PT. Telekomunikasi Selular"
      }
    */
    if (res.statusCode == 200) {
      return IPModel.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
