import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: RiverpodApp(),
    ),
  );
}

class RiverpodApp extends ConsumerWidget {
  final textProvider = Provider<String>((ref) => "Hello, World!");

  RiverpodApp({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
    ref,
  ) {
    // 3. Use the ConsumerWidget to access the provider.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod Hello World'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 4. Use the provider within the build method.
            Consumer(
              builder: (context, ref, child) {
                final text = ref.watch(textProvider);
                return Text(
                  text, // Display the text from the provider.
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // 5. Update the state of the provider.
                // ref.read(textProvider).state = "Hello, Riverpod!";
              },
              child: const Text("Change Text"),
            ),
          ],
        ),
      ),
    );
  }
}
