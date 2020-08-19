part of 'level2_bloc.dart';

abstract class Level2Event extends Equatable {
  const Level2Event();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class Subscribe extends Level2Event {}

class Level2UpdateEvent extends Level2Event {
  final List<List<dynamic>> bids;

  final List<List<dynamic>> asks;

  Level2UpdateEvent(this.bids, this.asks);

  @override
  // TODO: implement props
  List<Object> get props => [asks, bids, DateTime.now().microsecondsSinceEpoch];
}
