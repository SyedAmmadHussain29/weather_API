import 'package:flutter/material.dart';
import 'package:flutter_application_1/service/api_service.dart';

import '../model/user_model.dart'; 

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  submitForm() async {
    ApiService _apiService = ApiService();
    List<Users> eachposts = await _apiService.fetchUsers();
    return eachposts;
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      
      body: SizedBox(
       width: MediaQuery.of(context).size.width,
       height: MediaQuery.of(context).size.height, 
        child: FutureBuilder(
          future: submitForm(),
          builder: (context,AsyncSnapshot snapshot) {

            if(snapshot.hasData){
            return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {


                          // print(;

                          return  Container(
              height: 70,
       padding: const EdgeInsets.only(bottom: 10), 

              width: MediaQuery.of(context).size.width,
              color: Colors.white70,
              child: Row( 
                children: [
                   CircleAvatar(
                    maxRadius: 50,
                  ),
                    Text( 
                      snapshot.data[index].name.toString()),
                ], 
              ));});
          }
        return Center(child: CircularProgressIndicator());
          }
          
        ),
      ));
     
  } 


}