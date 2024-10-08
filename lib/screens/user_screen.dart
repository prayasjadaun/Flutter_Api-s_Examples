import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/components/reusableRow.dart';
import 'package:flutter_rest_api/models/user_model.dart';

import "package:http/http.dart" as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        UserModel userModel = UserModel();
        userList.add(UserModel.fromJson(i as Map<String, dynamic>));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Api'),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getUserApi(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              } else {
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(children: [
                          ReusableRow(
                              title: "Name",
                              value: snapshot.data![index].name.toString()),
                          ReusableRow(
                              title: "Username",
                              value: snapshot.data![index].username.toString()),
                          ReusableRow(
                              title: "Email",
                              value: snapshot.data![index].email.toString()),
                          ReusableRow(
                            title: "Address",
                            value:
                                snapshot.data![index].address!.city.toString() +
                                    snapshot.data![index].address!.zipcode
                                        .toString(),
                          )
                        ]),
                      );
                    });
              }
            },
          ))
        ],
      ),
    );
  }
}
