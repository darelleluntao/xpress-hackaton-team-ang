import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
// It's good practice to import your core package if it contains shared utilities/providers
// import 'package:core/core.dart'; // Assuming you might need this later

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phoneController.text = '+639123456789';
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitPhoneNumber() async {
    final phoneNumber = _phoneController.text;

    // Bypass for "123456789"
    if (phoneNumber == '1234567890') {
      context.go('/otp', extra: phoneNumber);
      return;
    }

    // Original validation and submission
    if (_formKey.currentState?.validate() ?? false) {
      // We'll need to pass the phone number to the OTP screen.
      context.go('/otp',
          extra:
              phoneNumber); // Assuming '/otp' will be the route for OTP screen
    }
  }

  @override
  Widget build(BuildContext context) {
    // You might have a specific notifier for phone login, or reuse/adapt existing ones.
    // final phoneLoginState = ref.watch(somePhoneLoginNotifierProvider);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.gerryTheme.colorScheme.primary,
              AppTheme.gerryTheme.colorScheme.primary.withAlpha(204),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // App Logo (reusing similar style from LoginScreen)
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.phone_android, // Changed icon
                        size: 60,
                        color: AppTheme.gerryTheme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Welcome Text
                    Text(
                      'Enter Your Phone Number',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // Phone Number Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter your phone number';
                        }
                        // Remove "+63" and any non-digits for validation
                        final numericValue = value!.startsWith('+63')
                            ? value
                                .substring(3)
                                .replaceAll(RegExp(r'[^0-9]'), '')
                            : value.replaceAll(RegExp(r'[^0-9]'), '');

                        // Basic validation for 10 digits after +63 (or 11 if +63 is not there for some reason)
                        // Adjust length check as per your specific requirement for the number after +63
                        if (value.startsWith('+63') &&
                            numericValue.length != 10) {
                          return 'Phone number after +63 must be 10 digits';
                        } else if (!value.startsWith('+63') &&
                            numericValue.length != 11 &&
                            numericValue.length != 10) {
                          //This case handles if user somehow deletes +63.
                          //Allowing 10 or 11 digits if +63 is not present.
                          //You might want to make this stricter.
                          return 'Phone number must be 10 or 11 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Submit Button
                    // Similar to LoginScreen, you might want to handle loading/error states here
                    ElevatedButton(
                      onPressed: _submitPhoneNumber,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor:
                            AppTheme.gerryTheme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16), // Add some spacing
                    // Button to navigate to Email/Password Login
                    TextButton(
                      onPressed: () {
                        context.go(
                            '/login'); // Navigate to the original login screen
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Or log in with Email & Password',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
