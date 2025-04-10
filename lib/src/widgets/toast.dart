import 'package:flutter/widgets.dart';
import 'dart:async';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

/// Un mensaje toast con estilo brutalista.
class BrutalToast extends StatefulWidget {
  final String message;
  final Widget? icon;
  final Duration duration;
  final BrutalToastVariant variant;
  final VoidCallback? onDismiss;
  final bool isVisible;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final bool hasBorder;

  const BrutalToast({
    super.key,
    required this.message,
    this.icon,
    this.duration = const Duration(seconds: 3),
    this.variant = BrutalToastVariant.default_,
    this.onDismiss,
    this.isVisible = true,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.hasBorder = true,
  });

  // Fábrica para toast de éxito
  factory BrutalToast.success({
    Key? key,
    required String message,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool isVisible = true,
  }) {
    return BrutalToast(
      key: key,
      message: message,
      icon:
          icon ??
          const Icon(
            IconData(0xe876, fontFamily: 'MaterialIcons'),
          ), // check icon
      duration: duration,
      variant: BrutalToastVariant.success,
      onDismiss: onDismiss,
      isVisible: isVisible,
    );
  }

  // Fábrica para toast de error
  factory BrutalToast.error({
    Key? key,
    required String message,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool isVisible = true,
  }) {
    return BrutalToast(
      key: key,
      message: message,
      icon:
          icon ??
          const Icon(
            IconData(0xe237, fontFamily: 'MaterialIcons'),
          ), // error icon
      duration: duration,
      variant: BrutalToastVariant.error,
      onDismiss: onDismiss,
      isVisible: isVisible,
    );
  }

  // Fábrica para toast de advertencia
  factory BrutalToast.warning({
    Key? key,
    required String message,
    Widget? icon,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onDismiss,
    bool isVisible = true,
  }) {
    return BrutalToast(
      key: key,
      message: message,
      icon:
          icon ??
          const Icon(
            IconData(0xe002, fontFamily: 'MaterialIcons'),
          ), // warning icon
      duration: duration,
      variant: BrutalToastVariant.warning,
      onDismiss: onDismiss,
      isVisible: isVisible,
    );
  }

  @override
  State<BrutalToast> createState() => _BrutalToastState();
}

class _BrutalToastState extends State<BrutalToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Configurar animación para entrada/salida
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    if (widget.isVisible) {
      _show();
    }
  }

  @override
  void didUpdateWidget(BrutalToast oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _show();
      } else {
        _hide();
      }
    }
  }

  void _show() {
    _controller.forward();
    _startTimer();
  }

  void _hide() {
    _timer?.cancel();
    _controller.reverse().then((_) {
      if (widget.onDismiss != null) {
        widget.onDismiss!();
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.duration, _hide);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Configurar colores basados en la variante
    Color bgColor;
    Color txtColor;
    Color borderCol;

    switch (widget.variant) {
      case BrutalToastVariant.default_:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        txtColor = widget.textColor ?? theme.colors.text;
        borderCol = widget.borderColor ?? theme.colors.border;
        break;
      case BrutalToastVariant.success:
        bgColor =
            widget.backgroundColor ?? theme.colors.success.withOpacity(0.1);
        txtColor = widget.textColor ?? theme.colors.success;
        borderCol = widget.borderColor ?? theme.colors.success;
        break;
      case BrutalToastVariant.error:
        bgColor = widget.backgroundColor ?? theme.colors.error.withOpacity(0.1);
        txtColor = widget.textColor ?? theme.colors.error;
        borderCol = widget.borderColor ?? theme.colors.error;
        break;
      case BrutalToastVariant.warning:
        bgColor =
            widget.backgroundColor ?? theme.colors.accent.withOpacity(0.1);
        txtColor = widget.textColor ?? theme.colors.accent;
        borderCol = widget.borderColor ?? theme.colors.accent;
        break;
      case BrutalToastVariant.glitch:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        txtColor = widget.textColor ?? theme.colors.text;
        borderCol = widget.borderColor ?? theme.colors.border;
        break;
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, (1 - _animation.value) * -20),
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: _hide,
        child: Container(
          padding: widget.padding ?? EdgeInsets.all(theme.spacing),
          decoration: BoxDecoration(
            color: bgColor,
            border:
                widget.hasBorder
                    ? Border.all(color: borderCol, width: theme.borderWidth)
                    : null,
            boxShadow:
                widget.variant == BrutalToastVariant.glitch
                    ? [
                      BoxShadow(
                        color: borderCol.withOpacity(0.4),
                        offset: const Offset(2, 2),
                        blurRadius: 0,
                      ),
                      BoxShadow(
                        color: BrutalConstants.red.withOpacity(0.3),
                        offset: const Offset(-1, 1),
                        blurRadius: 0,
                      ),
                    ]
                    : [
                      BoxShadow(
                        color: borderCol.withOpacity(0.3),
                        offset: const Offset(2, 2),
                        blurRadius: 0,
                      ),
                    ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(txtColor, BlendMode.srcIn),
                  child: widget.icon!,
                ),
                SizedBox(width: theme.spacing / 2),
              ],
              Flexible(
                child:
                    widget.variant == BrutalToastVariant.glitch
                        ? BrutalText(
                          widget.message,
                          isGlitched: true,
                          style: TextStyle(color: txtColor),
                        )
                        : BrutalText(
                          widget.message,
                          style: TextStyle(color: txtColor),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Un overlay que muestra toasts en la aplicación
class BrutalToastOverlay extends StatefulWidget {
  final Widget child;

  const BrutalToastOverlay({super.key, required this.child});

  // Acceso global al estado del overlay
  static _BrutalToastOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<_BrutalToastOverlayState>();
  }

  @override
  State<BrutalToastOverlay> createState() => _BrutalToastOverlayState();
}

class _BrutalToastOverlayState extends State<BrutalToastOverlay> {
  final List<Widget> _toasts = [];

  void showToast(BrutalToast toast) {
    setState(() {
      _toasts.add(
        _ToastWidget(
          key: UniqueKey(),
          toast: toast,
          onDismissed: () {
            _removeToast(toast);
          },
        ),
      );
    });
  }

  void _removeToast(BrutalToast toast) {
    setState(() {
      _toasts.removeWhere(
        (Widget current) => current is _ToastWidget && current.toast == toast,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_toasts.isNotEmpty)
          Positioned(
            top: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:
                  _toasts
                      .map(
                        (toast) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: toast,
                        ),
                      )
                      .toList(),
            ),
          ),
      ],
    );
  }
}

class _ToastWidget extends StatelessWidget {
  final BrutalToast toast;
  final VoidCallback onDismissed;

  const _ToastWidget({
    super.key,
    required this.toast,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalToast(
      message: toast.message,
      icon: toast.icon,
      duration: toast.duration,
      variant: toast.variant,
      onDismiss: onDismissed,
      padding: toast.padding,
      backgroundColor: toast.backgroundColor,
      textColor: toast.textColor,
      borderColor: toast.borderColor,
      hasBorder: toast.hasBorder,
    );
  }
}

enum BrutalToastVariant {
  default_, // Toast estándar
  success, // Toast para mensajes de éxito
  error, // Toast para mensajes de error
  warning, // Toast para advertencias
  glitch, // Toast con efecto glitch
}

// Clase de utilidad para mostrar toasts
class BrutalToasts {
  static void show(
    BuildContext context,
    String message, {
    BrutalToastVariant variant = BrutalToastVariant.default_,
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
  }) {
    BrutalToastOverlay.of(context)?.showToast(
      BrutalToast(
        message: message,
        variant: variant,
        duration: duration,
        icon: icon,
      ),
    );
  }

  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
  }) {
    show(
      context,
      message,
      variant: BrutalToastVariant.success,
      duration: duration,
      icon: icon ?? const Icon(IconData(0xe876, fontFamily: 'MaterialIcons')),
    );
  }

  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
  }) {
    show(
      context,
      message,
      variant: BrutalToastVariant.error,
      duration: duration,
      icon: icon ?? const Icon(IconData(0xe237, fontFamily: 'MaterialIcons')),
    );
  }

  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
    Widget? icon,
  }) {
    show(
      context,
      message,
      variant: BrutalToastVariant.warning,
      duration: duration,
      icon: icon ?? const Icon(IconData(0xe002, fontFamily: 'MaterialIcons')),
    );
  }
}
