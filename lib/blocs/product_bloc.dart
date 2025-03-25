import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/product.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc()
      : super(ProductState(
    products: [],
    isLoading: false,
    total: 0,
    skip: 0,
    limit: 10,
  )) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      final response = await http.get(Uri.parse(
          'https://dummyjson.com/products?skip=${event.skip}&limit=${event.limit}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('API Response: $data'); // Debug print

        final List<Product> products = (data['products'] as List)
            .map((product) => Product.fromJson(product))
            .toList();

        emit(state.copyWith(
          products: [...state.products, ...products],
          isLoading: false,
          total: data['total'],
          skip: data['skip'],
          limit: data['limit'],
        ));
      } else {
        emit(state.copyWith(isLoading: false));
        print('API Error: ${response.statusCode}');
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false));
      print('Error fetching products: $e');
    }
  }
}