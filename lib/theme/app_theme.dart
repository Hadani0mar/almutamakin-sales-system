import 'dart:math' as math;
import 'package:flutter/material.dart';

class AppTheme {
  // Convert OKLCH to RGB
  // OKLCH format: oklch(L C H) where L is lightness (0-1), C is chroma, H is hue (0-360)
  static Color _oklchToColor(double lightness, double chroma, double hue) {
    // Convert OKLCH to OKLab first
    final a = chroma * math.cos(hue * math.pi / 180);
    final b = chroma * math.sin(hue * math.pi / 180);
    
    // Convert OKLab to linear RGB
    final l_ = lightness + 0.3963377774 * a + 0.2158037573 * b;
    final m_ = lightness - 0.1055613458 * a - 0.0638541728 * b;
    final s_ = lightness - 0.0894841775 * a - 1.2914855480 * b;
    
    final l = l_ * l_ * l_;
    final m = m_ * m_ * m_;
    final s = s_ * s_ * s_;
    
    // Convert linear RGB to sRGB
    final r = 4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s;
    final g = -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s;
    final bl = -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s;
    
    // Apply gamma correction
    double toSRGB(double c) {
      if (c <= 0.0031308) {
        return 12.92 * c;
      } else {
        return 1.055 * math.pow(c, 1.0 / 2.4) - 0.055;
      }
    }
    
    final rSRGB = toSRGB(r.clamp(0.0, 1.0));
    final gSRGB = toSRGB(g.clamp(0.0, 1.0));
    final bSRGB = toSRGB(bl.clamp(0.0, 1.0));
    
    return Color.fromRGBO(
      (rSRGB * 255).round().clamp(0, 255),
      (gSRGB * 255).round().clamp(0, 255),
      (bSRGB * 255).round().clamp(0, 255),
      1.0,
    );
  }

  // Light theme colors - Updated with new brand colors
  static final Color _background = _oklchToColor(1.0000, 0, 0);
  static final Color _foreground = _oklchToColor(0.1884, 0.0128, 248.5103);
  static final Color _card = _oklchToColor(0.9784, 0.0011, 197.1387);
  static final Color _cardForeground = _oklchToColor(0.1884, 0.0128, 248.5103);
  static final Color _primary = _oklchToColor(0.6723, 0.1606, 244.9955);
  static final Color _primaryForeground = _oklchToColor(1.0000, 0, 0);
  static final Color _secondary = _oklchToColor(0.1884, 0.0128, 248.5103);
  static final Color _secondaryForeground = _oklchToColor(1.0000, 0, 0);
  static final Color _muted = _oklchToColor(0.9222, 0.0013, 286.3737);
  static final Color _mutedForeground = _oklchToColor(0.1884, 0.0128, 248.5103);
  static final Color _accent = _oklchToColor(0.9392, 0.0166, 250.8453);
  static final Color _accentForeground = _oklchToColor(0.6723, 0.1606, 244.9955);
  static final Color _destructive = _oklchToColor(0.6188, 0.2376, 25.7658);
  static final Color _destructiveForeground = _oklchToColor(1.0000, 0, 0);
  static final Color _border = _oklchToColor(0.9317, 0.0118, 231.6594);
  static final Color _input = _oklchToColor(0.9809, 0.0025, 228.7836);
  static final Color _ring = _oklchToColor(0.6818, 0.1584, 243.3540);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: _primary,
        onPrimary: _primaryForeground,
        secondary: _secondary,
        onSecondary: _secondaryForeground,
        error: _destructive,
        onError: _destructiveForeground,
        surface: _card,
        onSurface: _cardForeground,
        background: _background,
        onBackground: _foreground,
      ),
      scaffoldBackgroundColor: _background,
      cardColor: _card,
      dividerColor: _border,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.8), // 1.3rem * 16
          borderSide: BorderSide(color: _input),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.8),
          borderSide: BorderSide(color: _input),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.8),
          borderSide: BorderSide(color: _ring, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primary,
          foregroundColor: _primaryForeground,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.8), // 1.3rem
          ),
        ),
      ),
      cardTheme: CardThemeData(
        color: _card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.8), // 1.3rem
          side: BorderSide(color: _border, width: 1),
        ),
      ),
    );
  }
}

