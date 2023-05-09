import 'package:flutter_food_delivery/data/repository/recommended_product_repo.dart';
import 'package:flutter_food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepository;

  RecommendedProductController({required this.recommendedProductRepository});

  List<ProductsModel> _recommendedProductList = [];
  List<ProductsModel> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepository.getRecommendedProductList();

    try {
      if (response.statusCode == 200) {
        print("önerilen ürünler başarıyla geldi.");
        // burda yeniden boş liste atıyoruz. Çünkü bu işlem birden fazla kez
        //çalıştırabilir. önceki ürünleri tekrar etmemesi için listeyi sıfırlıyoruz.
        _recommendedProductList = [];
        _recommendedProductList
            .addAll(Product.fromJson(response.body).products);
        print(_recommendedProductList);
        print(_recommendedProductList.map((e) => e.name));
        _isLoaded = true;
        update();
      } else {
        print("Önerilen ürünlerde Hata oluştu ve hata = " + response.body);
      }
    } catch (e) {
      print("Recommended Controller da hata =  " + e.toString());
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = _quantity + 1;
    } else {
      _quantity = _quantity - 1;
    }
  }
}
