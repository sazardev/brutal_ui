import 'package:flutter/material.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';
import 'button.dart';

/// A brutalist dialog/modal widget
class BrutalDialog extends StatelessWidget {
  final String? title;
  final Widget content;
  final List<BrutalDialogAction>? actions;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? maxWidth;
  final EdgeInsetsGeometry? contentPadding;
  final BrutalDialogVariant variant;
  final bool isGlitched;
  final bool hasShadow;

  const BrutalDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.backgroundColor,
    this.borderColor,
    this.maxWidth,
    this.contentPadding,
    this.variant = BrutalDialogVariant.default_,
    this.isGlitched = false,
    this.hasShadow = true,
  });

  /// Creates an alert dialog with a brutalist style
  factory BrutalDialog.alert({
    Key? key,
    required String title,
    required Widget content,
    VoidCallback? onConfirm,
    String confirmText = 'OK',
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BrutalDialog(
      key: key,
      title: title,
      content: content,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      variant: BrutalDialogVariant.alert,
      actions: [
        BrutalDialogAction(
          label: confirmText,
          onPressed: onConfirm ?? () {},
          isDefault: true,
        ),
      ],
    );
  }

  /// Creates a confirmation dialog with a brutalist style
  factory BrutalDialog.confirm({
    Key? key,
    required String title,
    required Widget content,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BrutalDialog(
      key: key,
      title: title,
      content: content,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      variant: BrutalDialogVariant.default_,
      actions: [
        BrutalDialogAction(label: cancelText, onPressed: onCancel ?? () {}),
        BrutalDialogAction(
          label: confirmText,
          onPressed: onConfirm ?? () {},
          isDefault: true,
        ),
      ],
    );
  }

  /// Creates a glitched dialog with a brutalist style
  factory BrutalDialog.glitched({
    Key? key,
    String? title,
    required Widget content,
    List<BrutalDialogAction>? actions,
    Color? backgroundColor,
    Color? borderColor,
  }) {
    return BrutalDialog(
      key: key,
      title: title,
      content: content,
      actions: actions,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      variant: BrutalDialogVariant.broken,
      isGlitched: true,
    );
  }

  /// Shows a BrutalDialog as a modal overlay
  static Future<T?> show<T>({
    required BuildContext context,
    required BrutalDialog dialog,
    bool barrierDismissible = true,
    Color barrierColor = const Color(0x80000000),
  }) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      pageBuilder: (context, _, __) => dialog,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determine colors based on variant
    Color bgColor = backgroundColor ?? theme.colors.surface;
    Color borderCol = borderColor ?? theme.colors.border;

    // Apply slight rotation and offset based on variant
    double rotation = 0.0;
    Offset offset = Offset.zero;

    switch (variant) {
      case BrutalDialogVariant.default_:
        // No special styling
        break;
      case BrutalDialogVariant.alert:
        borderCol = theme.colors.error;
        break;
      case BrutalDialogVariant.broken:
        rotation = 0.02;
        offset = const Offset(4.0, 2.0);
        break;
    }

    // Build the dialog content
    Widget dialogContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null) ...[
          Container(
            padding: EdgeInsets.all(theme.spacing),
            decoration: BoxDecoration(
              color:
                  variant == BrutalDialogVariant.alert
                      ? theme.colors.error
                      : theme.colors.primary,
              border: Border(
                bottom: BorderSide(color: borderCol, width: theme.borderWidth),
              ),
            ),
            child: BrutalText(
              title!,
              brutalStyle: BrutalTextStyle.heading3,
              style: TextStyle(color: theme.colors.background),
              isGlitched: isGlitched,
            ),
          ),
        ],

        Padding(
          padding: contentPadding ?? EdgeInsets.all(theme.spacing * 1.5),
          child: content,
        ),

        if (actions != null && actions!.isNotEmpty) ...[
          Container(
            padding: EdgeInsets.all(theme.spacing),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderCol, width: theme.borderWidth),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 0; i < actions!.length; i++) ...[
                  if (i > 0) SizedBox(width: theme.spacing),
                  _buildActionButton(actions![i], theme),
                ],
              ],
            ),
          ),
        ],
      ],
    );

    // Wrap in a container with border and decoration
    Widget dialog = Container(
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderCol, width: theme.borderWidth),
        boxShadow:
            hasShadow
                ? [theme.shadow.toBoxShadow(theme.colors.text.withOpacity(0.4))]
                : null,
      ),
      constraints: BoxConstraints(maxWidth: maxWidth ?? 400.0),
      child: dialogContent,
    );

    // Apply rotation if needed
    if (rotation != 0.0) {
      dialog = Transform.rotate(angle: rotation, child: dialog);
    }

    // Apply offset if needed
    if (offset != Offset.zero) {
      dialog = Transform.translate(offset: offset, child: dialog);
    }

    // Apply glitch effect if needed
    if (isGlitched) {
      dialog = Stack(
        children: [
          Positioned(
            left: 2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: dialog,
              ),
            ),
          ),
          Positioned(
            left: -2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: dialog,
              ),
            ),
          ),
          dialog,
        ],
      );
    }

    // Center the dialog in the screen
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(theme.spacing * 2),
        child: dialog,
      ),
    );
  }

  /// Builds an action button for the dialog
  Widget _buildActionButton(BrutalDialogAction action, BrutalTheme theme) {
    if (action.isDefault) {
      return BrutalButton.primary(
        text: action.label,
        onPressed: action.onPressed,
        isDisabled: action.isDisabled,
      );
    } else if (action.isDestructive) {
      return BrutalButton.destructive(
        text: action.label,
        onPressed: action.onPressed,
        isDisabled: action.isDisabled,
      );
    } else {
      return BrutalButton(
        text: action.label,
        onPressed: action.onPressed,
        isDisabled: action.isDisabled,
      );
    }
  }
}

/// An action button for BrutalDialog
class BrutalDialogAction {
  final String label;
  final VoidCallback onPressed;
  final bool isDefault;
  final bool isDestructive;
  final bool isDisabled;

  const BrutalDialogAction({
    required this.label,
    required this.onPressed,
    this.isDefault = false,
    this.isDestructive = false,
    this.isDisabled = false,
  });
}

/// Shows a toast-like message with brutalist style
class BrutalTooltip extends StatelessWidget {
  final Widget child;
  final String message;
  final TooltipTriggerMode triggerMode;
  final bool isGlitched;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Duration showDuration;

  const BrutalTooltip({
    super.key,
    required this.child,
    required this.message,
    this.triggerMode = TooltipTriggerMode.longPress,
    this.isGlitched = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.showDuration = const Duration(seconds: 2),
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      waitDuration: const Duration(milliseconds: 400),
      showDuration: showDuration,
      decoration: _BrutalTooltipDecoration(
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        theme: BrutalTheme.of(context),
        isGlitched: isGlitched,
      ),
      textStyle: TextStyle(
        color: textColor ?? BrutalTheme.of(context).colors.background,
        fontFamily: BrutalTheme.of(context).typography.body.fontFamily,
        fontSize: 14.0,
      ),
      child: child,
    );
  }
}

/// Custom tooltip decoration for brutalist style
class _BrutalTooltipDecoration extends Decoration {
  final Color? backgroundColor;
  final Color? borderColor;
  final BrutalTheme theme;
  final bool isGlitched;

  const _BrutalTooltipDecoration({
    this.backgroundColor,
    this.borderColor,
    required this.theme,
    this.isGlitched = false,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _BrutalTooltipPainter(
      backgroundColor: backgroundColor ?? theme.colors.primary,
      borderColor: borderColor ?? theme.colors.border,
      theme: theme,
      isGlitched: isGlitched,
    );
  }
}

/// Custom box painter for brutalist tooltips
class _BrutalTooltipPainter extends BoxPainter {
  final Color backgroundColor;
  final Color borderColor;
  final BrutalTheme theme;
  final bool isGlitched;

  const _BrutalTooltipPainter({
    required this.backgroundColor,
    required this.borderColor,
    required this.theme,
    this.isGlitched = false,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & (configuration.size ?? const Size(0, 0));
    final borderWidth = theme.borderWidth;

    // Apply slight rotation for brutalist effect
    final matrix = Matrix4.identity();
    if (isGlitched) {
      matrix.translate(offset.dx + rect.width / 2, offset.dy + rect.height / 2);
      matrix.rotateZ(0.02);
      matrix.translate(
        -(offset.dx + rect.width / 2),
        -(offset.dy + rect.height / 2),
      );
    }
    canvas.save();
    canvas.transform(matrix.storage);

    // Draw border
    final borderRect = rect;
    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = borderWidth;

    canvas.drawRect(borderRect, borderPaint);

    // Draw background
    final bgRect = Rect.fromLTRB(
      rect.left + borderWidth / 2,
      rect.top + borderWidth / 2,
      rect.right - borderWidth / 2,
      rect.bottom - borderWidth / 2,
    );
    final bgPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

    canvas.drawRect(bgRect, bgPaint);

    // Apply glitch effect if needed
    if (isGlitched) {
      final redOffset = Offset(2, 0);
      final blueOffset = Offset(-2, 0);

      // Red glitch effect
      final redPaint =
          Paint()
            ..color = const Color(0xBFFF0000)
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
      canvas.drawRect(borderRect.shift(redOffset), redPaint);

      // Blue glitch effect
      final bluePaint =
          Paint()
            ..color = const Color(0xBF00FFFF)
            ..style = PaintingStyle.stroke
            ..strokeWidth = borderWidth;
      canvas.drawRect(borderRect.shift(blueOffset), bluePaint);
    }

    canvas.restore();
  }
}

/// Dialog variants
enum BrutalDialogVariant { default_, alert, broken }

/// Tooltip trigger modes
enum TooltipTriggerMode { manual, longPress, tap }
