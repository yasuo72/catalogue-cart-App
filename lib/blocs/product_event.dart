abstract class ProductEvent {}

class FetchProducts extends ProductEvent {
  final int skip;
  final int limit;

  FetchProducts({this.skip = 0, this.limit = 10});
}