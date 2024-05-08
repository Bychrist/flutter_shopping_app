import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, Object> product;
  const ProductDetailPage({super.key, required this.product});

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
              product['title'] as String,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image(
              image: AssetImage(
                product['imageUrl'] as String,
              ),
            ),
          ),
          const Spacer(flex: 2),
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Column(children: [
              Text(
                '\$${product['price']}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: (product['sizes'] as List<int>).length,
                  itemBuilder: (context, index) {
                    final size = (product['sizes'] as List<int>)[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Chip(
                        label: Text(size.toString()),
                      ),
                    );
                  },
                ),
              )
            ]),
          ),
        ]),
      ),
    );
  }
}
