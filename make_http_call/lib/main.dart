import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(MaterialApp(home: GetDataScreenState()));
}

class GetDataScreenState extends StatefulWidget {
  const GetDataScreenState({Key? key}) : super(key: key);

  @override
  State<GetDataScreenState> createState() => _GetDataScreenStateState();
}

class _GetDataScreenStateState extends State<GetDataScreenState> {
  String fetchedData="Data will appear here!!!";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () async{
            fetchedData= await getData();
            setState(() {
              fetchedData=fetchedData;
            });
          }, child: const Text('Get Data'),
          ),const SizedBox(height: 30,),
          Text(fetchedData.toString())
        ],
      )),
    );
  }
}

Future<String> getData() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));
  String data = "";
  // Await the http get response, then decode the json-formatted response.
  if (response.statusCode == 200) {
    var jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    var title = jsonResponse['title'];
    data = title.toString();
    print('Title is : $title. :)');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  return data;
}
