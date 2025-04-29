import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';
import 'button.dart';

/// Un selector de fechas con estética brutalista.
class BrutalDatePicker extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? label;
  final String? placeholder;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? selectedDateColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BrutalDatePickerVariant variant;
  final BrutalBorderStyle? borderStyle;
  final bool isGlitched;
  final bool hasBorder;

  const BrutalDatePicker({
    super.key,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.onDateSelected,
    this.label,
    this.placeholder = 'Select date',
    this.isDisabled = false,
    this.backgroundColor,
    this.selectedDateColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.variant = BrutalDatePickerVariant.default_,
    this.borderStyle,
    this.isGlitched = false,
    this.hasBorder = true,
  });

  /// Constructor para selector de fecha minimalista
  factory BrutalDatePicker.minimal({
    Key? key,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required ValueChanged<DateTime> onDateSelected,
    String? label,
    String? placeholder,
    bool isDisabled = false,
  }) {
    return BrutalDatePicker(
      key: key,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
      label: label,
      placeholder: placeholder,
      isDisabled: isDisabled,
      variant: BrutalDatePickerVariant.minimal,
      hasBorder: false,
    );
  }

  /// Constructor para selector de fecha con efecto "roto"
  factory BrutalDatePicker.broken({
    Key? key,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required ValueChanged<DateTime> onDateSelected,
    String? label,
    String? placeholder,
    bool isDisabled = false,
  }) {
    return BrutalDatePicker(
      key: key,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
      label: label,
      placeholder: placeholder,
      isDisabled: isDisabled,
      variant: BrutalDatePickerVariant.broken,
      isGlitched: true,
    );
  }

  /// Constructor para selector de fecha compacto
  factory BrutalDatePicker.compact({
    Key? key,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    required ValueChanged<DateTime> onDateSelected,
    String? label,
    String? placeholder,
    bool isDisabled = false,
  }) {
    return BrutalDatePicker(
      key: key,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onDateSelected: onDateSelected,
      label: label,
      placeholder: placeholder,
      isDisabled: isDisabled,
      variant: BrutalDatePickerVariant.compact,
    );
  }

  @override
  State<BrutalDatePicker> createState() => _BrutalDatePickerState();
}

class _BrutalDatePickerState extends State<BrutalDatePicker> {
  DateTime? _selectedDate;
  bool _isCalendarVisible = false;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  // Valores por defecto si no se especifican
  late final DateTime _effectiveFirstDate;
  late final DateTime _effectiveLastDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;

    // Configurar fecha mínima y máxima
    _effectiveFirstDate = widget.firstDate ?? DateTime(1900);
    _effectiveLastDate = widget.lastDate ?? DateTime(2100);
  }

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
        _isCalendarVisible = false;
      });
    }
  }

  void _toggleCalendar() {
    if (widget.isDisabled) return;

    if (_isCalendarVisible) {
      _removeOverlay();
    } else {
      _showCalendarOverlay();
    }
  }

  void _showCalendarOverlay() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: math.max(size.width * 1.5, 280),
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height + 4),
            child: _buildCalendar(),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _isCalendarVisible = true;
    });
  }

  Widget _buildCalendar() {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = widget.borderColor ?? theme.colors.border;
    final bgColor = widget.backgroundColor ?? theme.colors.surface;
    final selectedColor = widget.selectedDateColor ?? theme.colors.primary;
    final textCol = widget.textColor ?? theme.colors.text;

    // Determinar el mes actual y año para mostrar
    DateTime displayMonth = _selectedDate ?? DateTime.now();

    // Aplicar ligera rotación para efecto brutalista si es necesario
    double rotation = 0.0;
    if (widget.variant == BrutalDatePickerVariant.broken) {
      rotation = 0.01;
    }

    Widget calendar = Material(
      color: BrutalConstants.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          border:
              widget.hasBorder
                  ? Border.all(
                    color: effectiveBorderColor,
                    width: effectiveBorderWidth,
                  )
                  : null,
          boxShadow: [
            BoxShadow(
              color: theme.colors.border.withOpacity(0.4),
              offset: Offset(4, 4),
              blurRadius: 0,
            ),
          ],
        ),
        padding: EdgeInsets.all(
          widget.variant == BrutalDatePickerVariant.compact ? 8.0 : 12.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Encabezado con navegación de mes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón para mes anterior
                BrutalButton(
                  text: '<',
                  onPressed: () {
                    setState(() {
                      displayMonth = DateTime(
                        displayMonth.year,
                        displayMonth.month - 1,
                      );
                      _showCalendarOverlay(); // Refresh overlay
                    });
                  },
                  variant: BrutalButtonVariant.minimal,
                ),

                // Título del mes y año
                BrutalText(
                  '${_getMonthName(displayMonth.month)} ${displayMonth.year}',
                  brutalStyle: BrutalTextStyle.caption,
                  style: TextStyle(fontWeight: FontWeight.bold, color: textCol),
                  isGlitched: widget.isGlitched,
                ),

                // Botón para mes siguiente
                BrutalButton(
                  text: '>',
                  onPressed: () {
                    setState(() {
                      displayMonth = DateTime(
                        displayMonth.year,
                        displayMonth.month + 1,
                      );
                      _showCalendarOverlay(); // Refresh overlay
                    });
                  },
                  variant: BrutalButtonVariant.minimal,
                ),
              ],
            ),

            SizedBox(height: theme.spacing / 2),

            // Días de la semana
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  ['M', 'T', 'W', 'T', 'F', 'S', 'S'].map((day) {
                    return SizedBox(
                      width: 30,
                      height: 30,
                      child: Center(
                        child: BrutalText(
                          day,
                          brutalStyle: BrutalTextStyle.caption,
                          style: TextStyle(color: textCol.withOpacity(0.7)),
                        ),
                      ),
                    );
                  }).toList(),
            ),

            SizedBox(height: theme.spacing / 4),

            // Días del mes
            ..._buildCalendarDays(displayMonth, selectedColor, textCol),

            SizedBox(height: theme.spacing),

            // Botones de acciones
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (_selectedDate != null)
                  BrutalButton(
                    text: 'Clear',
                    onPressed: () {
                      setState(() {
                        _selectedDate = null;
                      });
                      _removeOverlay();
                    },
                    variant: BrutalButtonVariant.minimal,
                  ),

                BrutalButton(
                  text: 'Today',
                  onPressed: () {
                    _selectDate(DateTime.now());
                  },
                  variant: BrutalButtonVariant.secondary,
                ),

                SizedBox(width: theme.spacing / 2),

                BrutalButton(
                  text: 'Close',
                  onPressed: () {
                    _removeOverlay();
                  },
                  variant: BrutalButtonVariant.primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Aplicar rotación si corresponde
    if (rotation != 0) {
      calendar = Transform.rotate(angle: rotation, child: calendar);
    }

    // Aplicar efecto glitch si corresponde
    if (widget.isGlitched) {
      calendar = Stack(
        children: [
          Positioned(
            left: 2,
            top: 0,
            right: -2,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: calendar,
              ),
            ),
          ),
          Positioned(
            left: -2,
            top: 0,
            right: 2,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: calendar,
              ),
            ),
          ),
          calendar,
        ],
      );
    }

    return calendar;
  }

  List<Widget> _buildCalendarDays(
    DateTime displayMonth,
    Color selectedColor,
    Color textCol,
  ) {
    final firstDayOfMonth = DateTime(displayMonth.year, displayMonth.month, 1);

    // Ajustar para que la semana comience en lunes (lunes=1, domingo=7)
    int firstWeekday = firstDayOfMonth.weekday;

    // Número de días en el mes
    final daysInMonth =
        DateTime(displayMonth.year, displayMonth.month + 1, 0).day;

    List<Widget> rows = [];
    List<Widget> currentRow = [];

    // Días vacíos antes del primer día del mes
    for (int i = 1; i < firstWeekday; i++) {
      currentRow.add(SizedBox(width: 30, height: 30));
    }

    // Construir los días del mes
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(displayMonth.year, displayMonth.month, day);
      final isSelected =
          _selectedDate != null &&
          _selectedDate!.year == date.year &&
          _selectedDate!.month == date.month &&
          _selectedDate!.day == date.day;

      final isDisabled =
          date.isBefore(_effectiveFirstDate) ||
          date.isAfter(_effectiveLastDate);

      currentRow.add(
        _buildDayButton(
          day,
          isSelected,
          isDisabled,
          selectedColor,
          textCol,
          date,
        ),
      );

      // Si llegamos al final de la semana o al final del mes, añadir la fila
      if ((firstWeekday + day - 1) % 7 == 0 || day == daysInMonth) {
        // Si es la última fila y no está completa, añadir espacios vacíos
        while (currentRow.length < 7) {
          currentRow.add(SizedBox(width: 30, height: 30));
        }

        rows.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: currentRow,
          ),
        );

        currentRow = [];
      }
    }

    // Añadir espacio entre filas
    List<Widget> result = [];
    for (int i = 0; i < rows.length; i++) {
      result.add(rows[i]);
      if (i < rows.length - 1) {
        result.add(SizedBox(height: 4));
      }
    }

    return result;
  }

  Widget _buildDayButton(
    int day,
    bool isSelected,
    bool isDisabled,
    Color selectedColor,
    Color textCol,
    DateTime date,
  ) {
    final theme = BrutalTheme.of(context);

    // Determinar estilos específicos según la variante
    BoxDecoration decoration;
    TextStyle textStyle;

    if (isSelected) {
      decoration = BoxDecoration(
        color: selectedColor,
        border:
            widget.variant != BrutalDatePickerVariant.minimal
                ? Border.all(color: widget.borderColor ?? theme.colors.border)
                : null,
      );
      textStyle = TextStyle(
        color: theme.colors.background,
        fontWeight: FontWeight.bold,
      );
    } else {
      decoration = BoxDecoration(
        color: BrutalConstants.transparent,
        border:
            widget.variant == BrutalDatePickerVariant.broken && !isDisabled
                ? Border.all(
                  color:
                      widget.borderColor ??
                      theme.colors.border.withOpacity(0.3),
                )
                : null,
      );
      textStyle = TextStyle(
        color: isDisabled ? textCol.withOpacity(0.3) : textCol,
      );
    }

    return GestureDetector(
      onTap: isDisabled ? null : () => _selectDate(date),
      child: Container(
        width: 30,
        height: 30,
        decoration: decoration,
        child: Center(
          child: BrutalText(
            day.toString(),
            brutalStyle: BrutalTextStyle.caption,
            style: textStyle,
            isGlitched: widget.isGlitched && isSelected,
          ),
        ),
      ),
    );
  }

  void _selectDate(DateTime date) {
    if (date.isBefore(_effectiveFirstDate) ||
        date.isAfter(_effectiveLastDate)) {
      return;
    }

    setState(() {
      _selectedDate = date;
    });

    widget.onDateSelected(date);
    _removeOverlay();
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;
    final effectiveBorderStyle = widget.borderStyle ?? theme.borderStyle;

    // Determinar colores según la variante y estado
    Color bgColor;
    Color textCol;
    Color borderCol;

    switch (widget.variant) {
      case BrutalDatePickerVariant.default_:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;

      case BrutalDatePickerVariant.minimal:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.borderColor ??
            (_isCalendarVisible ? theme.colors.primary : theme.colors.border);
        break;

      case BrutalDatePickerVariant.broken:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;

      case BrutalDatePickerVariant.compact:
        bgColor = widget.backgroundColor ?? theme.colors.surface;
        textCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.textColor ?? theme.colors.text);
        borderCol =
            widget.isDisabled
                ? theme.colors.textLight
                : (widget.borderColor ?? theme.colors.border);
        break;
    }

    // Contenido principal (etiqueta de fecha)
    final String displayText =
        _selectedDate != null
            ? _formatDate(_selectedDate!)
            : widget.placeholder!;

    Widget datePicker = CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggleCalendar,
        child: MouseRegion(
          cursor:
              widget.isDisabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.symmetric(
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
                  widget.variant == BrutalDatePickerVariant.broken &&
                          !widget.isDisabled
                      ? [
                        BoxShadow(
                          color: borderCol.withOpacity(0.4),
                          offset: const Offset(1.5, 1.5),
                          blurRadius: 0,
                        ),
                      ]
                      : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: BrutalText(
                    displayText,
                    style: TextStyle(color: textCol),
                    isGlitched: widget.isGlitched && _selectedDate != null,
                  ),
                ),
                SizedBox(width: theme.spacing / 2),
                Icon(
                  const IconData(
                    0xe878,
                    fontFamily: 'MaterialIcons',
                  ), // calendar icon
                  size: 18.0,
                  color: textCol,
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Aplicar rotación para efecto brutalist
    if (widget.variant == BrutalDatePickerVariant.broken) {
      datePicker = Transform.rotate(angle: 0.01, child: datePicker);
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
          datePicker,
        ],
      );
    }

    return datePicker;
  }
}

/// Variantes de selector de fecha brutalista
enum BrutalDatePickerVariant {
  default_, // Selector de fecha estándar
  minimal, // Selector de fecha con estilo minimalista
  broken, // Selector de fecha con efecto "roto"
  compact, // Selector de fecha más compacto
}
