import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/model.dart';
import 'package:http/http.dart' as http;

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<ReponseModel> getApi() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=24.8607&lon=67.0011&appid=d32e8f6a3baa434890620250a16d9d08'));

    http.StreamedResponse response = await request.send();

    http.Response r = await http.Response.fromStream(response);
    var result = reponseModelFromJson(r.body);
    if (response.statusCode == 200) {
      return result;
    } else {
      print(response.reasonPhrase);
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/bi.jpg"), fit: BoxFit.cover),
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Stack(children: [
              FutureBuilder(
                future: getApi(),
                builder: (context, AsyncSnapshot<ReponseModel> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Positioned(
                              height: 100,
                              width: 100,
                              child: Text(
                                snapshot.data!.name.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    return Text('loading');
                  }
                },
              )
            ]))));
  }
}
