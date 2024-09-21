import 'package:flutter/material.dart';

void main() {
  runApp(NumberToWordsApp());
}

class NumberToWordsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number to Words Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NumberToWordsHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NumberToWordsHomePage extends StatefulWidget {
  @override
  _NumberToWordsHomePageState createState() => _NumberToWordsHomePageState();
}

class _NumberToWordsHomePageState extends State<NumberToWordsHomePage> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void _convertToWords() {
    int? number = int.tryParse(_controller.text);
    if (number != null && number > 0 && number <= 999999999) {
      setState(() {
        _result = numberToWords(number);
      });
    } else {
      setState(() {
        _result = 'Please enter a valid number between 1 and 999,999,999';
      });
    }
  }

  String numberToWords(int num) {
    if (num == 0) return 'zero';

    List<String> belowTwenty = [
      'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight',
      'nine', 'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen',
      'sixteen', 'seventeen', 'eighteen', 'nineteen'
    ];
    List<String> tens = [
      '', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy',
      'eighty', 'ninety'
    ];
    List<String> thousands = ['', 'thousand', 'million'];

    String helper(int num) {
      if (num == 0) return '';
      if (num < 20) return belowTwenty[num] + ' ';
      if (num < 100) return tens[num ~/ 10] + (num % 10 > 0 ? ' ' + belowTwenty[num % 10] : '');
      return belowTwenty[num ~/ 100] + ' hundred ' + (num % 100 > 0 ? helper(num % 100) : '');
    }

    String word = '';
    int thousandCount = 0;

    while (num > 0) {
      if (num % 1000 != 0) {
        word = helper(num % 1000) + thousands[thousandCount] + ' ' + word;
      }
      num ~/= 1000;
      thousandCount++;
    }

    return word.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number to Words Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter a number',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertToWords,
              child: Text('Convert'),
            ),
            SizedBox(height: 16.0),
            Text(
              _result,
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
