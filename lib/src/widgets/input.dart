import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart'; // Importar las constantes compartidas
import 'text.dart';

/// Un campo de entrada con el estilo de Brutal UI.
class BrutalInput extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool isDisabled;
  final String? errorText;
  final String? helperText;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final BrutalInputVariant variant;
  final BrutalBorderStyle? borderStyle;
  final double? borderWidth;
  final bool autofocus;

  const BrutalInput({
    super.key,
    this.label,
    this.placeholder,
    this.controller,
    this.focusNode,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.isDisabled = false,
    this.errorText,
    this.helperText,
    this.inputFormatters,
    this.maxLines = 1,
    this.maxLength,
    this.suffix,
    this.prefix,
    this.variant = BrutalInputVariant.default_,
    this.borderStyle,
    this.borderWidth,
    this.autofocus = false,
  });

  // Fábrica para input de búsqueda
  factory BrutalInput.search({
    Key? key,
    String? placeholder,
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool isDisabled = false,
    Widget? suffix,
    bool autofocus = false,
  }) {
    return BrutalInput(
      key: key,
      placeholder: placeholder ?? 'Buscar...',
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      isDisabled: isDisabled,
      suffix: suffix,
      variant: BrutalInputVariant.search,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.search,
      // Icono de búsqueda como prefijo
      prefix: const Icon(
        IconData(0xe8b6, fontFamily: 'MaterialIcons'),
      ), // Icono de búsqueda
      autofocus: autofocus,
    );
  }

  // Fábrica para input de código
  factory BrutalInput.code({
    Key? key,
    String? label,
    TextEditingController? controller,
    FocusNode? focusNode,
    ValueChanged<String>? onChanged,
    ValueChanged<String>? onSubmitted,
    bool isDisabled = false,
    int? maxLines,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return BrutalInput(
      key: key,
      label: label,
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      isDisabled: isDisabled,
      variant: BrutalInputVariant.code,
      maxLines: maxLines ?? 3,
      inputFormatters: inputFormatters,
    );
  }

  @override
  State<BrutalInput> createState() => _BrutalInputState();
}

class _BrutalInputState extends State<BrutalInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.autofocus) {
      _focusNode.requestFocus();
    }

    // Escuchar cambios de foco
    _focusNode.addListener(_onFocusChange);

    // Escuchar cambios en el controlador para asegurar que onChanged se llame
    _controller.addListener(_onTextChanged);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(BrutalInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != null && widget.controller != _controller) {
      _controller.removeListener(_onTextChanged);
      _controller = widget.controller!;
      _controller.addListener(_onTextChanged);
    }

    if (widget.focusNode != null && widget.focusNode != _focusNode) {
      _focusNode.removeListener(_onFocusChange);
      _focusNode = widget.focusNode!;
      _focusNode.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);

    if (widget.controller == null) {
      // Solo eliminamos el controlador si lo creamos internamente
      _controller.dispose();
    } else {
      // De lo contrario, solo quitamos el listener
      _controller.removeListener(_onTextChanged);
    }

    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.onChanged != null) {
      widget.onChanged!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    final effectiveBorderStyle = widget.borderStyle ?? theme.borderStyle;
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;

    // Determinar colores según el estado y variante
    Color borderColor;
    Color backgroundColor;
    Color textColor;

    switch (widget.variant) {
      case BrutalInputVariant.default_:
        borderColor =
            hasError
                ? theme.colors.error
                : _isFocused
                ? theme.colors.primary
                : theme.colors.border;
        backgroundColor = theme.colors.surface;
        textColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
      case BrutalInputVariant.filled:
        borderColor =
            hasError
                ? theme.colors.error
                : _isFocused
                ? theme.colors.primary
                : theme.colors.border;
        backgroundColor = theme.colors.surface.withOpacity(0.8);
        textColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
      case BrutalInputVariant.minimal:
        borderColor =
            hasError
                ? theme.colors.error
                : _isFocused
                ? theme.colors.primary
                : BrutalConstants.transparent; // Usar la constante compartida
        backgroundColor =
            _isFocused
                ? theme.colors.surface
                : BrutalConstants.transparent; // Usar la constante compartida
        textColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
      case BrutalInputVariant.search:
        borderColor =
            hasError
                ? theme.colors.error
                : _isFocused
                ? theme.colors.primary
                : theme.colors.border;
        backgroundColor = theme.colors.surface;
        textColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
      case BrutalInputVariant.code:
        borderColor =
            hasError
                ? theme.colors.error
                : _isFocused
                ? theme.colors.primary
                : theme.colors.border;
        backgroundColor = theme.colors.background;
        textColor =
            widget.isDisabled ? theme.colors.textLight : theme.colors.text;
        break;
    }

    // Estilos específicos para el código
    TextStyle textStyle = theme.typography.body.copyWith(color: textColor);

    if (widget.variant == BrutalInputVariant.code) {
      textStyle = theme.typography.monospace.copyWith(color: textColor);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          BrutalText(
            widget.label!,
            brutalStyle: BrutalTextStyle.caption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: hasError ? theme.colors.error : null,
            ),
          ),
          SizedBox(height: theme.spacing / 2),
        ],
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          decoration: BoxDecoration(
            color: backgroundColor,
            border:
                effectiveBorderStyle == BrutalBorderStyle.none
                    ? null
                    : Border.all(
                      color: borderColor,
                      width: effectiveBorderWidth,
                    ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacing,
            vertical: theme.spacing * 0.75,
          ),
          child: Row(
            children: [
              if (widget.prefix != null) ...[
                widget.prefix!,
                SizedBox(width: theme.spacing / 2),
              ],
              Expanded(
                child: EditableText(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: textStyle,
                  cursorColor: theme.colors.primary,
                  backgroundCursorColor:
                      BrutalConstants
                          .transparent, // Usar la constante compartida
                  selectionColor: theme.colors.primary.withOpacity(0.3),
                  keyboardType: widget.keyboardType,
                  textInputAction: widget.textInputAction,
                  onSubmitted: widget.onSubmitted,
                  readOnly: widget.isDisabled,
                  obscureText: widget.obscureText,
                  inputFormatters: widget.inputFormatters,
                  maxLines: widget.maxLines,
                  contextMenuBuilder: (context, editableTextState) {
                    // Aquí idealmente usarías un menu contextual personalizado
                    return Container();
                  },
                ),
              ),
              if (widget.suffix != null) ...[
                SizedBox(width: theme.spacing / 2),
                widget.suffix!,
              ],
            ],
          ),
        ),
        if (hasError) ...[
          SizedBox(height: theme.spacing / 2),
          BrutalText(
            widget.errorText!,
            brutalStyle: BrutalTextStyle.caption,
            style: TextStyle(color: theme.colors.error),
          ),
        ] else if (widget.helperText != null) ...[
          SizedBox(height: theme.spacing / 2),
          BrutalText(
            widget.helperText!,
            brutalStyle: BrutalTextStyle.caption,
            style: TextStyle(color: theme.colors.textLight),
          ),
        ],
      ],
    );
  }
}

/// Variantes de input brutalista
enum BrutalInputVariant {
  default_, // Input estándar
  filled, // Input con fondo
  minimal, // Input minimalista
  search, // Input para búsquedas
  code, // Input para código
}
