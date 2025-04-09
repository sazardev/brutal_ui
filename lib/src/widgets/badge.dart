import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';

class BrutalBadge extends StatelessWidget {
  final String? label;
  final Widget? child;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final BrutalBadgeVariant variant;
  final BrutalBadgePosition position;
  final double? offset;
  final bool isStandalone;
  final double? borderWidth;

  const BrutalBadge({
    super.key,
    this.label,
    this.child,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.variant = BrutalBadgeVariant.default_,
    this.position = BrutalBadgePosition.topRight,
    this.offset,
    this.isStandalone = false,
    this.borderWidth,
  }) : assert(
         isStandalone ? label != null : child != null,
         'Either provide a label for standalone badges or a child for positioned badges',
       );

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;

    // Determinar colores según la variante
    Color bgColor;
    Color txtColor;
    Color borderCol;

    switch (variant) {
      case BrutalBadgeVariant.default_:
        bgColor = backgroundColor ?? theme.colors.primary;
        txtColor = textColor ?? theme.colors.background;
        borderCol = borderColor ?? theme.colors.border;
        break;
      case BrutalBadgeVariant.secondary:
        bgColor = backgroundColor ?? theme.colors.secondary;
        txtColor = textColor ?? theme.colors.background;
        borderCol = borderColor ?? theme.colors.border;
        break;
      case BrutalBadgeVariant.error:
        bgColor = backgroundColor ?? theme.colors.error;
        txtColor = textColor ?? theme.colors.background;
        borderCol = borderColor ?? theme.colors.error;
        break;
      case BrutalBadgeVariant.minimal:
        bgColor = backgroundColor ?? theme.colors.primary.withOpacity(0.2);
        txtColor = textColor ?? theme.colors.primary;
        borderCol = borderColor ?? bgColor;
        break;
    }

    // Construir el badge
    final badgeWidget = Container(
      padding:
          label != null
              ? EdgeInsets.symmetric(horizontal: theme.spacing / 2, vertical: 2)
              : const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderCol, width: effectiveBorderWidth),
      ),
      constraints:
          label != null
              ? null
              : const BoxConstraints(minWidth: 16, minHeight: 16),
      child:
          label != null
              ? BrutalText(
                label!,
                brutalStyle: BrutalTextStyle.caption,
                style: TextStyle(
                  color: txtColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )
              : null,
    );

    // Si es un badge independiente, devolverlo directamente
    if (isStandalone) {
      return badgeWidget;
    }

    // De lo contrario, posicionarlo en relación al child
    final badgeOffset = offset ?? 0.0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          left:
              position == BrutalBadgePosition.topLeft ||
                      position == BrutalBadgePosition.bottomLeft
                  ? -badgeOffset
                  : null,
          right:
              position == BrutalBadgePosition.topRight ||
                      position == BrutalBadgePosition.bottomRight
                  ? -badgeOffset
                  : null,
          top:
              position == BrutalBadgePosition.topLeft ||
                      position == BrutalBadgePosition.topRight
                  ? -badgeOffset
                  : null,
          bottom:
              position == BrutalBadgePosition.bottomLeft ||
                      position == BrutalBadgePosition.bottomRight
                  ? -badgeOffset
                  : null,
          child: badgeWidget,
        ),
      ],
    );
  }
}

enum BrutalBadgeVariant {
  default_, // Badge primario
  secondary, // Badge secundario
  error, // Badge de error o alerta
  minimal, // Badge minimalista con fondo semitransparente
}

enum BrutalBadgePosition { topRight, topLeft, bottomRight, bottomLeft }
