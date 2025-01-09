import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class SafetyScreen extends StatelessWidget {
  const SafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = '''
## Emergency Contacts
In case of an emergency, please use the following contact numbers:
- **Police**: 15
- **Fire Department**: 16
- **Ambulance Services**: 1122
- **Nearest Hospital**: 1122

## Safety Guidelines
To ensure a safe environment for everyone:
- Always use gym equipment as instructed.
- Warm up before workouts and cool down afterward.
- Stay hydrated and listen to your body.
- In case of any equipment malfunction, report it immediately.
- Follow all posted signs and instructions.

## Incident Reporting
If you witness or experience an accident, please report it immediately using our incident reporting feature. Include details of the incident, location, and any injuries.

## Health and Safety Certifications
Our gym is fully compliant with local health and safety regulations. We undergo regular inspections to ensure a safe environment for our members and staff.

## Staff Training
Our staff members are trained in:
- First aid and CPR
- Emergency evacuation procedures
- Safe equipment handling  

They are here to help and ensure your safety.

## COVID-19 Safety Measures
Your health is our priority. We adhere to the following measures:
- Regular sanitization of equipment and common areas.
- Social distancing guidelines.
- Hand sanitizers available throughout the gym.
- Please stay home if you feel unwell.

## Safety Equipment Inventory
For your safety, we have the following equipment on-site:
- Fire extinguishers
- First aid kits
- Automated External Defibrillators (AEDs)
''';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Safety',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Markdown(data: data),
      ),
    );
  }
}
