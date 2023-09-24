import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final helloProvider = Provider<String>((ref) {
//   // Initialize the value with "Hello, World!"
//   return ref.watch(helloStateProvider).state;
// });

final helloStateProvider = StateProvider<String>((ref) {
  return "Hello, World!";
});

class RiverpodApp extends ConsumerWidget {
  const RiverpodApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(helloStateProvider),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                // ref.read(helloStateProvider).state = "Hello, User!";
              },
              child: const Text("Tap"),
            ),
          ],
        ),
      ),
    );
  }
}
