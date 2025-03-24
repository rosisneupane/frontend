import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_practice/api/routine.dart';
import 'package:ui_practice/modals/routine.dart';
import 'package:ui_practice/routine_planner_screen.dart';

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({super.key});

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  final TextEditingController textController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  void pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  void submitRoutine() async {
    if (selectedDate == null ||
        selectedTime == null ||
        textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);
    String formattedTime = DateFormat('HH:mm:ss').format(
      DateTime(2025, 1, 1, selectedTime!.hour, selectedTime!.minute),
    );

    Routine newRoutine = Routine(
      date: formattedDate,
      time: "${formattedTime}.000Z",
      text: textController.text,
      status: false, // Default status
    );

    try {
      bool isSuccess = await ApiService.postRoutine(newRoutine);
      if (isSuccess) {
        // Show success message or navigate to the previous page
        //Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoutinePlannerScreen()),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Routine")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Routine Text",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate == null
                        ? "Select Date"
                        : DateFormat('MMM d, yyyy').format(selectedDate!),
                  ),
                ),
                ElevatedButton(
                  onPressed: pickDate,
                  child: const Text("Pick Date"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(
                    selectedTime == null
                        ? "Select Time"
                        : selectedTime!.format(context),
                  ),
                ),
                ElevatedButton(
                  onPressed: pickTime,
                  child: const Text("Pick Time"),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitRoutine,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
