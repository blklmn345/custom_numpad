import 'package:custom_numpad/custom_numpad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _show = false;

  List<int> numbers = [];

  static const _maxLength = 6;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NumpadContainer(
        show: _show,
        duration: const Duration(milliseconds: 300),
        backgroundColor: Colors.grey,
        // numButtonBuilder: (context, number) {
        //   return ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       shape: const CircleBorder(),
        //     ),
        //     onPressed: () => _onInput(number),
        //     child: Text(number.toString()),
        //   );
        // },
        // deleteButtonBuilder: (context) {
        //   return ElevatedButton(
        //     style: ElevatedButton.styleFrom(
        //       shape: const CircleBorder(),
        //     ),
        //     onPressed: () => _onDelete(),
        //     child: const Text('del'),
        //   );
        // },
        onNumInput: (number) => _onInput(number),
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        onDelete: () => _onDelete(),
        child: GestureDetector(
          onTap: () => setState(() {
            _show = false;
          }),
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Custom Numpad Example'),
            ),
            body: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _show = !_show;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: List.generate(
                          _maxLength,
                          (index) {
                            final number = numbers.isEmpty
                                ? null
                                : index < numbers.length
                                    ? numbers[index]
                                    : null;

                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.black,
                                      )),
                                  child: Center(
                                    child: Text(
                                      number == null ? '-' : number.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(growable: false),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 100,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        title: Text('Item $index'),
                      );
                    }),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: _show
                  ? const Icon(Icons.toggle_off)
                  : const Icon(Icons.toggle_on),
              onPressed: () {
                setState(() {
                  _show = !_show;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onInput(int number) {
    if (numbers.length < _maxLength) {
      setState(() {
        numbers.add(number);

        if (numbers.length == _maxLength) {
          _show = false;
        }
      });
    }
  }

  void _onDelete() {
    if (numbers.isNotEmpty) {
      setState(() {
        numbers.removeLast();
      });
    }
  }
}
