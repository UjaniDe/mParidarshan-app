import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                'mParidarshan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'School Inspection Portal',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 60),
              const Text(
                'Enter your mobile number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
TextField(
  controller: _phoneController,
  keyboardType: TextInputType.phone,
  maxLength: 10,
  inputFormatters: [
    FilteringTextInputFormatter.digitsOnly,
  ],
  decoration: InputDecoration(
    prefixText: '+91 ',
    hintText: '10-digit mobile number',
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
onPressed: () {
  if (_phoneController.text.length < 10) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a valid 10-digit mobile number')),
    );
    return;
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OtpScreen(phoneNumber: _phoneController.text),
    ),
  );
},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}