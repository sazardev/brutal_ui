import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';

class BrutalToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final String? activeText;
  final String? inactiveText;
  final bool isDisabled;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final BrutalToggleVariant variant;

  const BrutalToggle({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.activeText,
    this.inactiveText,
    this.isDisabled = false,
    this.activeColor,
    this.inactiveColor,
    this.borderColor,
    this.width,
    this.height,
    this.variant = BrutalToggleVariant.default_,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final toggleWidth = width ?? 56.0;
    final toggleHeight = height ?? 28.0;

    // Determinar colores según el estado y la variante
    Color toggleColor =
        value
            ? (isDisabled
                ? theme.colors.textLight
                : (activeColor ?? theme.colors.primary))
            : (isDisabled
                ? theme.colors.surface
                : (inactiveColor ?? theme.colors.surface));

    Color borderCol =
        isDisabled
            ? theme.colors.textLight
            : (borderColor ?? theme.colors.border);

    Color handleColor;

    switch (variant) {
      case BrutalToggleVariant.default_:
        handleColor = value ? theme.colors.background : theme.colors.text;
        break;
      case BrutalToggleVariant.solid:
        handleColor = value ? theme.colors.background : borderCol;
        break;
      case BrutalToggleVariant.broken:
        handleColor = value ? theme.colors.background : borderCol;
        break;
      case BrutalToggleVariant.minimal:
        handleColor = value ? theme.colors.primary : theme.colors.text;
        toggleColor = theme.colors.surface;
        break;
    }

    if (isDisabled) {
      handleColor = theme.colors.textLight;
    }

    // Construir el track (base) del toggle
    Widget track = Container(
      width: toggleWidth,
      height: toggleHeight,
      decoration: BoxDecoration(
        color: toggleColor,
        border: Border.all(color: borderCol, width: theme.borderWidth),
        boxShadow:
            variant == BrutalToggleVariant.broken && !isDisabled
                ? [
                  BoxShadow(
                    color: borderCol.withOpacity(0.4),
                    offset: const Offset(1.5, 1.5),
                    blurRadius: 0,
                  ),
                ]
                : null,
      ),
      child: Stack(
        children: [
          // Texto ON/OFF si se proporciona
          if (activeText != null || inactiveText != null)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (activeText != null)
                      BrutalText(
                        activeText!,
                        brutalStyle: BrutalTextStyle.caption,
                        style: TextStyle(
                          color:
                              value
                                  ? theme.colors.background
                                  : theme.colors.textLight,
                          fontSize: 12,
                        ),
                      ),
                    if (inactiveText != null)
                      BrutalText(
                        inactiveText!,
                        brutalStyle: BrutalTextStyle.caption,
                        style: TextStyle(
                          color:
                              !value
                                  ? theme.colors.text
                                  : theme.colors.textLight,
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
            ),

          // Handle (indicador) del toggle
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            left: value ? (toggleWidth - toggleHeight) : 0,
            top: 0,
            child: Container(
              width: toggleHeight,
              height: toggleHeight,
              decoration: BoxDecoration(
                color: handleColor,
                border: Border.all(
                  color: borderCol,
                  width:
                      variant == BrutalToggleVariant.minimal
                          ? 0
                          : theme.borderWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    // Aplicar rotación para efecto brutalist
    if (variant == BrutalToggleVariant.broken) {
      track = Transform.rotate(angle: 0.02, child: track);
    }

    // Construir el widget completo con etiqueta si existe
    Widget toggle = GestureDetector(
      onTap: isDisabled ? null : () => onChanged(!value),
      child: MouseRegion(
        cursor:
            isDisabled
                ? SystemMouseCursors.forbidden
                : SystemMouseCursors.click,
        child: track,
      ),
    );

    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          toggle,
          SizedBox(width: theme.spacing),
          BrutalText(
            label!,
            style: TextStyle(
              color: isDisabled ? theme.colors.textLight : theme.colors.text,
            ),
          ),
        ],
      );
    }

    return toggle;
  }
}

enum BrutalToggleVariant {
  default_, // Toggle estándar
  solid, // Toggle con colores sólidos
  broken, // Toggle con efecto "roto"
  minimal, // Toggle minimalista
}
