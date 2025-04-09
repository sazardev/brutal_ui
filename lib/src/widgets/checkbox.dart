import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';

class BrutalCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? label;
  final bool isDisabled;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final double? borderWidth;
  final BrutalCheckboxVariant variant;
  final String? description;

  const BrutalCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.isDisabled = false,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.borderWidth,
    this.variant = BrutalCheckboxVariant.default_,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;

    // Determinar colores según el estado y la variante
    Color checkboxColor;
    Color borderCol;
    Color markColor;

    switch (variant) {
      case BrutalCheckboxVariant.default_:
        checkboxColor =
            value
                ? (isDisabled
                    ? theme.colors.textLight
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ?? theme.colors.border);
        markColor = checkColor ?? theme.colors.background;
        break;
      case BrutalCheckboxVariant.minimal:
        checkboxColor =
            value
                ? (isDisabled
                    ? theme.colors.surface
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (value
                    ? checkboxColor
                    : (borderColor ?? theme.colors.border));
        markColor = checkColor ?? theme.colors.background;
        break;
      case BrutalCheckboxVariant.broken:
        checkboxColor =
            value
                ? (isDisabled
                    ? theme.colors.textLight
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ?? theme.colors.border);
        markColor = checkColor ?? theme.colors.background;
        break;
    }

    // Construir el checkbox
    Widget checkboxWidget = GestureDetector(
      onTap: isDisabled ? null : () => onChanged(!value),
      child: MouseRegion(
        cursor:
            isDisabled
                ? SystemMouseCursors.forbidden
                : SystemMouseCursors.click,
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: checkboxColor,
            border: Border.all(color: borderCol, width: effectiveBorderWidth),
            boxShadow:
                variant == BrutalCheckboxVariant.broken && !isDisabled
                    ? [
                      BoxShadow(
                        color: borderCol.withOpacity(0.5),
                        offset: const Offset(1, 1),
                        blurRadius: 0,
                      ),
                    ]
                    : null,
          ),
          alignment: Alignment.center,
          child:
              value
                  ? Icon(
                    const IconData(
                      0xe876,
                      fontFamily: 'MaterialIcons',
                    ), // check mark
                    size: 16.0,
                    color: markColor,
                  )
                  : null,
        ),
      ),
    );

    // Aplicar rotación para efecto brutalist
    if (variant == BrutalCheckboxVariant.broken) {
      checkboxWidget = Transform.rotate(angle: 0.03, child: checkboxWidget);
    }

    // Si no hay etiqueta o descripción, devolver solo el checkbox
    if (label == null && description == null) {
      return checkboxWidget;
    }

    // Construir el widget completo con etiqueta y descripción
    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          checkboxWidget,
          SizedBox(width: theme.spacing),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null)
                  BrutalText(
                    label!,
                    style: TextStyle(
                      color: isDisabled ? theme.colors.textLight : null,
                      fontWeight: value ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                if (label != null && description != null)
                  SizedBox(height: theme.spacing / 3),
                if (description != null)
                  BrutalText(
                    description!,
                    brutalStyle: BrutalTextStyle.caption,
                    style: TextStyle(
                      color:
                          isDisabled
                              ? theme.colors.textLight
                              : theme.colors.textLight,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

enum BrutalCheckboxVariant {
  default_, // Checkbox estándar
  minimal, // Checkbox con bordes mínimos
  broken, // Checkbox con efecto "roto"
}
