import 'package:flutter/material.dart';
import 'package:ccp_mobile/core/constants/app_colors.dart';


class RegisterVisitForm extends StatefulWidget {
  const RegisterVisitForm({super.key});

  @override
  State<RegisterVisitForm> createState() => _RegisterVisitFormState();
}

class _RegisterVisitFormState extends State<RegisterVisitForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _label("Nombre"),
            _roundedInput(
              key: const Key('nameField'),
              controller: nameController,
            ),
            _label("Fecha inicio"),
            _dateInput(
              key: const Key('startDateField'),
              date: startDate,
              onTap: () => _selectDate(context, true),
            ),
            _label("Fecha finalización"),
            _dateInput(
              key: const Key('endDateField'),
              date: endDate,
              onTap: () => _selectDate(context, false),
            ),
            _label("Ubicación"),
            _locationBox(),
            const SizedBox(height: 24),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
    );
  }

  Widget _roundedInput({required TextEditingController controller, required Key key}) {
    return TextFormField(
      key: key,
      controller: controller,
      decoration: _inputDecoration(),
    );
  }

  Widget _dateInput({required DateTime? date, required VoidCallback onTap, required Key key}) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      child: AbsorbPointer(
        child: TextFormField(
          decoration: _inputDecoration(
            suffixIcon: const Icon(Icons.calendar_month, size: 20),
            hintText: date != null ? "${date.day}/${date.month}/${date.year}" : "",
          ),
        ),
      ),
    );
  }

  Widget _locationBox() {
    return Container(
      key: const Key('locationBox'),
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        border: Border.all(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(Icons.map, size: 32, color: AppColors.primaryColor),
      ),
    );
  }

  Widget _registerButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        key: const Key('submitButton'),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.pop(context);
          }
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryColor,
          side: const BorderSide(color: AppColors.primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Text("Registrar", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  InputDecoration _inputDecoration({Widget? suffixIcon, String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: const Color(0xFFEFEFEF),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

