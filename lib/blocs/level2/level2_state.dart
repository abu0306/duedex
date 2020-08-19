part of 'level2_bloc.dart';

abstract class Level2State extends Equatable {
  const Level2State();

  @override
  List<Object> get props => [DateTime.now().microsecondsSinceEpoch];
}

class Level2Initial extends Level2State {}

class Level2Update extends Level2State {
  final List<List<dynamic>> bids;

  final List<List<dynamic>> asks;

  Level2Update(this.bids, this.asks);

  @override
  // TODO: implement props
  List<Object> get props => [bids, asks, DateTime.now().microsecondsSinceEpoch];
}
