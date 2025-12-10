import 'package:flutter/material.dart';
import 'package:number_to_words_english/number_to_words_english.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counting App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 26, 233, 18)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Counting App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _words = 'zero';
  bool _isLoading = false;

  String _convertNumberToWords(int number) {
    try {
      return NumberToWordsEnglish.convert(number);
    } catch (e) {
      return 'number out of range';
    }
  }

  void _incrementCounter() {
    setState(() {
      _isLoading = true;
    });
    
    // Simulate async operation to ensure no UI freezing
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _counter++;
        _words = _convertNumberToWords(_counter);
        _isLoading = false;
      });
    });
  }

  void _decrementCounter() {
    setState(() {
      _isLoading = true;
    });
    
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        // Prevent negative numbers
        if (_counter > 0) {
          _counter--;
          _words = _convertNumberToWords(_counter);
        }
        _isLoading = false;
      });
    });
  }

  void _resetCounter() {
    setState(() {
      _isLoading = true;
    });
    
    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        _counter = 0;
        _words = _convertNumberToWords(_counter);
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 14, 204, 55)),
                borderRadius: const BorderRadius.all(Radius.circular(20))
              ),
              child: Center(
                child: _isLoading 
                  ? const CircularProgressIndicator()
                  : Text(
                      '$_counter',
                      style: const TextStyle(
                        fontSize: 100,
                        color: Color.fromARGB(255, 14, 204, 55)),
                    ),
              ),
            ),

            const SizedBox(height: 20),
            
            const Text(
              'You have clicked the button this many times:',
            ),

            Text(
              _words,
              style: const TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 14, 204, 55)),
            ),

            const SizedBox(height: 50),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _isLoading ? null : _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _resetCounter,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(24),
                  ),
                  child: const Icon(Icons.refresh),
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}