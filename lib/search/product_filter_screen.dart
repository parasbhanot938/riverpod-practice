import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/search/product_model.dart';
import 'package:riverpod_demo/search/product_notifier.dart';

final productNotifierProvider =
    NotifierProvider<ProductNotifier, List<Product>>(() => ProductNotifier());

final textEditingControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();

  // Dispose the controller when it's no longer needed
  ref.onDispose(() {
    controller.dispose();
  });

  return controller;
});


class ProductFilterScreen extends ConsumerWidget {
  const ProductFilterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productNotifierProvider);
    final controller = ref.watch(textEditingControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: controller,
            onChanged: (value) {
              ref
                  .read(productNotifierProvider.notifier)
                  .filterProduct(query: value);
            },
          ),
          ListView.separated(
            itemCount: productList.length ?? 0,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemBuilder: (context, index) {
              return Text(productList[index].name);
            },
          )
        ],
      ),
    );
  }
}


