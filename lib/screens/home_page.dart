import 'dart:math';

import 'package:colorgame/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return scaffold(context);
        },
      ),
    );
  }

  Scaffold scaffold(BuildContext context) {
    List<Color> data = context.watch<HomeBloc>().colors;
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text("Score: ${context.watch<HomeBloc>().natija}"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        actions: [
          Text(context.watch<HomeBloc>().timeCount.toString()),
        ],
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: Center(
                  child: Text(
                    "Click the ${context.watch<HomeBloc>().names[context.watch<HomeBloc>().random]}",
                    style: TextStyle(
                      fontSize: 30,
                      color:
                          context.watch<HomeBloc>().colors[Random().nextInt(5)],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    for (var i = 0;
                        i < context.watch<HomeBloc>().colors.length;
                        i++)
                      Padding(
                        padding: EdgeInsets.only(
                          left: Random().nextInt(300).toDouble(),
                          top: Random().nextInt(700).toDouble(),
                        ),
                        child: GestureDetector(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: data[i],
                          ),
                          onTap: context.watch<HomeBloc>().start == true
                              ? null
                              : () {
                                  context.read<HomeBloc>().rangTanla(i);
                                },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            child: Visibility(
              visible: context.watch<HomeBloc>().start,
              child: Container(
                height: 200,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.purpleAccent
                ),
                child: context.watch<HomeBloc>().natija != 0
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "SCORE: ${context.watch<HomeBloc>().natija}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          Text(
                            "Game over",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().startGame();
                            },
                            child: Text("START"),
                          )
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Start the game",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.read<HomeBloc>().startGame();
                            },
                            child: Text("START"),
                          )
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
