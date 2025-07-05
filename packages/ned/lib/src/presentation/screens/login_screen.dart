import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:core/src/constants/app_strings.dart';
import 'package:core/src/constants/app_assets.dart';
import 'package:core/src/presentation/widgets/buttons.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // FocusNodes like in the reference, if needed for focus management
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // To manage autovalidate mode like in reference
  bool _emailFieldFocused = false;
  bool _passwordFieldFocused = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      final success = await ref.read(userNotifierProvider.notifier).login(
            _emailController.text,
            _passwordController.text,
          );

      if (success && mounted) {
        context.go('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(userNotifierProvider);
    final theme = AppTheme.nedTheme; // Use AppTheme.nedTheme directly

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: InkWell(
        onTap: () {
          // Navigate to Sign Up Screen - adapt route as per your go_router setup
          // context.go('/signup'); // Example
          print("Navigate to Sign Up");
        },
        child: Padding(
          padding: EdgeInsets.only(
              top: 20,
              bottom: MediaQuery.of(context).padding.bottom > 0
                  ? MediaQuery.of(context).padding.bottom
                  : 20),
          child: Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              text: AppStrings.doNotHaveAccount, // Use AppStrings
              style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface.withOpacity(0.6)), // Use theme color
              children: [
                TextSpan(
                    text: AppStrings.registerButton, // Use AppStrings
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.primary)), // Use theme color
              ],
            ),
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopImageView(),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      focusNode: _emailFocusNode,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: AppStrings.emailOrPhoneLabel,
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 16,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            AppAssets.userIcon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.onSurface.withOpacity(0.6),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return AppStrings.emailRequired;
                        }
                        return qhValidateEmail(value!);
                      },
                      onChanged: (value) {
                        setState(() {
                          _emailFieldFocused = true;
                          _passwordFieldFocused = false;
                        });
                      },
                      onFieldSubmitted: (v) {
                        _emailFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      autovalidateMode: _emailFieldFocused
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      focusNode: _passwordFocusNode,
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      textInputAction: TextInputAction.done,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500, color: theme.colorScheme.onSurface),
                      decoration: InputDecoration(
                        labelText: AppStrings.passwordLabel,
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                          fontSize: 16,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            AppAssets.lockIcon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.onSurface.withOpacity(0.6),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: SvgPicture.asset(
                            _isPasswordVisible ? AppAssets.eyeSlashIcon : AppAssets.eyeIcon,
                            width: 20,
                            height: 20,
                            colorFilter: ColorFilter.mode(
                              theme.colorScheme.onSurface.withOpacity(0.6),
                              BlendMode.srcIn,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return AppStrings.passwordRequired;
                        }
                        return qhValidatePassword(value!);
                      },
                      onChanged: (value) {
                        setState(() {
                          _emailFieldFocused = false;
                          _passwordFieldFocused = true;
                        });
                      },
                      onFieldSubmitted: (v) {
                        _passwordFocusNode.unfocus();
                        if (_formKey.currentState?.validate() ?? false) {
                          _login();
                        }
                      },
                      autovalidateMode: _passwordFieldFocused
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        text: AppStrings.forgotPasswordLink,
                        onPressed: () {
                          print("Navigate to Forgot Password");
                        },
                        textColor: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Login Button (integrating with existing Riverpod state)
                    loginState.when(
                      initial: () => PrimaryButton(
                        text: AppStrings.signInButton,
                        onPressed: _login,
                      ),
                      loading: () => PrimaryButton(
                        text: AppStrings.signInButton,
                        onPressed: _login,
                        isLoading: true,
                      ),
                      success: (user) => PrimaryButton(
                        text: AppStrings.signInButton,
                        onPressed: _login,
                      ),
                      error: (message) => Column(
                        children: [
                          PrimaryButton(
                            text: AppStrings.signInButton,
                            onPressed: _login,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            message, // This is a dynamic error message
                            style: TextStyle(color: theme.colorScheme.error, fontSize: 14), // theme color
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildLoginWithWidget(context, theme), // Pass theme
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SocialLoginButton(
                            iconPath: AppAssets.fbIcon,
                            text: AppStrings.facebookButton,
                            onPressed: () {
                              print("Facebook Login Tapped");
                              // Handle Facebook login
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SocialLoginButton(
                            iconPath: AppAssets.googleIcon,
                            text: AppStrings.googleButton,
                            onPressed: () {
                              print("Google Login Tapped");
                              // Handle Google login
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                     // Existing phone login button (optional, can be removed if social buttons replace it)
                    CustomTextButton(
                      text: AppStrings.loginWithPhoneButton,
                      onPressed: () {
                        context.go('/phone_login');
                      },
                      textColor: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for _buildTopImageView
  Widget _buildTopImageView() {
    // Placeholder - replace with actual image loading from assets
    // In quick_hire, it's: SvgPicture.asset(topSignIn, fit: BoxFit.cover)
    // Adapt to use Png or Svg based on your actual asset
    return Container(
      height: MediaQuery.of(context).size.height * 0.25, // Example height
      width: double.infinity,
      color: Colors.grey[300], // Placeholder color
      child: Image.asset(
        AppAssets.topSignInImage, // Use AppAssets. Make sure this asset exists in ned's assets
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Text("Image not found"));
        },
      ),
    );
  }

  // Helper method for _buildLoginWithWidget
  Widget _buildLoginWithWidget(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.12))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            AppStrings.loginWithText,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.6)),
          ),
        ),
        Expanded(child: Divider(color: theme.colorScheme.onSurface.withOpacity(0.12))),
      ],
    );
  }
}

// You might need to add these imports if not already present
// import 'package:flutter_svg/flutter_svg.dart'; // For SvgPicture

// Placeholder for qhValidateEmail and qhValidatePassword
// You should implement these based on the reference or use your existing validation logic
String? qhValidateEmail(String value) {
  if (value.isEmpty) {
    return AppStrings.emailRequired;
  }
  if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(value)) {
    return AppStrings.invalidEmail;
  }
  return null;
}

String? qhValidatePassword(String value) {
  if (value.isEmpty) {
    return AppStrings.passwordRequired;
  }
  if (value.length < 6) {
    return AppStrings.passwordMinLength;
  }
  return null;
}
