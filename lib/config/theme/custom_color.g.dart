import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const red_bar = Color(0xFFCF5F5F);
const warning = Color(0xFF0F931D);
const customcolor1 = Color(0xFFE8EB02);

CustomColors lightCustomColors = const CustomColors(
  sourceRedbar: Color(0xFFCF5F5F),
  redbar: Color(0xFFA13D3E),
  onRedbar: Color(0xFFFFFFFF),
  redbarContainer: Color(0xFFFFDAD8),
  onRedbarContainer: Color(0xFF410007),
  sourceWarning: Color(0xFF0F931D),
  warning: Color(0xFF006E10),
  onWarning: Color(0xFFFFFFFF),
  warningContainer: Color(0xFF86FC7A),
  onWarningContainer: Color(0xFF002202),
  sourceCustomcolor1: Color(0xFFE8EB02),
  customcolor1: Color(0xFF616200),
  onCustomcolor1: Color(0xFFFFFFFF),
  customcolor1Container: Color(0xFFE8EB01),
  onCustomcolor1Container: Color(0xFF1C1D00),
);

CustomColors darkCustomColors = const CustomColors(
  sourceRedbar: Color(0xFFCF5F5F),
  redbar: Color(0xFFFFB3B0),
  onRedbar: Color(0xFF630D15),
  redbarContainer: Color(0xFF822529),
  onRedbarContainer: Color(0xFFFFDAD8),
  sourceWarning: Color(0xFF0F931D),
  warning: Color(0xFF6ADF61),
  onWarning: Color(0xFF003A04),
  warningContainer: Color(0xFF005309),
  onWarningContainer: Color(0xFF86FC7A),
  sourceCustomcolor1: Color(0xFFE8EB02),
  customcolor1: Color(0xFFCBCE00),
  onCustomcolor1: Color(0xFF323200),
  customcolor1Container: Color(0xFF494A00),
  onCustomcolor1Container: Color(0xFFE8EB01),
);

/// Defines a set of custom colors, each comprised of 4 complementary tones.
///
/// See also:
///   * <https://m3.material.io/styles/color/the-color-system/custom-colors>
@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    required this.sourceRedbar,
    required this.redbar,
    required this.onRedbar,
    required this.redbarContainer,
    required this.onRedbarContainer,
    required this.sourceWarning,
    required this.warning,
    required this.onWarning,
    required this.warningContainer,
    required this.onWarningContainer,
    required this.sourceCustomcolor1,
    required this.customcolor1,
    required this.onCustomcolor1,
    required this.customcolor1Container,
    required this.onCustomcolor1Container,
  });

  final Color? sourceRedbar;
  final Color? redbar;
  final Color? onRedbar;
  final Color? redbarContainer;
  final Color? onRedbarContainer;
  final Color? sourceWarning;
  final Color? warning;
  final Color? onWarning;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? sourceCustomcolor1;
  final Color? customcolor1;
  final Color? onCustomcolor1;
  final Color? customcolor1Container;
  final Color? onCustomcolor1Container;

  @override
  CustomColors copyWith({
    Color? sourceRedbar,
    Color? redbar,
    Color? onRedbar,
    Color? redbarContainer,
    Color? onRedbarContainer,
    Color? sourceWarning,
    Color? warning,
    Color? onWarning,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? sourceCustomcolor1,
    Color? customcolor1,
    Color? onCustomcolor1,
    Color? customcolor1Container,
    Color? onCustomcolor1Container,
  }) {
    return CustomColors(
      sourceRedbar: sourceRedbar ?? this.sourceRedbar,
      redbar: redbar ?? this.redbar,
      onRedbar: onRedbar ?? this.onRedbar,
      redbarContainer: redbarContainer ?? this.redbarContainer,
      onRedbarContainer: onRedbarContainer ?? this.onRedbarContainer,
      sourceWarning: sourceWarning ?? this.sourceWarning,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      sourceCustomcolor1: sourceCustomcolor1 ?? this.sourceCustomcolor1,
      customcolor1: customcolor1 ?? this.customcolor1,
      onCustomcolor1: onCustomcolor1 ?? this.onCustomcolor1,
      customcolor1Container:
          customcolor1Container ?? this.customcolor1Container,
      onCustomcolor1Container:
          onCustomcolor1Container ?? this.onCustomcolor1Container,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      sourceRedbar: Color.lerp(sourceRedbar, other.sourceRedbar, t),
      redbar: Color.lerp(redbar, other.redbar, t),
      onRedbar: Color.lerp(onRedbar, other.onRedbar, t),
      redbarContainer: Color.lerp(redbarContainer, other.redbarContainer, t),
      onRedbarContainer:
          Color.lerp(onRedbarContainer, other.onRedbarContainer, t),
      sourceWarning: Color.lerp(sourceWarning, other.sourceWarning, t),
      warning: Color.lerp(warning, other.warning, t),
      onWarning: Color.lerp(onWarning, other.onWarning, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t),
      sourceCustomcolor1:
          Color.lerp(sourceCustomcolor1, other.sourceCustomcolor1, t),
      customcolor1: Color.lerp(customcolor1, other.customcolor1, t),
      onCustomcolor1: Color.lerp(onCustomcolor1, other.onCustomcolor1, t),
      customcolor1Container:
          Color.lerp(customcolor1Container, other.customcolor1Container, t),
      onCustomcolor1Container:
          Color.lerp(onCustomcolor1Container, other.onCustomcolor1Container, t),
    );
  }

  /// Returns an instance of [CustomColors] in which the following custom
  /// colors are harmonized with [dynamic]'s [ColorScheme.primary].
  ///
  /// See also:
  ///   * <https://m3.material.io/styles/color/the-color-system/custom-colors#harmonization>
  CustomColors harmonized(ColorScheme dynamic) {
    return copyWith();
  }
}
