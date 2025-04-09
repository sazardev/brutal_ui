import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

class BrutalDropdownItem<T> {
  final String label;
  final T value;
  final Widget? icon;
  final String? description;

  const BrutalDropdownItem({
    required this.label,
    required this.value,
    this.icon,
    this.description,
  });
}

class BrutalDropdown<T> extends StatefulWidget {
  final List<BrutalDropdownItem<T>> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final String? label;
  final String? placeholder;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final BrutalDropdownVariant variant;
  final BrutalBorderStyle? borderStyle;
  final double? borderWidth;

  const BrutalDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
    this.label,
    this.placeholder,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.variant = BrutalDropdownVariant.default_,
    this.borderStyle,
    this.borderWidth,
  });

  @override
  State<BrutalDropdown<T>> createState() => _BrutalDropdownState<T>();
}

class _BrutalDropdownState<T> extends State<BrutalDropdown<T>> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
    }
  }

  void _toggleDropdown() {
    if (widget.isDisabled) return;

    if (_isOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final theme = BrutalTheme.of(context);
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height),
            child: Material(
              color: BrutalConstants.transparent,
              child: _buildDropdownList(theme),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isOpen = true;
    });
  }

  Widget _buildDropdownList(BrutalTheme theme) {
    final effectiveBorderStyle = widget.borderStyle ?? theme.borderStyle;
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;
    final bgColor = widget.backgroundColor ?? theme.colors.surface;
    final borderCol = widget.borderColor ?? theme.colors.border;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: bgColor,
        border:
            effectiveBorderStyle != BrutalBorderStyle.none
                ? Border.all(color: borderCol, width: effectiveBorderWidth)
                : null,
        boxShadow: [
          BoxShadow(
            color: theme.colors.text.withOpacity(0.4),
            offset: Offset(effectiveBorderWidth, effectiveBorderWidth),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children:
            widget.items.map((item) {
              final bool isSelected = widget.value == item.value;
              return GestureDetector(
                onTap: () {
                  widget.onChanged(item.value);
                  _removeOverlay();
                },
                child: Container(
                  color:
                      isSelected ? theme.colors.primary.withOpacity(0.1) : null,
                  padding: EdgeInsets.symmetric(
                    horizontal: theme.spacing,
                    vertical: theme.spacing * 0.75,
                  ),
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        item.icon!,
                        SizedBox(width: theme.spacing / 2),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            BrutalText(
                              item.label,
                              style: TextStyle(
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                color: widget.textColor ?? theme.colors.text,
                              ),
                            ),
                            if (item.description != null) ...[
                              SizedBox(height: 2),
                              BrutalText(
                                item.description!,
                                brutalStyle: BrutalTextStyle.caption,
                                style: TextStyle(color: theme.colors.textLight),
                              ),
                            ],
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          const IconData(
                            0xe876,
                            fontFamily: 'MaterialIcons',
                          ), // check mark
                          size: 16.0,
                          color: theme.colors.primary,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderStyle = widget.borderStyle ?? theme.borderStyle;
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;

    // Determinar colores y estilos según la variante
    Color bgColor;
    Color textColor;
    Color borderCol;

    switch (widget.variant) {
      case BrutalDropdownVariant.default_:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textColor =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;
      case BrutalDropdownVariant.minimal:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textColor =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.borderColor ??
            (_isOpen ? theme.colors.primary : theme.colors.border);
        break;
      case BrutalDropdownVariant.broken:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textColor =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;
    }

    // Encontrar el elemento seleccionado
    BrutalDropdownItem<T>? selectedItem;
    if (widget.value != null) {
      for (var item in widget.items) {
        if (item.value == widget.value) {
          selectedItem = item;
          break;
        }
      }
    }

    // Construir el dropdown button
    Widget content = Row(
      children: [
        Expanded(
          child:
              selectedItem != null
                  ? Row(
                    children: [
                      if (selectedItem.icon != null) ...[
                        selectedItem.icon!,
                        SizedBox(width: theme.spacing / 2),
                      ],
                      Expanded(
                        child: BrutalText(
                          selectedItem.label,
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ],
                  )
                  : BrutalText(
                    widget.placeholder ?? 'Selecciona una opción',
                    style: TextStyle(color: theme.colors.textLight),
                  ),
        ),
        SizedBox(width: theme.spacing / 2),
        Icon(
          _isOpen
              ? const IconData(
                0xe5cf,
                fontFamily: 'MaterialIcons',
              ) // arrow_drop_up
              : const IconData(
                0xe5c5,
                fontFamily: 'MaterialIcons',
              ), // arrow_drop_down
          size: 24.0,
          color: textColor,
        ),
      ],
    );

    Widget dropdown = CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleDropdown,
        child: MouseRegion(
          cursor:
              widget.isDisabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          child: Container(
            padding:
                widget.padding ??
                EdgeInsets.symmetric(
                  horizontal: theme.spacing,
                  vertical: theme.spacing * 0.75,
                ),
            decoration: BoxDecoration(
              color: bgColor,
              border:
                  effectiveBorderStyle != BrutalBorderStyle.none
                      ? Border.all(
                        color: borderCol,
                        width: effectiveBorderWidth,
                      )
                      : null,
              boxShadow:
                  (widget.variant == BrutalDropdownVariant.broken &&
                          !widget.isDisabled)
                      ? [
                        BoxShadow(
                          color: borderCol.withOpacity(0.4),
                          offset: Offset(1.5, 1.5),
                          blurRadius: 0,
                        ),
                      ]
                      : null,
            ),
            child: content,
          ),
        ),
      ),
    );

    // Aplicar rotación para efecto brutalist
    if (widget.variant == BrutalDropdownVariant.broken) {
      dropdown = Transform.rotate(angle: 0.015, child: dropdown);
    }

    // Añadir etiqueta si existe
    if (widget.label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BrutalText(
            widget.label!,
            brutalStyle: BrutalTextStyle.caption,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isDisabled ? theme.colors.textLight : null,
            ),
          ),
          SizedBox(height: theme.spacing / 2),
          dropdown,
        ],
      );
    }

    return dropdown;
  }
}

enum BrutalDropdownVariant {
  default_, // Dropdown estándar
  minimal, // Dropdown con estilo minimalista
  broken, // Dropdown con efecto "roto"
}
