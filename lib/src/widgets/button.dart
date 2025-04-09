import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart'; // Importar las constantes compartidas
import 'text.dart';

/// Un botón con el estilo de Brutal UI.
class BrutalButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? borderWidth;
  final BrutalButtonVariant variant;
  final BrutalBorderStyle? borderStyle;
  final IconData? icon;
  final bool iconRight;
  final double? rotation; // Rotación para efecto brutalista

  const BrutalButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.width,
    this.height,
    this.borderWidth,
    this.variant = BrutalButtonVariant.default_,
    this.borderStyle,
    this.icon,
    this.iconRight = false,
    this.rotation,
  });

  // Fábrica para botón primario
  factory BrutalButton.primary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    IconData? icon,
    bool iconRight = false,
  }) {
    return BrutalButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      padding: padding,
      width: width,
      height: height,
      variant: BrutalButtonVariant.primary,
      icon: icon,
      iconRight: iconRight,
    );
  }

  // Fábrica para botón secundario
  factory BrutalButton.secondary({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    IconData? icon,
    bool iconRight = false,
  }) {
    return BrutalButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      padding: padding,
      width: width,
      height: height,
      variant: BrutalButtonVariant.secondary,
      icon: icon,
      iconRight: iconRight,
    );
  }

  // Fábrica para botón destructivo
  factory BrutalButton.destructive({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    IconData? icon,
    bool iconRight = false,
  }) {
    return BrutalButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      padding: padding,
      width: width,
      height: height,
      variant: BrutalButtonVariant.destructive,
      icon: icon,
      iconRight: iconRight,
    );
  }

  // Fábrica para botón contrastante
  factory BrutalButton.contrast({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    IconData? icon,
    bool iconRight = false,
  }) {
    return BrutalButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      padding: padding,
      width: width,
      height: height,
      variant: BrutalButtonVariant.contrast,
      icon: icon,
      iconRight: iconRight,
    );
  }

  // Fábrica para botón "roto"
  factory BrutalButton.broken({
    Key? key,
    required String text,
    required VoidCallback onPressed,
    bool isDisabled = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double? height,
    IconData? icon,
    bool iconRight = false,
  }) {
    return BrutalButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isDisabled: isDisabled,
      padding: padding,
      width: width,
      height: height,
      variant: BrutalButtonVariant.broken,
      icon: icon,
      iconRight: iconRight,
      rotation: -2.0,
    );
  }

  @override
  State<BrutalButton> createState() => _BrutalButtonState();
}

class _BrutalButtonState extends State<BrutalButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;
    final effectiveBorderStyle = widget.borderStyle ?? theme.borderStyle;

    // Determinar colores según la variante y el estado
    Color bgColor;
    Color txtColor;
    Color borderCol;

    switch (widget.variant) {
      case BrutalButtonVariant.default_:
        bgColor =
            widget.isDisabled
                ? theme.colors.surface
                : (widget.backgroundColor ?? theme.colors.primary);
        txtColor =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.background);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;
      case BrutalButtonVariant.primary:
        bgColor =
            widget.isDisabled ? theme.colors.surface : theme.colors.primary;
        txtColor =
            widget.isDisabled
                ? theme.colors.textLight
                : theme.colors.background;
        borderCol =
            widget.isDisabled ? theme.colors.textLight : theme.colors.primary;
        break;
      case BrutalButtonVariant.secondary:
        bgColor =
            widget.isDisabled ? theme.colors.surface : theme.colors.surface;
        txtColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.secondary;
        borderCol =
            widget.isDisabled ? theme.colors.textLight : theme.colors.secondary;
        break;
      case BrutalButtonVariant.destructive:
        bgColor = widget.isDisabled ? theme.colors.surface : theme.colors.error;
        txtColor =
            widget.isDisabled
                ? theme.colors.textLight
                : theme.colors.background;
        borderCol =
            widget.isDisabled ? theme.colors.textLight : theme.colors.error;
        break;
      case BrutalButtonVariant.contrast:
        bgColor =
            widget.isDisabled ? theme.colors.surface : theme.colors.background;
        txtColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        borderCol =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
      case BrutalButtonVariant.minimal:
        bgColor = BrutalConstants.transparent; // Usar la constante compartida
        txtColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        borderCol = BrutalConstants.transparent; // Usar la constante compartida
        break;
      case BrutalButtonVariant.broken:
        bgColor =
            widget.isDisabled
                ? theme.colors.surface
                : (widget.backgroundColor ?? theme.colors.primary);
        txtColor =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.background);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;
    }

    // Efecto hover
    if (_isHovered && !widget.isDisabled) {
      bgColor = bgColor.withOpacity(0.9);
    }

    // Construir el contenido del botón
    List<Widget> contentChildren = [];

    // Añadir icono a la izquierda si es necesario
    if (widget.icon != null && !widget.iconRight) {
      contentChildren.add(
        Padding(
          padding: EdgeInsets.only(right: theme.spacing / 2),
          child: Icon(widget.icon!, color: txtColor, size: 18),
        ),
      );
    }

    // Añadir texto
    contentChildren.add(
      BrutalText(
        widget.text,
        brutalStyle: BrutalTextStyle.button,
        style: TextStyle(color: txtColor),
      ),
    );

    // Añadir icono a la derecha si es necesario
    if (widget.icon != null && widget.iconRight) {
      contentChildren.add(
        Padding(
          padding: EdgeInsets.only(left: theme.spacing / 2),
          child: Icon(widget.icon!, color: txtColor, size: 18),
        ),
      );
    }

    Widget buttonContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: contentChildren,
    );

    // Construir el botón
    Widget button = MouseRegion(
      cursor:
          widget.isDisabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown:
            widget.isDisabled ? null : (_) => setState(() => _isPressed = true),
        onTapUp:
            widget.isDisabled
                ? null
                : (_) => setState(() => _isPressed = false),
        onTapCancel:
            widget.isDisabled ? null : () => setState(() => _isPressed = false),
        onTap: widget.isDisabled ? null : widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          width: widget.width,
          height: widget.height,
          padding:
              widget.padding ??
              EdgeInsets.symmetric(
                vertical: theme.spacing * 0.75,
                horizontal: theme.spacing * 1.5,
              ),
          decoration: BoxDecoration(
            color: bgColor,
            border:
                effectiveBorderStyle == BrutalBorderStyle.none
                    ? null
                    : Border.all(color: borderCol, width: effectiveBorderWidth),
            boxShadow:
                _isPressed || widget.isDisabled
                    ? null
                    : [
                      BoxShadow(
                        color: theme.colors.text.withOpacity(0.5),
                        offset: Offset(
                          effectiveBorderWidth,
                          effectiveBorderWidth,
                        ),
                        blurRadius: 0,
                      ),
                    ],
          ),
          transform:
              _isPressed && !widget.isDisabled
                  ? Matrix4.translationValues(
                    effectiveBorderWidth,
                    effectiveBorderWidth,
                    0,
                  )
                  : Matrix4.identity(),
          child: Center(child: buttonContent),
        ),
      ),
    );

    // Aplicar rotación si está especificada
    if (widget.rotation != null) {
      button = Transform.rotate(
        angle:
            widget.rotation! * 0.02, // Convertir a radianes pero mantener sutil
        child: button,
      );
    }

    return button;
  }
}

/// Variantes de botón brutalista
enum BrutalButtonVariant {
  default_, // Botón estándar
  primary, // Botón principal
  secondary, // Botón secundario
  destructive, // Botón para acciones destructivas
  contrast, // Botón con alto contraste
  minimal, // Botón minimalista sin borde
  broken, // Botón con estilo "roto"
}
