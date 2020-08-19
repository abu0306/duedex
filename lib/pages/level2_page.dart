import 'package:duedex_order/blocs/Level2/level2_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LevelePage extends StatefulWidget {
  @override
  _LevelePageState createState() => _LevelePageState();
}

class _LevelePageState extends State<LevelePage> {
  List<List<dynamic>> _bids = [];

  List<List<dynamic>> _asks = [];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => Level2Bloc()..add(Subscribe()),
          )
        ],
        child: BlocConsumer<Level2Bloc, Level2State>(builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF171733),
              title: Text("OrderBook"),
              centerTitle: true,
            ),
            body: Container(
              color: Color(0xFF141425),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverFixedExtentList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return Level2Item(_asks[index], Colors.red);
                            }, childCount: _asks.length),
                            itemExtent: 30),
                        SliverToBoxAdapter(
                          child: () {
                            if (_bids.length == 0) {
                              return Container();
                            } else {
                              return Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        "\$--",
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "/",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "--",
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 12),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          }(),
                        ),
                        SliverFixedExtentList(
                            delegate:
                                SliverChildBuilderDelegate((context, index) {
                              return Level2Item(_bids[index], Colors.green);
                            }, childCount: _bids.length),
                            itemExtent: 30),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }, listener: (context, state) {
          if (state is Level2Update) {
            _bids = state.bids;
            _asks = state.asks;
          }
        }));
  }
}

class Level2Item extends StatelessWidget {
  final List<dynamic> data;
  final Color color;

  Level2Item(this.data, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Text(
              "${data.first}",
              style: TextStyle(
                color: this.color,
                fontSize: 12,
              ),
            ),
          ),
          Container(
            child: Text(
              "${data.last}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
