import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_8_1/models/get_post.dart';
import 'package:lab_8_1/post/bloc/bloc/post_bloc.dart';

class BlocPage extends StatefulWidget {
  const BlocPage({super.key});

  @override
  State<BlocPage> createState() => _BlocPageState();
  }

class _BlocPageState extends State<BlocPage> {
  List<Posts> blocs = [];
  late PostBloc blocBloc;

  @override
  void initState() {
    blocBloc = PostBloc();
    blocBloc.add(GetPostEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: blocBloc,
      builder: (BuildContext context, state) {
        if (state is LoadingPostState) {
          return const CircularProgressIndicator();
        }
        if (state is PostLoaded) {
          blocs = state.posts;
          return buildBody();
        } else {
          return Center(child: Text("Same error"));
        }
      },
    );
  }

  Widget buildBody() {
    List<Widget> children = [];
    for (var item in blocs) {
      children.add(
        Column(
          children: [
            Text(item.body)],
        ),
      );
    }
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: children,
        ),
      ),
    );
  }
}