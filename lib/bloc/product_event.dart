
abstract class ProductEvent {}

class GetData extends ProductEvent {}

class AddCartEvent extends ProductEvent {
  final  int  vt;
  AddCartEvent({required this.vt});
}

class DelCartEvent extends ProductEvent {
  final  int  vt;
  DelCartEvent({required this.vt});
}

class AddAmountEvent extends ProductEvent {
  final  int  vt;
  AddAmountEvent({required this.vt});
}

class SubAmountEvent extends ProductEvent {
  final  int  vt;
  SubAmountEvent({required this.vt});
}

