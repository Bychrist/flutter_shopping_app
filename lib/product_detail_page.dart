import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class ProductDetailPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int selectedSize = 0;
  void onTap() {
    if (selectedSize != 0) {
      {
        Provider.of<CartProvider>(context, listen: false).addProduct({
          'id': widget.product['id '],
          'title': widget.product['title'],
          'price': widget.product['price'],
          'imageUrl': widget.product['imageUrl'],
          'company': widget.product['company'],
          'size': widget.product['size'],
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Product added successfully!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            'Please select a size',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Align(
            alignment: Alignment.center,
            child: Text('Details'),
          ),
        ),
        body: Column(children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.product['title'] as String,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 0),
            child: Image(
              image: AssetImage(
                widget.product['imageUrl'] as String,
              ),
              height: 250,
            ),
          ),
          const Spacer(flex: 1),
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                '\$${widget.product['price']}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (widget.product['sizes'] as List<int>).length,
                  itemBuilder: (context, index) {
                    final size = (widget.product['sizes'] as List<int>)[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: Chip(
                          backgroundColor: (selectedSize == size)
                              ? const Color.fromRGBO(254, 206, 1, 1)
                              : null,
                          label: Text(size.toString()),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350, 50),
                    backgroundColor: const Color.fromRGBO(254, 206, 1, 1),
                  ),
                  onPressed: onTap,
                  child: const Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
