import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/counter_notifier.dart';
import 'package:riverpod_demo/post_list_screen.dart';
import 'package:riverpod_demo/search/product_filter_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProductFilterScreen(),
    );
  }
}


int addNumbers(int a, int b) {
  return a + b;
}

final streamProvider = StreamProvider<int>(
  (ref) {
    return Stream.periodic(
      const Duration(seconds: 1),
      (computationCount) => computationCount,
    );
  },
);

class Example extends ConsumerWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamData = ref.watch(streamProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("example"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          streamData.when(
            data: (data) {
              return Center(child: Text(data.toString()));
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }
}

var countProvider = StateNotifierProvider((ref) => CounterNotifier());
final nameProvider = Provider<String>(
  (ref) {
    return "Paras Bhanot";
  },
);
// var countProvider=StateProvider<int>((ref) {
//   return
//   0;
// },);

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    // ref.listen(countProvider, (previous, next) {
    //   debugPrint(previous.toString());
    //   debugPrint(next.toString());
    // },);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My home page"),
        actions: [
          IconButton(
              onPressed: () {
                // ref.invalidate(countProvider);

                ref.refresh(countProvider);
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Center(child: Text(count.toString())),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    // ref.read(countProvider.notifier).state++;

                    ref.read(countProvider.notifier).increment();
                    // ref.read(countProvider.notifier).update((state)=>state+1);
                    // countProvider++;
                  },
                  icon: const Icon(Icons.add)),
              Center(
                child: Text(count.toString()),
              ),
              IconButton(
                  onPressed: () {
                    ref.read(countProvider.notifier).state--;
                  },
                  icon: const Icon(Icons.minimize_outlined)),
            ],
          )
        ],
      ),
    );
  }
}

var counterProvider = StateNotifierProvider((ref) => CounterNotifier());

class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  @override
  _TestState createState() => _TestState();
}

class _TestState extends ConsumerState<Test> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final name = ref.read(nameProvider);
  }

  Widget build(BuildContext context) {
    final name = ref.watch(nameProvider);
    return Scaffold(
      body: Center(
        child: Text(name),
      ),
    );
  }
}
