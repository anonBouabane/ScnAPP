import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../models/cart.dart';

class CartController extends GetxController {
  Box<Cart> cartBox = Hive.box<Cart>('carts');
  RxList<Cart> carts = <Cart>[].obs;

  @override
  void onInit() {
    super.onInit();
    carts.assignAll(cartBox.values.toList());
  }

  void addCart(String number, int amount, String image) {
    final Cart newCart = Cart()
      ..number = number
      ..amount = amount
      ..houb = image;
    cartBox.add(newCart);
    carts.add(newCart);
  }

  void editCart(int index, String number, int amount, String image) {
    final Cart cart = carts[index];
    cart.number = number;
    cart.amount = amount;
    cart.houb = image;
    cart.save();
    carts[index] = cart;
  }

  void editNumber(int index, String number, String image) {
    final Cart cart = carts[index];
    cart.number = number;
    cart.houb = image;
    cart.save();
    carts[index] = cart;
  }

  void editAmount(int index, int amount) {
    final Cart cart = carts[index];
    cart.amount = amount;
    cart.save();
    carts[index] = cart;
  }

  void deleteCart(int index) {
    cartBox.deleteAt(index);
    carts.removeAt(index);
  }

  void clearCart() async {
    await cartBox.clear();
    carts.clear();
  }
}
