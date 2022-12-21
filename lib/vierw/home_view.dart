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
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bi.jpg"), fit: BoxFit.cover),
          ),
          child: FutureBuilder(
            future: getApi(),
            builder: (context, AsyncSnapshot<ReponseModel> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Country : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data!.sys.country.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "City : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data!.name.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                              height: 100,
                              width: 80,
                              child: Image(
                                  image: AssetImage('assets/temperature.png'))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Temp : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data!.main.temp.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Container(
                              height: 100,
                              width: 80,
                              child:
                                  Image(image: AssetImage('assets/gauge.png'))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Pressure :",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data!.main.pressure.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Feels Like : ",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                snapshot.data!.main.feelsLike.toString(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return Text('loadinggggggggggg');
              }
            },
          ),
        )));
  }
}
