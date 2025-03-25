import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';
import '../models/product.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [])) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<IncreaseQuantity>(_onIncreaseQuantity);
    on<DecreaseQuantity>(_onDecreaseQuantity);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final existingIndex = state.items
        .indexWhere((item) => item.product.id == event.product.id);

    if (existingIndex >= 0) {
      final updatedItems = List<CartItem>.from(state.items);
      updatedItems[existingIndex] = CartItem(
        product: updatedItems[existingIndex].product,
        quantity: updatedItems[existingIndex].quantity + 1,
      );
      emit(state.copyWith(items: updatedItems));
    } else {
      emit(state.copyWith(items: [...state.items, CartItem(product: event.product)]));
    }
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    emit(state.copyWith(
        items: state.items
            .where((item) => item.product.id != event.product.id)
            .toList()));
  }

  void _onIncreaseQuantity(IncreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.product.id) {
        return CartItem(product: item.product, quantity: item.quantity + 1);
      }
      return item;
    }).toList();
    emit(state.copyWith(items: updatedItems));
  }

  void _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) {
    final updatedItems = state.items.map((item) {
      if (item.product.id == event.product.id) {
        final newQuantity = item.quantity - 1;
        if (newQuantity <= 0) {
          return null;
        }
        return CartItem(product: item.product, quantity: newQuantity);
      }
      return item;
    }).whereType<CartItem>().toList();
    emit(state.copyWith(items: updatedItems));
  }
}