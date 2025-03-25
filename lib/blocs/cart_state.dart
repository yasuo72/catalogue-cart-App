import '../models/cart_item.dart';

class CartState {
  final List<CartItem> items;

  CartState({required this.items});

  double get totalPrice =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  CartState copyWith({
    List<CartItem>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }
}