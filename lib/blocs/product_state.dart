import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductState {
  final List<Product> products;
  final bool isLoading;
  final int total;
  final int skip;
  final int limit;

  ProductState({
    required this.products,
    required this.isLoading,
    required this.total,
    required this.skip,
    required this.limit,
  });



  ProductState copyWith({
    List<Product>? products,
    bool? isLoading,
    int? total,
    int? skip,
    int? limit,
  }) {
    return ProductState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      total: total ?? this.total,
      skip: skip ?? this.skip,
      limit: limit ?? this.limit,
    );
  }
}