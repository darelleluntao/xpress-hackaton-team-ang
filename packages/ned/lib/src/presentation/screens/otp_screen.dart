import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart'; // Ensure User and userNotifierProvider are available
// import 'package:core/core.dart'; // Assuming you might need this later

// Toggle this constant to enable/disable bypass functionality
const bool _enableBypass = true;

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key, required this.phoneNumber});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  // Separate function for bypass logic
  Future<bool> _tryBypass(String phoneNumber, String otp) async {
    // Early return if bypass is disabled
    if (!_enableBypass) return false;

    // Check for bypass credentials
    if (phoneNumber == '+639123456789' && otp == '112233') {
      // Create a fake user for the bypass
      const fakeUser = User(
        id: 999,
        name: 'Bypass User',
        email: 'bypass@example.com',
      );

      // Set the user state directly to success
      ref.read(userNotifierProvider.notifier).state =
          const BaseState.success(fakeUser);

      // Wait a moment to ensure state propagation
      await Future.delayed(const Duration(milliseconds: 100));
      return true;
    }

    return false;
  }

  Future<void> _verifyOtp() async {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = _otpController.text;
      final phoneNumber = widget.phoneNumber;

      // Try bypass first
      final bypassSuccessful = await _tryBypass(phoneNumber, otp);
      if (bypassSuccessful) {
        if (mounted) {
          context.go('/home');
        }
        return;
      }

      // Regular OTP verification logic
      // TODO: Replace with actual OTP verification logic for non-bypass cases
      if (otp == '112233') {
        if (mounted) {
          context.go('/home');
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid OTP. Please try again.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // final otpState = ref.watch(someOtpNotifierProvider); // For handling loading/error states

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              // Fallback if canPop is false, though typically OTP screen is pushed
              context.go('/phone-login'); // Or your phone login route
            }
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withAlpha(204),
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
                    // App Logo or relevant icon
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
                        Icons.sms_outlined, // Icon for OTP/SMS
                        size: 60,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Instruction Text
                    Text(
                      'Enter OTP sent to ${widget.phoneNumber}',
                      style: GoogleFonts.poppins(
                        fontSize: 18, // Slightly smaller for instruction
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    // OTP Field
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6, // Common OTP length
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall // Larger text for OTP digits
                          ?.copyWith(color: Colors.black, letterSpacing: 8.0),
                      decoration: const InputDecoration(
                          labelText: 'OTP Code',
                          counterText: "", // Hide the counter
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          fillColor:
                              Colors.white70, // Slight background for OTP field
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide.none,
                          )),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter the OTP';
                        }
                        if (value!.length != 6) {
                          return 'OTP must be 6 digits';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    // Verify OTP Button
                    ElevatedButton(
                      onPressed: _verifyOtp,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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
