import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';

class BrutalCard extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool hasShadow;
  final bool isClickable;
  final VoidCallback? onTap;
  final BrutalCardVariant variant;
  final BrutalBorderStyle? borderStyle;
  final double? borderWidth;
  final double? rotation;

  const BrutalCard({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.hasShadow = true,
    this.isClickable = false,
    this.onTap,
    this.variant = BrutalCardVariant.regular,
    this.borderStyle,
    this.borderWidth,
    this.rotation,
  });

  // Fábrica para tarjeta destacada
  factory BrutalCard.featured({
    Key? key,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return BrutalCard(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      hasShadow: true,
      isClickable: onTap != null,
      onTap: onTap,
      variant: BrutalCardVariant.featured,
      child: child,
    );
  }

  // Fábrica para tarjeta glitch
  factory BrutalCard.glitch({
    Key? key,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    String? title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return BrutalCard(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      hasShadow: true,
      isClickable: onTap != null,
      onTap: onTap,
      variant: BrutalCardVariant.glitch,
      rotation: -0.01,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderStyle = borderStyle ?? theme.borderStyle;

    // Determinar colores según la variante
    Color bgColor = backgroundColor ?? theme.colors.surface;
    Color borderCol = borderColor ?? theme.colors.border;
    BoxShadow? shadow;

    if (hasShadow) {
      switch (variant) {
        case BrutalCardVariant.regular:
          shadow = theme.shadow.toBoxShadow(borderCol);
          break;
        case BrutalCardVariant.featured:
          shadow = BrutalShadow(
            offset: const Offset(4.0, 4.0),
            opacity: 0.5,
          ).toBoxShadow(borderCol);
          break;
        case BrutalCardVariant.compact:
          shadow = BrutalShadow(
            offset: const Offset(2.0, 2.0),
            opacity: 0.3,
          ).toBoxShadow(borderCol);
          break;
        case BrutalCardVariant.glitch:
          shadow = BrutalShadow(
            offset: const Offset(3.0, -2.0),
            opacity: 0.4,
            blurRadius: 0.5,
          ).toBoxShadow(borderCol);
          break;
      }
    }

    // Construir el contenido
    List<Widget> contentChildren = [];

    // Agregar header si hay título
    if (title != null ||
        subtitle != null ||
        leading != null ||
        trailing != null) {
      List<Widget> headerChildren = [];

      if (leading != null) {
        headerChildren.add(
          Padding(
            padding: EdgeInsets.only(right: theme.spacing),
            child: leading,
          ),
        );
      }

      if (title != null || subtitle != null) {
        headerChildren.add(
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  BrutalText.heading3(
                    title!,
                    isGlitched: variant == BrutalCardVariant.glitch,
                  ),
                if (title != null && subtitle != null)
                  SizedBox(height: theme.spacing / 2),
                if (subtitle != null)
                  BrutalText(subtitle!, brutalStyle: BrutalTextStyle.caption),
              ],
            ),
          ),
        );
      }

      if (trailing != null) {
        headerChildren.add(
          Padding(
            padding: EdgeInsets.only(left: theme.spacing),
            child: trailing,
          ),
        );
      }

      contentChildren.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: headerChildren,
        ),
      );

      if (child != null) {
        contentChildren.add(SizedBox(height: theme.spacing));
      }
    }

    if (child != null) {
      contentChildren.add(child!);
    }

    Widget content = Padding(
      padding: padding ?? EdgeInsets.all(theme.spacing * 1.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: contentChildren,
      ),
    );

    // Aplicar decoración y efectos según la variante
    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        border:
            effectiveBorderStyle == BrutalBorderStyle.none
                ? null
                : Border.all(color: borderCol, width: effectiveBorderWidth),
        boxShadow: shadow != null ? [shadow] : null,
      ),
      child: content,
    );

    // Aplicar rotación para efecto brutalist
    if (rotation != null || variant == BrutalCardVariant.glitch) {
      double rotationAngle =
          rotation ?? (variant == BrutalCardVariant.glitch ? -0.01 : 0.0);
      card = Transform.rotate(angle: rotationAngle, child: card);
    }

    // Hacer clickeable si es necesario
    if (isClickable || onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        child: MouseRegion(cursor: SystemMouseCursors.click, child: card),
      );
    }

    return card;
  }
}

enum BrutalCardVariant {
  regular, // Tarjeta estándar
  featured, // Tarjeta destacada con sombra más intensa
  compact, // Tarjeta con menos padding
  glitch, // Tarjeta con efecto "glitcheado"
}
