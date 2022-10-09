import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeProductRepository {
  //FakeProductRepository._();
  // Private constructor; prevents us for creating a new instance of the
  // repository by calling FakeProductRepository(). This way you can only access
  // the repository with the instance below.
  // static FakeProductRepository instance = FakeProductRepository._(); //Not needed anymore since we've converted to provider
  //The only way you can access the repository is by using this instance.

  final List<Product> _products = kTestProducts;

  List<Product> getProductList() {
    return _products;
  }

  Product? getProduct(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  // For REST APIs
  Future<List<Product>> fetchProductsList() async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Connection Failed'); // For testing error state
    return Future.value(_products);
  }

  // For real-time APIs (e.g. web sockets, Firebase)
  Stream<List<Product>> watchProductList() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) {
    return watchProductList().map((products) => products.firstWhere((product) => product.id == id));
  }
}

final productRepositoryProvider = Provider.autoDispose<FakeProductRepository>((ref) {
  return FakeProductRepository();
});

final productsListStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  final productRepository =
      ref.watch(productRepositoryProvider); // retreived the products repository
  return productRepository.watchProductList(); //used the product repository to return a stream
});

final productsListFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  final productRepository =
      ref.watch(productRepositoryProvider); // retreived the products repository
  return productRepository.fetchProductsList(); //used the product repository to return a stream
});

// The family modifier: allows you to passan argument along with ref to the provider
final productProvider = StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  final productRepository = ref.watch(productRepositoryProvider);
  return productRepository.watchProduct(id);
});
