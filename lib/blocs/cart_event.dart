import '../models/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;

  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;

  RemoveFromCart(this.product);
}

class IncreaseQuantity extends CartEvent {
  final Product product;

  IncreaseQuantity(this.product);
}

class DecreaseQuantity extends CartEvent {
  final Product product;

  DecreaseQuantity(this.product);
}