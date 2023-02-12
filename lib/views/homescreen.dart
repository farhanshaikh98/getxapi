import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:getxapi_demo/controllers/homecontroller.dart';
import 'package:http/http.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  HomeController mycontroller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => mycontroller.isDataLoading.value
          ? const Center(child: CircularProgressIndicator())
          : _builScreen()),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          mycontroller.onActiveVisitors();
        }),
        child: Icon(Icons.reddit),
      ),
    );
  }

  Widget _builScreen() {
    return ListView.builder(
        itemCount: mycontroller.result?.data.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  padding: const EdgeInsets.only(left: 20),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                            mycontroller.result!.data[index].picture),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mycontroller.result!.data[index].firstName
                                .toUpperCase(),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 18),
                          ),
                          Text(mycontroller.result!.data[index].lastName,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                          Text(
                              mycontroller.result!.data[index].title.toString(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        ],
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              )
            ],
          );
        });
  }
}
