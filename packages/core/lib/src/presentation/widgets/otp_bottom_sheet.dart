import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'bottom_sheet.dart';

/// A reusable OTP bottom sheet widget that follows the app's design system
class OtpBottomSheet extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? phoneNumber;
  final Function(String) onVerify;
  final VoidCallback? onResendCode;
  final int otpLength;
  final int resendDelaySeconds;
  final String verifyButtonText;
  final String resendCodeText;
  final String resendTimerText;

  const OtpBottomSheet({
    super.key,
    required this.title,
    required this.subtitle,
    this.phoneNumber,
    required this.onVerify,
    this.onResendCode,
    this.otpLength = 4,
    this.resendDelaySeconds = 60,
    this.verifyButtonText = 'Verify',
    this.resendCodeText = 'Resend Code',
    this.resendTimerText = 'Resend code in',
  });

  /// Shows the OTP bottom sheet with the given context
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String subtitle,
    String? phoneNumber,
    required Function(String) onVerify,
    VoidCallback? onResendCode,
    int otpLength = 4,
    int resendDelaySeconds = 60,
    String verifyButtonText = 'Verify',
    String resendCodeText = 'Resend Code',
    String resendTimerText = 'Resend code in',
  }) {
    return CustomBottomSheet.show<T>(
      context: context,
      child: OtpBottomSheet(
        title: title,
        subtitle: subtitle,
        phoneNumber: phoneNumber,
        onVerify: onVerify,
        onResendCode: onResendCode,
        otpLength: otpLength,
        resendDelaySeconds: resendDelaySeconds,
        verifyButtonText: verifyButtonText,
        resendCodeText: resendCodeText,
        resendTimerText: resendTimerText,
      ),
    );
  }

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  final List<String> _otpValues = [];
  final RxInt _secondsRemaining = 0.obs;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeOtpFields();
    _startTimer();
  }

  void _initializeOtpFields() {
    for (int i = 0; i < widget.otpLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
      _otpValues.add('');
    }
  }

  void _startTimer() {
    _secondsRemaining.value = widget.resendDelaySeconds;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool _validateOtp() {
    return _otpValues.every((value) => value.isNotEmpty);
  }

  void _handleOtpChange(String value, int index) {
    _otpValues[index] = value;
    if (value.length == 1 && index < widget.otpLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        BottomSheetHeader(
          title: widget.title,
          subtitle: widget.subtitle,
          trailing: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ),

        // OTP Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
            widget.otpLength,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _OtpTextField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                onChanged: (value) => _handleOtpChange(value, index),
                theme: theme,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // Resend Code Section
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (_secondsRemaining.value != 0) ...[
                Text(
                  widget.resendTimerText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                Text(
                  _formattedTime,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ] else ...[
                const Spacer(),
                TextButton(
                  onPressed: () {
                    widget.onResendCode?.call();
                    _startTimer();
                  },
                  child: Text(
                    widget.resendCodeText,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),

        const SizedBox(height: 30),

        // Verify Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_validateOtp()) {
                widget.onVerify(_otpValues.join());
              }
            },
            child: Text(widget.verifyButtonText),
          ),
        ),

        // Bottom padding for keyboard
        SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
      ],
    );
  }
}

class _OtpTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final ThemeData theme;

  const _OtpTextField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.colorScheme.outline,
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        maxLength: 1,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        decoration: const InputDecoration(
          counter: Offstage(),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }
} 