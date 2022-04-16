import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_aldi/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  final Map product;

  EditProduct({required this.product});
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _DescriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _imageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _latest_article_publishedController =
      TextEditingController();
  Future updateProduct() async {
    final response = await http.put(
        Uri.parse(
            "http://10.0.2.2:8000/api/authors/" + product['id'].toString()),
        body: {
          "name": _nameController.text,
          "description": _DescriptionController.text,
          "price": _priceController.text,
          "image": _imageController.text,
          "location": _locationController.text,
          "latest_article_published": _latest_article_publishedController.text,
        });
    print(response.body);
    return json.decode(response.body);
  }

  get value => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit product"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _nameController..text = product['name'],
              decoration: InputDecoration(labelText: "Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _DescriptionController..text = product['description'],
              decoration: InputDecoration(labelText: "Description"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product description";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _priceController..text = product['price'],
              decoration: InputDecoration(labelText: "Price"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product price";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _imageController..text = product['image'],
              decoration: InputDecoration(labelText: "Image"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product Image ";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _locationController..text = product['location'],
              decoration: InputDecoration(labelText: "Location"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product Location ";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _latest_article_publishedController
                ..text = product['latest_article_published'],
              decoration:
                  InputDecoration(labelText: "latest_article_published"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter product latest_article_published ";
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateProduct().then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Produk berhasil di ubah"),
                      ));
                    });
                  }
                },
                child: Text("Update"))
          ],
        ),
      ),
    );
  }
}
