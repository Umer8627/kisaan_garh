import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../../blocs/post_cubit/post_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.docId}) : super(key: key);
  final String? docId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostCubit>(context).loadPost();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        title: Text(
          "HomeScreen",
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<PostCubit, PostState>(
                builder: (context, state) {
                  if (state is PostLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PostError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is PostLoaded) {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.only(
                          left: 12,
                          right: 12,
                        ),
                        itemCount: state.postModel.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = state.postModel[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(
                                        1, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            data.productImage,
                                            height: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            data.productName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          Text(
                                            data.productName,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          Text(
                                            data.productDescription,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3,
                                          ),
                                          Text(
                                            data.price,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                          ),
                                          Text(
                                            tago.format(
                                                data.publishedDate.toDate()),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 163, 35, 35)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          );
                        });
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
