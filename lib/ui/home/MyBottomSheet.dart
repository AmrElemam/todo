// ignore_for_file: must_be_immutable, file_names, non_constant_identifier_names, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/BottomSheetProvider.dart';
import 'package:todo/ui/common/CustomTextFormField.dart';

class MyBottomSheet extends StatefulWidget {
  const MyBottomSheet({Key? key}) : super(key: key);

  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<BottomSheetProvider>(context, listen: false);
    titleController = TextEditingController(text: provider.title);
    descriptionController = TextEditingController(text: provider.description);
    selectedDate = provider.selecteddate;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomSheetProvider>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextFormField(
              hint: "Title",
              controller: titleController,
              lines: 1,
              onChanged: (value) {
                provider.updateTitle(value);
                formKey.currentState?.validate() == true;
              },
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task Title";
                }
                return null;
              },
            ),
            CustomTextFormField(
              hint: "Description",
              controller: descriptionController,
              lines: 4,
              onChanged: (value) {
                provider.updateDescription(value);
                formKey.currentState?.validate() == true;
              },
              validator: (text) {
                if (text == null || text.trim().isEmpty) {
                  return "Please Enter Task Description";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 2, color: Color(0xFFa9a9a99c)),
                ),
              ),
              child: Text(
                selectedDate == null
                    ? "Date"
                    : "${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}",
                style: const TextStyle(color: Color(0xFF707070), fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            Visibility(
              visible: showDateError,
              child: Text(
                "Please Select Task Date",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.error, fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                showCalendar();
              },
              child: const Text(
                "Select Time",
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addTask();
              },
              child: const Text(
                "Add Task",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCalendar() async {
    var provider = Provider.of<BottomSheetProvider>(context, listen: false);
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        provider.updateDate(date);
        selectedDate = provider.selecteddate;
        if (selectedDate != null) {
          showDateError = false;
        }
      });
    }
  }

  bool showDateError = false;

  void addTask() {
    if (isValidForm() == false) return;
  }

  bool isValidForm() {
    bool isvalid = true;
    if (formKey.currentState?.validate() == false) {
      isvalid = false;
    }
    if (selectedDate == null) {
      isvalid = false;
      setState(() {
        showDateError = true;
      });
    }
    return isvalid;
  }
}
