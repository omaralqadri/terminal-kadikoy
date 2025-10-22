import 'package:flutter/material.dart';
import 'package:terminal_kadikoy/core/theme/app_colors.dart';
import 'package:terminal_kadikoy/core/constants/app_constants.dart';

/// Custom button widget with consistent styling
/// Supports different styles, colors, and sizes for app-wide consistency
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool showIcon;
  final double? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final double? fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.showIcon = true,
    this.borderRadius,
    this.width,
    this.height,
    this.padding,
    this.fontSize,
  });

  /// Factory constructor for fully rounded button (pill shape)
  factory CustomButton.rounded({
    required String text,
    required VoidCallback? onPressed,
    Color? backgroundColor,
    Color? textColor,
    bool isLoading = false,
    double? width,
    double? height,
    IconData? icon,
    bool showIcon = false,
    double? fontSize,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      textColor: textColor,
      isLoading: isLoading,
      borderRadius: 100,
      width: width,
      height: height,
      icon: icon,
      showIcon: showIcon,
      fontSize: fontSize
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = borderRadius ?? AppConstants.radiusMedium;
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingMedium,
        );

    if (isOutlined) {
      final button = showIcon && icon != null
          ? OutlinedButton.icon(
              onPressed: isLoading ? null : onPressed,
              icon: _buildIcon(),
              label: _buildText(context),
              style: _buildOutlinedButtonStyle(effectiveBorderRadius, effectivePadding),
            )
          : OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: _buildOutlinedButtonStyle(effectiveBorderRadius, effectivePadding),
              child: _buildButtonChild(context),
            );

      return _wrapWithContainer(button);
    }

    final button = showIcon && icon != null
        ? ElevatedButton.icon(
            onPressed: isLoading ? null : onPressed,
            icon: _buildIcon(),
            label: _buildText(context),
            style: _buildElevatedButtonStyle(effectiveBorderRadius, effectivePadding),
          )
        : ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: _buildElevatedButtonStyle(effectiveBorderRadius, effectivePadding),
            child: _buildButtonChild(context),
          );

    return _wrapWithContainer(button);
  }

  Widget _wrapWithContainer(Widget button) {
    if (width != null || height != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }
    return button;
  }

  Widget _buildIcon() {
    if (isLoading) {
      return SizedBox(
        width: AppConstants.iconSmall,
        height: AppConstants.iconSmall,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: textColor ?? AppColors.textOnPrimary,
        ),
      );
    }
    return Icon(icon ?? Icons.arrow_forward);
  }

  Widget _buildText(BuildContext context) {
    return Text(
      text,
      style: fontSize != null
          ? TextStyle(fontSize: fontSize)
          : null,
    );
  }

  Widget _buildButtonChild(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        width: AppConstants.iconSmall,
        height: AppConstants.iconSmall,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: textColor ?? AppColors.textOnPrimary,
        ),
      );
    }
    return _buildText(context);
  }

  ButtonStyle _buildElevatedButtonStyle(double radius, EdgeInsets effectivePadding) {
    return ElevatedButton.styleFrom(
      backgroundColor: backgroundColor ?? AppColors.primary,
      foregroundColor: textColor ?? AppColors.textOnPrimary,
      padding: effectivePadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 0,
    );
  }

  ButtonStyle _buildOutlinedButtonStyle(double radius, EdgeInsets effectivePadding) {
    return OutlinedButton.styleFrom(
      foregroundColor: backgroundColor ?? AppColors.primary,
      padding: effectivePadding,
      side: BorderSide(color: backgroundColor ?? AppColors.primary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

