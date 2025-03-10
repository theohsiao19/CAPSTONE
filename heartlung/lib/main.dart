import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const List<Widget> sex = <Widget>[
  Text('Male'),
  Text('Female')
];

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Terpiez',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Counter with ChangeNotifier {
  
  String donorAge = "";
  String donorWeight = "";
  String donorHeight = "";

  String recipientAge = "";
  String recipientWeight = "";
  String recipientHeight = "";
  
  void setDonorAge(inputDonorAge) {
    donorAge = inputDonorAge;
    notifyListeners();
  }

}


class Homepage extends StatelessWidget {
  const Homepage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart-Lung Calculator')
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Row(
            children: [
              InkWell(
                child:  Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  color: const Color.fromARGB(255, 238, 134, 132),
                  child: Center(
                    child: Text(
                      "Heart",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0, // insert your font size here
                      )
                    ),
                  ),
              ),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HeartCalculator())
                  );
                }, 
              ),
              InkWell(
                child:  Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth / 2,
                  color: Colors.blue.shade300,
                  child: Center(
                    child: Text(
                      "Lung",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0, // insert your font size here
                      )
                    ),
                  ),
              ),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HeartCalculator())
                  );
                }, 
              ),
            ],
          );
        },
      ),
          
    );
  }
}

class HeartCalculator extends StatefulWidget {
  const HeartCalculator({super.key});

  @override
  State<HeartCalculator> createState() => _HeartCalculatorState();
}
                          
class _HeartCalculatorState extends State<HeartCalculator> {  
  final List<bool> _selectedSexDonor = <bool>[true, false];
  final List<bool> _selectedSexRecipient = <bool>[true, false];
  bool vertical = false;
  String _donorAge = "";
  //double _donorWeight = 20;
  //double _donorHeight = 20;

  //double _recipientAge = 20;
  //double _recipientWeight = 20;
  //double _recipientHeight = 20;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator')
      ),
      body: SafeArea(child: 
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [

            //gender button 1
            Row(children: [
              SizedBox(
                  width: 100,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Donor', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedSexDonor.length; i++) {
                    _selectedSexDonor[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              //selectedBorderColor: Colors.red[700],
              //selectedColor: Colors.white,
              //fillColor: Colors.red[200],
              //color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedSexDonor,
              children: sex,
            ),

            ],),
            SizedBox(height: 15),

            //input 1
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Age', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'years'
                    ),
                    onChanged: (value) {
                      var counter = context.read<Counter>();
                      counter.setDonorAge(value);
                    }
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Weight', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'kg'
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Height', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'cm'
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            //gender button 2
            Row(children: [
              SizedBox(
                  width: 100,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Recipient', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
            ToggleButtons(
              direction: vertical ? Axis.vertical : Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedSexRecipient.length; i++) {
                    _selectedSexRecipient[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              //selectedBorderColor: Colors.red[700],
              //selectedColor: Colors.white,
              //fillColor: Colors.red[200],
              //color: Colors.red[400],
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 80.0,
              ),
              isSelected: _selectedSexRecipient,
              children: sex,
            ),

            ],),
            SizedBox(height: 15),
           
            //input 2
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Age', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'years'
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Weight', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'kg'
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 75,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Height', 
                      style: TextStyle(fontSize: 18)
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'cm'
                    )
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),

            SizedBox(height: 50),
            InkWell(
                child:  Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 0, 0, 0))
                  ),
                  child: const Center(child: Text("Calculate!")),
              ),
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Results())
                  );
              }, 
            ),

            SizedBox(height: 15),
            Text(_donorAge)
            

          ],)
        )
      )      
    );
  }
}


//doesn't actually do anything
class LungCalculator extends StatelessWidget {
  const LungCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lung Calculator')
      ),
      body: SafeArea(child: 
        Column(children: [
        Icon(
          Icons.airplanemode_active,
          size: 100
        ),
        Center(
          child: Text('Plane'),
        )
      ],)
      
      )
    );
  }
}

class Results extends StatelessWidget {
  const Results({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results')
      ),
      body: SafeArea(child: 
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
        Align(
              alignment: Alignment.centerLeft,
              child: Text('pTLC Donor: 7.2', 
              style: TextStyle(fontSize: 18))
        ),
        Align(
              alignment: Alignment.centerLeft,
              child: Text('pTLC Recipient: 4.2', 
              style: TextStyle(fontSize: 18))
        ),
        Align(
              alignment: Alignment.centerLeft,
              child: Text('pTLC Ratio: 0.714', 
              style: TextStyle(fontSize: 18))
        ),
        Align(
              alignment: Alignment.centerLeft,
              child: Text('Relative Risk: 1.4', 
              style: TextStyle(fontSize: 18))
        ),
        SizedBox(height: 50),
        Image.asset('assets/images/relativerisk.jpeg'),
        SizedBox(height: 50),
        
        //provider is completely scuffed so far
        Align(alignment: Alignment.centerLeft,
          child: Consumer<Counter> (
              builder: (context, counter, child) => 
                Text(
                  'Donor Age:\t\t${counter.donorAge}',
                  style: TextStyle(fontSize: 18)
                )
          )
        )

      ],)
        )

      )
    );
  }
}




