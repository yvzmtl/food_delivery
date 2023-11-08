
import 'package:flutter/material.dart';
import 'package:flutter_food_delivery/base/custom_app_bar.dart';
import 'package:flutter_food_delivery/controllers/auth_controller.dart';
import 'package:flutter_food_delivery/controllers/order_controller.dart';
import 'package:flutter_food_delivery/pages/order/view_order.dart';
import 'package:flutter_food_delivery/utils/colors.dart';
import 'package:flutter_food_delivery/utils/dimensions.dart';
import 'package:get/get.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {

  late TabController _tabController;
    late bool _isLoggedIn;

  void initState(){
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Siparişlerim"),
      body: Column(
        children: [
          Container(
            width: Dimensions.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: [
                Tab(text: "Mevcut Siparişler"),
                Tab(text: "Sipariş Geçmişi")
              ]),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ViewOrder(isCurrent: true),
                ViewOrder(isCurrent: false),
            ]),
          ),
        ],
      )
    );
  }
}