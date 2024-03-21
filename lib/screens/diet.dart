import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:go_athletics/Extra/Devent.dart';


class Diets extends StatefulWidget {
  const Diets({Key? key}) : super(key: key);

  @override
  State<Diets> createState() => _DietState();
}

class _DietState extends State<Diets> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  final TextEditingController _dietController = TextEditingController();
  late final ValueNotifier<List<Devent>> _selectedDevents;
  final ValueNotifier<DateTime> _focusedDayNotifier =
      ValueNotifier<DateTime>(DateTime.now());

  Map<DateTime, List<Devent>> events = {};

  @override
  void initState() {
    super.initState();
    _selectedDevents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  void _daySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDayNotifier.value = focusedDay;
      _selectedDevents.value = _getEventsForDay(selectedDay);
    });
  }

  List<Devent> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _addEvent(String title) {
    setState(() {
      final newEvent = Devent(title);
      final eventList = events[_selectedDay] ?? [];
      eventList.add(newEvent);
      events[_selectedDay] = eventList;
      _selectedDevents.value = _getEventsForDay(_selectedDay);
    });
  }

  void _removeEvent(int index) {
    setState(() {
      _selectedDevents.value.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                scrollable: true,
                title: const Text('Diet Name'),
                content: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: _dietController,
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      final title = _dietController.text;
                      if (title.isNotEmpty) {
                        _addEvent(title);
                      }
                      Navigator.of(context).pop();
                    },
                    child: const Text("Add Diet"),
                  )
                ],
              );
            },
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: const Color.fromARGB(255, 57, 9, 65),
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: const Color.fromARGB(255, 57, 9, 65),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            height: 130,
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Diets',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/dietlist');
            },
            child: const Text("Your Diet List"),
          ),
          Expanded(
            child: Container(
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 40,
                focusedDay: _focusedDayNotifier.value,
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                calendarFormat: _calendarFormat,
                startingDayOfWeek: StartingDayOfWeek.monday,
                firstDay: DateTime.utc(2010, 1, 7),
                lastDay: DateTime.utc(2040, 12, 31),
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDayNotifier.value = focusedDay;
                    _selectedDevents.value = _getEventsForDay(focusedDay);
                  });
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onDaySelected: _daySelected,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ValueListenableBuilder<List<Devent>>(
            valueListenable: _selectedDevents,
            builder: (context, value, _) {
              if (value.isEmpty) {
                return Container(
                  child: const Center(
                    child: Text(
                      "No diet for the selected day.",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        _removeEvent(index); 
                      },
                      background: Container(
                        color: Colors.red,
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                final TextEditingController _editController =
                                    TextEditingController(
                                        text: value[index].title);
                                return AlertDialog(
                                  title: const Text('Edit Workout'),
                                  content: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: TextField(
                                      controller: _editController,
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        final newTitle = _editController.text;
                                        if (newTitle.isNotEmpty) {
                                          value[index].title = newTitle;
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: const Text("Save"),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          title: Text('${value[index].title}'),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
