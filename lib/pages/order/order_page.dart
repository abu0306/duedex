import 'dart:convert';

import 'package:duedex_order/blocs/order/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {


    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (ctx) => OrderBloc()..add(ConnectWebSocket())),
        ],
        child: BlocConsumer<OrderBloc, OrderState>(
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Text("订单"),
                  centerTitle: true,
                ),
                body: Container(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return OrderItem();
                    },
                    itemCount: 2,
                  ),
                ),
              );
            },
            listener: (context, state) {}));
  }
}

class OrderItem extends StatefulWidget {
  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            color: Colors.teal,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  alignment: Alignment.centerLeft,
                  child: Text("BTC_USD"),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text("委托价格"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "100000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text("数量"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "100000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text("类型"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "限价",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text("状态"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "未成交",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                child: Text("委托价格"),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  "100000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  child: Text("数量"),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    "100000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
