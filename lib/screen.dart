import 'dart:convert';
import 'package:api/modal.dart';
import 'package:api/newsmodal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:api/modal.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _screenState createState() => _screenState();
}

class _screenState extends State<screen> {
 // late newsmodal news;
  Widget listViewWidget(List<Articles> article){

    return ListView.builder(

        scrollDirection: Axis.vertical,
        itemCount: article.length,
        itemBuilder: (context,index){
          return Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                height: 150,
                width: MediaQuery.of(context).size.width,
                //color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(article[index].urlToImage.toString()),
                              fit: BoxFit.cover)
                      ),
                      //color: Colors.yellow,
                    ),
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width-160,
                      color: Colors.orange,
                     child: Text(
                        article[index].title.toString(),
                      ),

                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
            ],
          );
        }

    );

  }

  Future <List<Articles>>getNews() async{
    List<Articles> catdata = [];
    var url= "https://newsapi.org/v2/everything?q=apple&from=2022-04-25&to=2022-04-25&sortBy=popularity&apiKey=10fdd0b6b3654ad0b7ae034e9049d98f";
    var response = await http.get (Uri.parse(url));
    print(response);
    if(response.statusCode==200)
    {
      var data= json.decode(response.body);
      var rest = data['articles'] as List;
      print(rest);
      catdata = rest.map<Articles>((json) => Articles.fromJson(json)).toList();
    }
    return catdata;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Api"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child:Container(
          height: 250,
          width: 200,
          child: FutureBuilder<Iterable>(
            future: getNews(),
            builder: (context, snapshot) {
              return snapshot.data != null
                  ? listViewWidget(
                  List<Articles>.from(snapshot.data!))
                  : const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
