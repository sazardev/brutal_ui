import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import 'text.dart';
import 'button.dart';

class BrutalAlert extends StatelessWidget {
  final String? title;
  final String message;
  final Widget? icon;
  final BrutalAlertVariant variant;
  final VoidCallback? onClose;
  final List<BrutalAlertAction>? actions;
  final EdgeInsetsGeometry? padding;
  final bool hasBorder;
  final bool isDismissible;
  final bool isGlitched;

  const BrutalAlert({
    super.key,
    this.title,
    required this.message,
    this.icon,
    this.variant = BrutalAlertVariant.info,
    this.onClose,
    this.actions,
    this.padding,
    this.hasBorder = true,
    this.isDismissible = true,
    this.isGlitched = false,
  });

  // Fábrica para alerta de éxito
  factory BrutalAlert.success({
    Key? key,
    String? title,
    required String message,
    Widget? icon,
    VoidCallback? onClose,
    List<BrutalAlertAction>? actions,
    EdgeInsetsGeometry? padding,
    bool hasBorder = true,
    bool isDismissible = true,
  }) {
    return BrutalAlert(
      key: key,
      title: title,
      message: message,
      icon: icon,
      variant: BrutalAlertVariant.success,
      onClose: onClose,
      actions: actions,
      padding: padding,
      hasBorder: hasBorder,
      isDismissible: isDismissible,
    );
  }

  // Fábrica para alerta de error
  factory BrutalAlert.error({
    Key? key,
    String? title,
    required String message,
    Widget? icon,
    VoidCallback? onClose,
    List<BrutalAlertAction>? actions,
    EdgeInsetsGeometry? padding,
    bool hasBorder = true,
    bool isDismissible = true,
  }) {
    return BrutalAlert(
      key: key,
      title: title,
      message: message,
      icon: icon,
      variant: BrutalAlertVariant.error,
      onClose: onClose,
      actions: actions,
      padding: padding,
      hasBorder: hasBorder,
      isDismissible: isDismissible,
      isGlitched: true,
    );
  }

  // Fábrica para alerta de advertencia
  factory BrutalAlert.warning({
    Key? key,
    String? title,
    required String message,
    Widget? icon,
    VoidCallback? onClose,
    List<BrutalAlertAction>? actions,
    EdgeInsetsGeometry? padding,
    bool hasBorder = true,
    bool isDismissible = true,
  }) {
    return BrutalAlert(
      key: key,
      title: title,
      message: message,
      icon: icon,
      variant: BrutalAlertVariant.warning,
      onClose: onClose,
      actions: actions,
      padding: padding,
      hasBorder: hasBorder,
      isDismissible: isDismissible,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determinar colores según la variante
    Color bgColor;
    Color borderColor;

    switch (variant) {
      case BrutalAlertVariant.info:
        bgColor = theme.colors.primary.withOpacity(0.1);
        borderColor = theme.colors.primary;
        break;
      case BrutalAlertVariant.success:
        bgColor = theme.colors.success.withOpacity(0.1);
        borderColor = theme.colors.success;
        break;
      case BrutalAlertVariant.error:
        bgColor = theme.colors.error.withOpacity(0.1);
        borderColor = theme.colors.error;
        break;
      case BrutalAlertVariant.warning:
        bgColor = theme.colors.accent.withOpacity(0.1);
        borderColor = theme.colors.accent;
        break;
    }

    // Construir el contenido de la alerta
    List<Widget> contentChildren = [];

    // Título si existe
    if (title != null) {
      contentChildren.add(
        Row(
          children: [
            if (icon != null) ...[icon!, SizedBox(width: theme.spacing)],
            Expanded(
              child: BrutalText.heading3(title!, isGlitched: isGlitched),
            ),
            if (isDismissible && onClose != null)
              GestureDetector(
                onTap: onClose,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Text('✕'),
                ),
              ),
          ],
        ),
      );
      contentChildren.add(SizedBox(height: theme.spacing));
    }

    // Mensaje
    contentChildren.add(
      BrutalText(
        message,
        isGlitched: isGlitched && variant == BrutalAlertVariant.error,
      ),
    );

    // Acciones si existen
    if (actions != null && actions!.isNotEmpty) {
      contentChildren.add(SizedBox(height: theme.spacing));

      contentChildren.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children:
              actions!.map((action) {
                return Padding(
                  padding: EdgeInsets.only(left: theme.spacing / 2),
                  child: BrutalButton(
                    text: action.label,
                    onPressed: action.onPressed,
                    variant:
                        action.isPrimary
                            ? BrutalButtonVariant.primary
                            : BrutalButtonVariant.default_,
                  ),
                );
              }).toList(),
        ),
      );
    }

    Widget alert = Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(theme.spacing),
      decoration: BoxDecoration(
        color: bgColor,
        border:
            hasBorder
                ? Border.all(color: borderColor, width: theme.borderWidth)
                : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: contentChildren,
      ),
    );

    // Aplicar efecto glitcheado para alertas de error
    if (isGlitched) {
      alert = Transform.translate(offset: const Offset(1, 0), child: alert);
    }

    return alert;
  }
}

class BrutalAlertAction {
  final String label;
  final VoidCallback onPressed;
  final bool isPrimary;

  const BrutalAlertAction({
    required this.label,
    required this.onPressed,
    this.isPrimary = false,
  });
}

enum BrutalAlertVariant {
  info, // Alerta informativa
  success, // Alerta de éxito
  error, // Alerta de error
  warning, // Alerta de advertencia
}
