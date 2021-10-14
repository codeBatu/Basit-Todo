import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

main(List<String> args) {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Model {
  String? title;
  String? data;
  String? details;
}

class Archive {
  String? title;
  String? data;
}

List<Archive> modelList2 = [];
List<Model> modelList = [];

class _HomePageState extends State<HomePage> {
  // int listCount = modelList.length;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        actions: [
          Center(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) {
                          return const CompletedPage();
                        },
                      ),
                    );
                  },
                  icon: Stack(
                    children: [
                      const Icon(
                        Icons.shopping_basket,
                        size: 24,
                      ),
                      Positioned(
                        top: 1,
                        left: 15,
                        child: Text(
                          modelList2.length.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Görev    :",
                  style: TextStyle(fontSize: 24),
                ),
                Text(modelList.length.toString(),
                    style: const TextStyle(fontSize: 24)),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: modelList.length,
          separatorBuilder: (_, __) {
            return const Divider(
              height: 5,
              thickness: 1,
            );
          },
          itemBuilder: (BuildContext context, b) {
            return Dismissible(
              key: ValueKey<int>(b),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (x) {
                        return DetailsPage(
                            todoTitle: modelList[b].title.toString(),
                            todoDetails: modelList[b].details.toString());
                      },
                    ),
                  );
                },
                child: ListTile(
                  title: Text(
                    modelList[b].title.toString(),
                  ),
                  trailing: Text(modelList[b].data.toString()),
                ),
              ),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  Archive archive = Archive();
                  archive.title = modelList[b].title;

                  DateTime now = DateTime.now();
                  String formattedDate =
                      DateFormat('yyyy-MM-dd – kk:mm').format(now);
                  archive.data = formattedDate;

                  modelList2.add(archive);
                  modelList.removeAt(b);
                });
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (builder) {
                return AlertDialog(
                  actions: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            //   errorMaxLines: 3,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Todo Başlık Giriniz",
                            labelText: "Todo Başlık Giriniz"),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: textEditingController2,
                        decoration: const InputDecoration(
                            enabledBorder: InputBorder.none,
                            //   errorMaxLines: 3,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: "Todo Açıklama Giriniz",
                            labelText: "Todo Açıklama Giriniz"),
                      ),
                    ),
                    MaterialButton(
                        onPressed: () {
                          BottomSheet(
                              onClosing: () {},
                              builder: (builder) {
                                return const Text("data");
                              });
                          //   modelList = [];
                          if (textEditingController.text != "" &&
                              textEditingController2.text != "") {
                            Model model = Model();
                            model.title = textEditingController.text;
                            model.details = textEditingController2.text;
                            DateTime now = DateTime.now();
                            String formattedDate =
                                DateFormat('yyyy-MM-dd – kk:mm').format(now);
                            model.data = formattedDate;

                            modelList.add(model);

                            textEditingController2.text = "";
                            textEditingController.text = "";
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        child: const Text("Ekle")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  String? todoTitle;
  String? todoDetails;
  DetailsPage({Key? key, this.todoTitle, this.todoDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              todoTitle.toString(),
            ),
            Text(
              todoDetails.toString(),
            )
          ],
        ),
      ),
    );
  }
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tamamlanmış Görevler"),
      ),
      body: ListView.builder(
        itemCount: modelList2.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(
              modelList2[index].title.toString(),
            ),
            trailing: Text(
                "Görev Tamamlama Tarihi: \n${modelList2[index].data.toString()}"),
          );
        },
      ),
    );
  }
}
