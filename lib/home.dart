import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'catogaries_modal.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  Widget listViewWidget(List<Data> article) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: article.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(
              right: 20,
            ),
            decoration: BoxDecoration(
              color: Color(int.parse(article[index].bgcolor)),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 0.5,
                color: Colors.transparent,
              ),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
                      margin: const EdgeInsets.only(
                        top: 11,
                        right: 23,
                        left: 23,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.0),
                        image: DecorationImage(
                          image: NetworkImage(article[index].icon),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 17.0),
                Container(
                  width: 92,
                  child: Text(
                    article[index].name.en,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'FirSans',
                      fontSize: 15.0,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                )
              ],
            ),
          );
        });
  }
  Future<List<Data>> getCategories() async {
    List<Data> catdata = [];
    var url = "https://anaajapp.com/api/categories";
    var response = await http.get(Uri.parse(url));
    print(response);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data['data'] as List;

      catdata = rest.map<Data>((json) => Data.fromJson(json)).toList();
    }

    return catdata;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api_Example"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        //color: Colors.green,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*1/5,
              width: MediaQuery.of(context).size.width,
             // color: Colors.blue,
            ),
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              //color: Colors.yellow,
              child: FutureBuilder<Iterable>(
                     future: getCategories(),
                     builder: (context, snapshot) {
                       return snapshot.data != null
                           ? listViewWidget(
                             List<Data>.from(snapshot.data!))
                         : const Center(
                             child: CircularProgressIndicator(),
                            );
                     },
                  ),

            ),
          ],
        ),
      ),
    );
  }
}
