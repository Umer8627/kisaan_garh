import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisaan_garh/blocs/buyer_post_cubit/buyer_cubit.dart';
import 'package:timeago/timeago.dart' as tago;

import '../../../../blocs/buyer_post_cubit/buyer_cubit_states.dart';



class BuyerList extends StatefulWidget {


  final String docId;
  final String userType;
  const BuyerList({Key? key,required this.docId ,required this.userType}) : super(key: key);

  @override
  State<BuyerList> createState() => _BuyerListState();
}

class _BuyerListState extends State<BuyerList> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BuyerPostCubit>(context).loadPost();
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              BlocBuilder<BuyerPostCubit, BuyerPost>(
                builder: (context, state) {
                  if (state is BuyerPostLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is BuyerPostError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is BuyerPostLoaded) {
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
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Post By: ${data.postType}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange,fontSize: 12),),
                                    ],),
                                  Text(
                                    data.productName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(color: Colors.grey.shade900,fontWeight: FontWeight.w500,),
                                  ),

                                  Text(
                                    data.averagePrice,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4,
                                  ),
                                      Text(
                                        data.description,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        tago.format(
                                            data.publishedDate.toDate()),
                                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange,fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          );
                        });
                  }
                  return Container(
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}