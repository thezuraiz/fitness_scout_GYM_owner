import 'package:fitness_scout_owner_v1/features/authentication/controllers/gym_verification/gym_user_controller.dart';
import 'package:fitness_scout_owner_v1/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class GymTimingsScreen extends StatefulWidget {
  const GymTimingsScreen({super.key});

  @override
  State<GymTimingsScreen> createState() => _GymTimingsScreenState();
}

class _GymTimingsScreenState extends State<GymTimingsScreen> {
  final Map<String, Map<String, dynamic?>> openingHours = {
    'Monday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Tuesday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Wednesday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Thursday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Friday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Saturday': {'isOpen': false, 'opening': '', 'closing': ''},
    'Sunday': {'isOpen': false, 'opening': '', 'closing': ''},
  };

  String _timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute'; // Format as "HH:mm"
  }

  Future<void> _selectTime(
      BuildContext context, String day, bool isOpening) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        if (isOpening) {
          openingHours[day]!['opening'] =
              _timeOfDayToString(selectedTime); // Set opening time as String
        } else {
          openingHours[day]!['closing'] =
              _timeOfDayToString(selectedTime); // Set closing time as String
        }
      });

      // Log the timings to ensure they are formatted correctly
      print('Opening Hours: ${openingHours[day]!['opening']}');
      print('Closing Hours: ${openingHours[day]!['closing']}');
    }

    GYMUserController.instance.timings = openingHours;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Opening Hours',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: ZSizes.spaceBtwItems),
        ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: openingHours.keys.map((day) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    title: Text(day),
                    trailing: ToggleButtons(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Closed'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text('Open'),
                        ),
                      ],
                      isSelected: [
                        !openingHours[day]!['isOpen']!,
                        openingHours[day]!['isOpen']!
                      ],
                      onPressed: (int index) {
                        setState(() {
                          openingHours[day]!['isOpen'] =
                              index == 1; // Update isOpen state
                          if (index == 0) {
                            // If selected 'Closed', reset times
                            openingHours[day]!['opening'] = null;
                            openingHours[day]!['closing'] = null;
                          }
                        });
                      },
                    ),
                  ),
                  if (openingHours[day]!['isOpen']!)
                    Column(
                      children: [
                        ListTile(
                          title: Text(
                              'Opening Time: ${openingHours[day]!['opening'] ?? 'Select Opening Time'}'),
                          trailing: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: () {
                              _selectTime(context, day, true);
                            },
                          ),
                        ),
                        ListTile(
                          title: Text(
                              'Closing Time: ${openingHours[day]!['closing'] ?? 'Select Closing Time'}'),
                          trailing: IconButton(
                            icon: Icon(Icons.access_time),
                            onPressed: () {
                              _selectTime(context, day, false);
                            },
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: ZSizes.spaceBtwItems),
      ],
    );
  }
}
