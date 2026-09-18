import 'package:flutter/material.dart';

void main() {
  runApp(const SalaryCalculatorApp());
}

class SalaryCalculatorApp extends StatelessWidget {
  const SalaryCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator salariu',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const SalaryCalculatorPage(),
    );
  }
}

class SalaryCalculatorPage extends StatefulWidget {
  const SalaryCalculatorPage({super.key});

  @override
  State<SalaryCalculatorPage> createState() => _SalaryCalculatorPageState();
}

class _SalaryCalculatorPageState extends State<SalaryCalculatorPage> {
  final TextEditingController salaryController = TextEditingController();

  String employeeType = 'Standard';

  double netSalary = 0;
  double taxes = 0;

  void calculateSalary() {
    double grossSalary =
        double.tryParse(salaryController.text.replaceAll(',', '.')) ?? 0;

    double taxRate;

    if (employeeType == 'Standard') {
      taxRate = 0.18;
    } else if (employeeType == 'Student') {
      taxRate = 0.10;
    } else {
      taxRate = 0.05;
    }

    taxes = grossSalary * taxRate;
    netSalary = grossSalary - taxes;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator salariu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Salariul brut',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Introduceți salariul brut',
                border: OutlineInputBorder(),
                prefixText: 'MDL ',
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Tipul angajatului',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            DropdownButton<String>(
              value: employeeType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'Standard',
                  child: Text('Angajat standard - 18%'),
                ),
                DropdownMenuItem(
                  value: 'Student',
                  child: Text('Student - 10%'),
                ),
                DropdownMenuItem(
                  value: 'Preferential',
                  child: Text('Impozitare preferențială - 5%'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  employeeType = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateSalary,
                child: const Text('Calculează salariul'),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              'Salariu net: ${netSalary.toStringAsFixed(2)} MDL',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Impozite: ${taxes.toStringAsFixed(2)} MDL',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    salaryController.dispose();
    super.dispose();
  }
}