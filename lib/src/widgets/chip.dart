import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

class BrutalChip extends StatelessWidget {
  final String label;
  final Widget? avatar;
  final Widget? deleteIcon;
  final VoidCallback? onDeleted;
  final VoidCallback? onTap;
  final bool isSelected;
  final Color? backgroundColor;
  final Color? labelColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final BrutalChipVariant variant;
  final double? rotation;
  final bool isDisabled;

  const BrutalChip({
    super.key,
    required this.label,
    this.avatar,
    this.deleteIcon,
    this.onDeleted,
    this.onTap,
    this.isSelected = false,
    this.backgroundColor,
    this.labelColor,
    this.borderColor,
    this.padding,
    this.variant = BrutalChipVariant.default_,
    this.rotation,
    this.isDisabled = false,
  });

  // Fábrica para chip de filtro
  factory BrutalChip.filter({
    Key? key,
    required String label,
    bool isSelected = false,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
    Color? borderColor,
    bool isDisabled = false,
  }) {
    return BrutalChip(
      key: key,
      label: label,
      isSelected: isSelected,
      onTap: onTap,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
      borderColor: borderColor,
      variant: BrutalChipVariant.filter,
      isDisabled: isDisabled,
    );
  }

  // Fábrica para chip de acción
  factory BrutalChip.action({
    Key? key,
    required String label,
    Widget? avatar,
    VoidCallback? onTap,
    Color? backgroundColor,
    Color? labelColor,
    Color? borderColor,
    bool isDisabled = false,
  }) {
    return BrutalChip(
      key: key,
      label: label,
      avatar: avatar,
      onTap: onTap,
      backgroundColor: backgroundColor,
      labelColor: labelColor,
      borderColor: borderColor,
      variant: BrutalChipVariant.action,
      isDisabled: isDisabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determinar colores según el estado y la variante
    Color bgColor;
    Color textColor;
    Color borderCol;

    switch (variant) {
      case BrutalChipVariant.default_:
        bgColor =
            isSelected
                ? theme.colors.primary
                : (backgroundColor ?? theme.colors.surface);
        textColor =
            isSelected
                ? theme.colors.background
                : (labelColor ?? theme.colors.text);
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ??
                    (isSelected ? theme.colors.primary : theme.colors.border));
        break;
      case BrutalChipVariant.filter:
        bgColor =
            isSelected ? theme.colors.primary : BrutalConstants.transparent;
        textColor = isSelected ? theme.colors.background : theme.colors.text;
        borderCol =
            isDisabled
                ? theme.colors.textLight
                : (borderColor ??
                    (isSelected ? theme.colors.primary : theme.colors.border));
        break;
      case BrutalChipVariant.action:
        bgColor = backgroundColor ?? theme.colors.primary;
        textColor = labelColor ?? theme.colors.background;
        borderCol = borderColor ?? theme.colors.border;
        break;
      case BrutalChipVariant.minimal:
        bgColor =
            isSelected
                ? theme.colors.primary.withOpacity(0.1)
                : BrutalConstants.transparent;
        textColor =
            isDisabled
                ? theme.colors.textLight
                : (labelColor ?? theme.colors.text);
        borderCol = BrutalConstants.transparent;
        break;
      case BrutalChipVariant.broken:
        bgColor = backgroundColor ?? theme.colors.surface;
        textColor = labelColor ?? theme.colors.text;
        borderCol = borderColor ?? theme.colors.border;
        break;
    }

    if (isDisabled) {
      textColor = theme.colors.textLight;
    }

    // Construir el contenido del chip
    List<Widget> contentChildren = [];

    // Avatar si existe
    if (avatar != null) {
      contentChildren.add(
        Padding(
          padding: EdgeInsets.only(right: theme.spacing / 2),
          child: avatar!,
        ),
      );
    }

    // Texto del chip
    contentChildren.add(
      BrutalText(
        label,
        brutalStyle: BrutalTextStyle.caption,
        style: TextStyle(
          color: textColor,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );

    // Icono de eliminar si existe
    if (deleteIcon != null && onDeleted != null && !isDisabled) {
      contentChildren.add(
        Padding(
          padding: EdgeInsets.only(left: theme.spacing / 2),
          child: GestureDetector(onTap: onDeleted, child: deleteIcon!),
        ),
      );
    }

    // Contenedor del chip
    Widget chip = Container(
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: theme.spacing,
            vertical: theme.spacing / 2,
          ),
      decoration: BoxDecoration(
        color: bgColor,
        border:
            variant != BrutalChipVariant.minimal
                ? Border.all(color: borderCol, width: theme.borderWidth)
                : null,
        boxShadow:
            variant == BrutalChipVariant.broken && !isDisabled && !isSelected
                ? [
                  BoxShadow(
                    color: borderCol.withOpacity(0.4),
                    offset: Offset(1, 1),
                    blurRadius: 0,
                  ),
                ]
                : null,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: contentChildren),
    );

    // Aplicar rotación para efecto brutalist o "broken"
    if (rotation != null || variant == BrutalChipVariant.broken) {
      double rotationAngle =
          rotation ?? (variant == BrutalChipVariant.broken ? 0.02 : 0.0);
      chip = Transform.rotate(angle: rotationAngle, child: chip);
    }

    // Hacer clickeable si es necesario
    if (onTap != null && !isDisabled) {
      return GestureDetector(
        onTap: onTap,
        child: MouseRegion(cursor: SystemMouseCursors.click, child: chip),
      );
    }

    return chip;
  }
}

enum BrutalChipVariant {
  default_, // Chip estándar
  filter, // Chip para filtros seleccionables
  action, // Chip para acciones
  minimal, // Chip minimalista (sin bordes)
  broken, // Chip con efecto "roto"
}
