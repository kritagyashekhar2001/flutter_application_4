import 'package:flutter/material.dart';
import 'package:flutter_application_4/screens/bloc/news_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController keyController;
  @override
  void initState() {
    keyController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(title: const Text("News App")),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      controller: keyController,
                      decoration:
                          const InputDecoration(hintText: "Enter the key here"),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context)
                            .add(FetchNews(keyController.text));
                      },
                      child: const Text("Submit"),
                    ),
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is NewsFetched) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.news?.articles?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state.news?.articles?[index].title ?? "",
                                      style: TextStyle(
                                          fontSize: height * 0.025,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.blue),
                                    ),
                                    Text(
                                      state.news?.articles?[index].content ??
                                          "",
                                      style: TextStyle(
                                          fontSize: height * 0.015,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is NewsLoading) {
                      return const Text("Loading");
                    } else if (state is NewsError) {
                      return const Text("Some error occured");
                    }
                    return Container();
                  },
                ),
              )
            ],
          ),
        ));
  }
}
