import 'dart:convert';

import 'package:apifake/model/model.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyShop extends StatefulWidget {
  const MyShop({Key? key});

  @override
  State<MyShop> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyShop> {
  List<FakeStoreApi> userApiDataList = [];
  FakeStoreApi? newWorkApiDataModel;
  bool isloading = true;

  Future<void> fetchData() async {
    setState(() {
      isloading = true;
    });

    try {
      var url = Uri.parse("https://fakestoreapi.com/users");
      var response = await http.get(url);

      print('status code is: ${response.statusCode}');

      if (response.statusCode == 200) {
        print("response status: ${response.statusCode}");
        print('response body: ${response.body}');
        final List<dynamic> responseData = jsonDecode(response.body);
        userApiDataList =
            responseData.map((data) => FakeStoreApi.fromJson(data)).toList();
      } else {
        print('response is: ${response.statusCode}, ${response.reasonPhrase}');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Something wrong")));
      }
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("An error occurred")));
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => fetchData(),
        child: Icon(Icons.refresh),
      ),
      body: isloading
          ? Center(child: CircularProgressIndicator())
          : userApiDataList.isEmpty
              ? Center(child: Text("No data available"))
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                    thickness: 2,
                  ),
                  itemCount: userApiDataList.length,
                  itemBuilder: (context, index) {
                    final user = userApiDataList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            color: Colors.tealAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(" ${(user.name) ?? ''}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            Text(' ${user.password ?? ''}',
                                style: TextStyle(fontSize: 20)),
                            Container(
                                height: 200,
                                width: 200,
                                child: Text(
                                  ': ${user.email ?? ''}',
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
