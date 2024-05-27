import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    late dynamic cartItem;
    final cart = context.watch<CartProvider>().cart;
    //final cart = Provider.of<CartProvider>(context).cart;
    void removeProduct() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Delete Product',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            content: const Text('Are you sure you want to remove product'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CartProvider>().removeProduct(cartItem);
                      // Provider.of<CartProvider>(context, listen: false)
                      //     .removeProduct(cartItem);

                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          elevation: 0,
        ),
        body: ListView.builder(
            itemCount: cart.length,
            itemBuilder: (context, index) {
              cartItem = cart[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    cartItem['imageUrl'] as String,
                  ),
                ),
                trailing: IconButton(
                  onPressed: removeProduct,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  cartItem['title'].toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text('size: ${cartItem['size']}'),
              );
            }));
  }
}
