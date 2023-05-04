import 'package:flutter_food_delivery/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepository;

  PopularProductController({required this.popularProductRepository});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  //List<ProductsModel> _popularProductList=[];
  //List<ProductsModel> get popularProductList => _popularProductList;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepository.getPopularProductList();

    try {
      if (response.statusCode == 200) {
        print("sunucudan ürünleri getir.");
        // burda yeniden boş liste atıyoruz. Çünkü bu işlem birden fazla kez
        //çalıştırabilir. önceki ürünleri tekrar etmemesi için listeyi sıfırlıyoruz.
        _popularProductList = [];
        // _popularProductList.addAll(Product.fromJson(response.body).products);
        print(_popularProductList);
        update();
      } else {
        print("Hata oluştu ve hata = " + response.body);
      }
    } catch (e) {
      print("Controller da hata =  " + e.toString());
    }
  }
}
