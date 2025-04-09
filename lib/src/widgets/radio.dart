import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';

class BrutalRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String? label;
  final bool isDisabled;
  final Color? activeColor;
  final Color? borderColor;
  final double? borderWidth;
  final BrutalRadioVariant variant;
  final String? description;

  const BrutalRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    this.isDisabled = false,
    this.activeColor,
    this.borderColor,
    this.borderWidth,
    this.variant = BrutalRadioVariant.default_,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final isSelected = value == groupValue;

    // Determinar colores según el estado y la variante
    Color radioColor;
    Color borderCol;
    Color dotColor;

    switch (variant) {
      case BrutalRadioVariant.default_:
        radioColor =
            isSelected
                ? (isDisabled
                    ? theme.colors.textLight
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ?? theme.colors.border);
        dotColor = theme.colors.background;
        break;
      case BrutalRadioVariant.square:
        radioColor =
            isSelected
                ? (isDisabled
                    ? theme.colors.textLight
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ?? theme.colors.border);
        dotColor = theme.colors.background;
        break;
      case BrutalRadioVariant.broken:
        radioColor =
            isSelected
                ? (isDisabled
                    ? theme.colors.textLight
                    : (activeColor ?? theme.colors.primary))
                : theme.colors.surface;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ?? theme.colors.border);
        dotColor = theme.colors.background;
        break;
    }

    // Construir el radio button
    Widget radioWidget = GestureDetector(
      onTap: isDisabled ? null : () => onChanged(value),
      child: MouseRegion(
        cursor:
            isDisabled
                ? SystemMouseCursors.forbidden
                : SystemMouseCursors.click,
        child: Container(
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            color: radioColor,
            shape:
                variant == BrutalRadioVariant.square
                    ? BoxShape.rectangle
                    : BoxShape.circle,
            border: Border.all(color: borderCol, width: effectiveBorderWidth),
            boxShadow:
                variant == BrutalRadioVariant.broken && !isDisabled
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
              isSelected
                  ? Container(
                    width: 12.0,
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape:
                          variant == BrutalRadioVariant.square
                              ? BoxShape.rectangle
                              : BoxShape.circle,
                    ),
                  )
                  : null,
        ),
      ),
    );

    // Aplicar rotación para efecto brutalist
    if (variant == BrutalRadioVariant.broken) {
      radioWidget = Transform.rotate(angle: 0.03, child: radioWidget);
    }

    // Si no hay etiqueta o descripción, devolver solo el radio button
    if (label == null && description == null) {
      return radioWidget;
    }

    // Construir el widget completo con etiqueta y descripción
    return GestureDetector(
      onTap: isDisabled ? null : () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          radioWidget,
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
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
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

enum BrutalRadioVariant {
  default_, // Radio button circular estándar
  square, // Radio button cuadrado
  broken, // Radio button con efecto "roto"
}
