import '../models/product_model.dart';
import '../models/purchase_model.dart';

abstract class PurchasesRemoteDataSource {
  Future<List<ProductModel>> getProducts({required String businessId});
  Future<PurchaseModel> createPurchase({
    required String userId,
    required String businessId,
    required String productId,
  });
  Future<List<PurchaseModel>> getUserPurchases({required String userId});
}
