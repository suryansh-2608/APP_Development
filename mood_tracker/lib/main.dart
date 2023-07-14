import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MoodTrackerHomePage(),
        '/analysis': (context) => MoodAnalysisPage(),
      },
    );
  }
}

class MoodTrackerHomePage extends StatefulWidget {
  @override
  _MoodTrackerHomePageState createState() => _MoodTrackerHomePageState();
}

class _MoodTrackerHomePageState extends State<MoodTrackerHomePage> {
  List<MoodEntry> moodEntries = [];

  // Function to add a new mood entry
  void addMoodEntry(MoodEntry entry) {
    setState(() {
      moodEntries.insert(0, entry);
    });
  }

  // Function to generate mood data for the chart
  List<MoodData> getMoodData() {
    return moodEntries.map((entry) {
      return MoodData(entry.dateTime, entry.mood);
    }).toList();
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'Happy':
        return Colors.green;
      case 'Sad':
        return Colors.blue;
      case 'Excited':
        return Colors.orange;
      case 'Angry':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Tracker'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: SfCartesianChart(
              plotAreaBackgroundColor: Colors.transparent,
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.MMM(),
                intervalType: DateTimeIntervalType.months,
                majorGridLines: MajorGridLines(width: 0),
                labelStyle: TextStyle(color: Colors.white),
                axisLine: AxisLine(color: Colors.white),
                majorTickLines: MajorTickLines(color: Colors.white),
                title: AxisTitle(text: 'Date', textStyle: TextStyle(color: Colors.white)),
              ),
              primaryYAxis: NumericAxis(
                labelStyle: TextStyle(color: Colors.white),
                axisLine: AxisLine(color: Colors.white),
                majorTickLines: MajorTickLines(color: Colors.white),
                title: AxisTitle(text: 'Mood', textStyle: TextStyle(color: Colors.white)),
                minimum: 0,
                maximum: 5,
              ),
              series: <ChartSeries>[
                LineSeries<MoodData, DateTime>(
                  dataSource: getMoodData(),
                  xValueMapper: (MoodData mood, _) => mood.dateTime,
                  yValueMapper: (MoodData mood, _) => mood.moodValue,
                  pointColorMapper: (MoodData mood, _) => getMoodColor(mood.mood),
                  enableTooltip: true,
                  animationDuration: 800,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: moodEntries.length,
              itemBuilder: (context, index) {
                final moodEntry = moodEntries[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getMoodColor(moodEntry.mood),
                    ),
                    title: Text(
                      moodEntry.mood,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMEd().add_jms().format(moodEntry.dateTime),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          moodEntries.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AddMoodEntryDialog(
              onMoodEntryAdded: addMoodEntry,
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/analysis');
                },
                child: Text('Mood Analysis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoodData {
  final DateTime dateTime;
  final String mood;
  int get moodValue {
    switch (mood) {
      case 'Happy':
        return 5;
      case 'Sad':
        return 1;
      case 'Excited':
        return 4;
      case 'Angry':
        return 2;
      default:
        return 0;
    }
  }

  MoodData(this.dateTime, this.mood);
}

class MoodEntry {
  final String mood;
  final DateTime dateTime;

  MoodEntry({required this.mood, required this.dateTime});
}

class AddMoodEntryDialog extends StatefulWidget {
  final Function(MoodEntry) onMoodEntryAdded;

  const AddMoodEntryDialog({required this.onMoodEntryAdded});

  @override
  _AddMoodEntryDialogState createState() => _AddMoodEntryDialogState();
}

class _AddMoodEntryDialogState extends State<AddMoodEntryDialog> {
  String selectedMood = 'Happy';

  final List<String> moodOptions = ['Happy', 'Sad', 'Excited', 'Angry'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Mood Entry'),
      content: DropdownButton<String>(
        value: selectedMood,
        onChanged: (String? newValue) {
          setState(() {
            selectedMood = newValue!;
          });
        },
        items: moodOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final newMoodEntry = MoodEntry(
              mood: selectedMood,
              dateTime: DateTime.now(),
            );
            widget.onMoodEntryAdded(newMoodEntry);
            Navigator.of(context).pop();
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class MoodAnalysisPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mood Analysis'),
      ),
      body: Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
