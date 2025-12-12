import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/product_model.dart';
import '../models/purchase_model.dart';
import 'purchases_remote_data_source.dart';

class PurchasesRemoteDataSourceImpl implements PurchasesRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  PurchasesRemoteDataSourceImpl({required this.firebaseFirestore});

  static const String _productsCollection = 'products';
  static const String _purchasesCollection = 'purchases';

  @override
  Future<List<ProductModel>> getProducts({required String businessId}) async {
    final querySnapshot = await firebaseFirestore
        .collection(_productsCollection)
        .where('businessId', isEqualTo: businessId)
        .get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  @override
  Future<PurchaseModel> createPurchase({
    required String userId,
    required String businessId,
    required String productId,
  }) async {
    final purchaseId = const Uuid().v4();
    final now = DateTime.now();

    // Fetch product to calculate price (and possible discount)
    final productDoc = await firebaseFirestore
        .collection(_productsCollection)
        .doc(productId)
        .get();
    if (!productDoc.exists) {
      throw Exception('Product not found');
    }

    final productData = productDoc.data() as Map<String, dynamic>;
    final price = (productData['price'] as num).toDouble();
    final discountedPrice = productData['discountedPrice'] != null
        ? (productData['discountedPrice'] as num).toDouble()
        : null;

    final amount = discountedPrice ?? price;

    final purchaseData = {
      'id': purchaseId,
      'userId': userId,
      'productId': productId,
      'businessId': businessId,
      'amount': amount,
      'purchasedAt': now.toIso8601String(),
    };

    await firebaseFirestore
        .collection(_purchasesCollection)
        .doc(purchaseId)
        .set(purchaseData);

    return PurchaseModel.fromJson(purchaseData);
  }

  @override
  Future<List<PurchaseModel>> getUserPurchases({required String userId}) async {
    final querySnapshot = await firebaseFirestore
        .collection(_purchasesCollection)
        .where('userId', isEqualTo: userId)
        .get();

    return querySnapshot.docs
        .map((doc) => PurchaseModel.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }
}
