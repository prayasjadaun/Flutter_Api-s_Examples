import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String url = "https://webhook.site/17d386e2-96f1-4753-9f17-e8609bc46886";
  List<ProductsModel> productsList = [];
  Future<ProductsModel> getProductsApi() async {
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<ProductsModel>(
              future: getProductsApi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(snapshot.data!.data![index].shop!.name
                                  .toString()),
                              subtitle: Text(snapshot
                                  .data!.data![index].shop!.shopemail
                                  .toString()),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot
                                    .data!.data![index].shop!.image
                                    .toString()),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              height: MediaQuery.of(context).size.height * .3,
                              width: MediaQuery.of(context).size.width * 10,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot
                                      .data!.data![index].images!.length,
                                  itemBuilder: (context, position) {
                                    return Container(
                                      padding:
                                          const EdgeInsets.only(right: 15.0),
                                      margin: const EdgeInsets.only(right: 10),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .25,
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(snapshot
                                                  .data!
                                                  .data![index]
                                                  .images![position]
                                                  .url
                                                  .toString())),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    );
                                  }),
                            ),
                            Icon(
                                snapshot.data!.data![index].inWishlist! == false
                                    ? Icons.favorite
                                    : Icons.favorite_outline),
                          ],
                        );
                      });
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
