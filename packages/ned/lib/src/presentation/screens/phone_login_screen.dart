import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:core/core.dart';
import 'package:core/src/constants/app_assets.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      // TODO: Implement phone number verification
      // For now, just show the OTP bottom sheet
      OtpBottomSheet.show(
        context: context,
        title: 'OTP Verification',
        subtitle:
            'Enter the verification code sent to ${_phoneController.text}',
        phoneNumber: _phoneController.text,
        onVerify: (otp) async {
          // TODO: Implement OTP verification
          print('OTP: $otp');
          print('Phone Number: ${_phoneController.text}');
          
          // Create a temporary user for testing
          const user = User(
            id: 1,
            name: 'Test User',
            email: 'test@example.com',
          );
          
          // Update the user state
          ref.read(userNotifierProvider.notifier).state = const BaseState.success(user);
          
          // Wait a moment to ensure state propagation
          await Future.delayed(const Duration(milliseconds: 100));
          
          if (mounted) {
            context.go('/home');
          }
        },
        onResendCode: () {
          // TODO: Implement resend code
          print('Resend code');
        },
      );
      setState(() => _isLoading = false);
    }
  }

  Widget _buildTopImageView() {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      child: Stack(
        children: [
          // Background Image
          Image.asset(
            AppAssets.topSignInImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: theme.colorScheme.primary.withOpacity(0.1),
                child: Center(
                  child: Icon(
                    Icons.phone_android,
                    size: 80,
                    color: theme.colorScheme.primary,
                  ),
                ),
              );
            },
          ),
          // Gradient Overlay
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       begin: Alignment.topCenter,
          //       end: Alignment.bottomCenter,
          //       colors: [
          //         const Color.fromARGB(0, 20, 11, 11),
          //         theme.scaffoldBackgroundColor.withOpacity(0.9),
          //         theme.scaffoldBackgroundColor,
          //       ],
          //       stops: const [0.0, 0.7, 1.0],
          //     ),
          //   ),
          // ),
          // Text Content
          Positioned(
            left: 20,
            right: 20,
            top: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter your phone number',
                  style: AppTheme.nedTheme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.nedTheme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'We will send you a verification code',
                  style: AppTheme.nedTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.nedTheme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(
      //   // title: const Text('Phone Login'),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTopImageView(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'Enter your phone number',
                          prefixIcon: const Icon(Icons.phone),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Please enter a valid phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        child: _isLoading
                            ? const CircularProgressIndicator()
                            : const Text('Continue'),
                      ),
                      const SizedBox(height: 32),
                      TextButton(
                        onPressed: () => context.go('/login'),
                        child: Text.rich(
                          TextSpan(
                            text: 'Prefer to login with email? ',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: 'Login here',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).padding.bottom),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
