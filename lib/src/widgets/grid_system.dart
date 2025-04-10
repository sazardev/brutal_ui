import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';

/// Un sistema de grid altamente configurable y responsivo para Brutal UI
class BrutalGridSystem extends StatelessWidget {
  final List<BrutalGridItem> children;
  final int columns;
  final double spacing;
  final double runSpacing;
  final bool hasBorder;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool isBroken;
  final bool isGlitched;
  final Alignment alignment;
  final BrutalBreakpointGridConfig? breakpointConfig;

  const BrutalGridSystem({
    super.key,
    required this.children,
    this.columns = 12,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.hasBorder = false,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.isBroken = false,
    this.isGlitched = false,
    this.alignment = Alignment.topLeft,
    this.breakpointConfig,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final mediaQuerySize = MediaQuery.of(context).size;
    final effectiveSpacing = spacing;
    final effectiveRunSpacing = runSpacing;
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.surface;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Determinar el número efectivo de columnas en función del ancho de pantalla
    // si se proporcionó configuración de breakpoints
    int effectiveColumns = columns;
    if (breakpointConfig != null) {
      if (mediaQuerySize.width <= breakpointConfig!.mobileBreakpoint) {
        effectiveColumns = breakpointConfig!.mobileColumns;
      } else if (mediaQuerySize.width <= breakpointConfig!.tabletBreakpoint) {
        effectiveColumns = breakpointConfig!.tabletColumns;
      } else {
        effectiveColumns = breakpointConfig!.desktopColumns;
      }
    }

    // Crear las filas del grid
    final List<Widget> rows = [];
    final List<List<BrutalGridItem>> gridRows = _createGridRows(
      children,
      effectiveColumns,
    );

    for (final rowItems in gridRows) {
      final List<Widget> rowWidgets = [];

      for (final gridItem in rowItems) {
        final int itemSpan = _getResponsiveSpan(
          context,
          gridItem,
          effectiveColumns,
        );

        // Calcular el ancho del item en función de su span
        final double itemWidth =
            mediaQuerySize.width / effectiveColumns * itemSpan;

        rowWidgets.add(
          SizedBox(
            width: itemWidth - effectiveSpacing * 2,
            child: _applyBrutalEffects(
              gridItem.child,
              isBroken: isBroken && gridItem.applyBrokenEffect,
              isGlitched: isGlitched && gridItem.applyGlitchEffect,
              rotation: gridItem.rotation,
            ),
          ),
        );
      }

      // Crear fila con elementos
      final row = Padding(
        padding: EdgeInsets.only(bottom: effectiveRunSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: rowWidgets,
        ),
      );

      rows.add(row);
    }

    // Contenedor principal del grid
    Widget grid = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );

    // Aplicar padding si se proporciona
    if (padding != null) {
      grid = Padding(padding: padding!, child: grid);
    }

    // Aplicar borde si se requiere
    if (hasBorder) {
      grid = Container(
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          border: Border.all(
            color: effectiveBorderColor,
            width: theme.borderWidth,
          ),
        ),
        child: grid,
      );
    }

    return grid;
  }

  /// Crea filas de elementos de grid basadas en el número de columnas
  List<List<BrutalGridItem>> _createGridRows(
    List<BrutalGridItem> items,
    int totalColumns,
  ) {
    final List<List<BrutalGridItem>> rows = [];
    List<BrutalGridItem> currentRow = [];
    int currentRowSpan = 0;

    for (final item in items) {
      // Calcular el span efectivo del item para esta función (sin considerar responsive)
      final int itemSpan = item.span > totalColumns ? totalColumns : item.span;

      // Si el item no cabe en la fila actual, crear una nueva fila
      if (currentRowSpan + itemSpan > totalColumns) {
        if (currentRow.isNotEmpty) {
          rows.add(List.from(currentRow));
          currentRow = [];
          currentRowSpan = 0;
        }
      }

      // Añadir el item a la fila actual
      currentRow.add(item);
      currentRowSpan += itemSpan;

      // Si se llena exactamente la fila, crear una nueva
      if (currentRowSpan == totalColumns) {
        rows.add(List.from(currentRow));
        currentRow = [];
        currentRowSpan = 0;
      }
    }

    // Añadir la última fila si contiene elementos
    if (currentRow.isNotEmpty) {
      rows.add(currentRow);
    }

    return rows;
  }

  /// Obtiene el span responsivo según el tamaño de pantalla
  int _getResponsiveSpan(
    BuildContext context,
    BrutalGridItem item,
    int totalColumns,
  ) {
    final mediaQuerySize = MediaQuery.of(context).size;

    int span = item.span;

    // Aplicar spans responsivos si están configurados
    if (item.mobileSpan != null &&
        breakpointConfig != null &&
        mediaQuerySize.width <= breakpointConfig!.mobileBreakpoint) {
      span = item.mobileSpan!;
    } else if (item.tabletSpan != null &&
        breakpointConfig != null &&
        mediaQuerySize.width <= breakpointConfig!.tabletBreakpoint) {
      span = item.tabletSpan!;
    }

    // Asegurarse que el span no exceda el número total de columnas
    return span > totalColumns ? totalColumns : span;
  }

  /// Aplica efectos brutales (rotación, glitch) a un widget
  Widget _applyBrutalEffects(
    Widget child, {
    bool isBroken = false,
    bool isGlitched = false,
    double? rotation,
  }) {
    Widget result = child;

    // Aplicar rotación si se especifica explícitamente o si el elemento está broken
    if (rotation != null || isBroken) {
      final angle = rotation ?? (isBroken ? 0.02 : 0.0);
      result = Transform.rotate(angle: angle, child: result);
    }

    // Aplicar efecto glitch
    if (isGlitched) {
      result = Stack(
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
                child: result,
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
                child: result,
              ),
            ),
          ),
          result,
        ],
      );
    }

    return result;
  }

  /// Crea una variante con efecto "roto/glitch" del grid
  factory BrutalGridSystem.broken({
    Key? key,
    required List<BrutalGridItem> children,
    int columns = 12,
    double spacing = 16.0,
    double runSpacing = 16.0,
    bool hasBorder = true,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    Alignment alignment = Alignment.topLeft,
    BrutalBreakpointGridConfig? breakpointConfig,
  }) {
    return BrutalGridSystem(
      key: key,
      children: children,
      columns: columns,
      spacing: spacing,
      runSpacing: runSpacing,
      hasBorder: hasBorder,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      padding: padding,
      isBroken: true,
      isGlitched: true,
      alignment: alignment,
      breakpointConfig: breakpointConfig,
    );
  }

  /// Crea un grid adaptado para dispositivos móviles
  factory BrutalGridSystem.responsive({
    Key? key,
    required List<BrutalGridItem> children,
    required BrutalBreakpointGridConfig breakpointConfig,
    double spacing = 16.0,
    double runSpacing = 16.0,
    bool hasBorder = false,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    bool isBroken = false,
    bool isGlitched = false,
    Alignment alignment = Alignment.topLeft,
  }) {
    return BrutalGridSystem(
      key: key,
      children: children,
      columns: breakpointConfig.desktopColumns,
      spacing: spacing,
      runSpacing: runSpacing,
      hasBorder: hasBorder,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      padding: padding,
      isBroken: isBroken,
      isGlitched: isGlitched,
      alignment: alignment,
      breakpointConfig: breakpointConfig,
    );
  }
}

/// Elemento del grid con soporte para responsividad
class BrutalGridItem {
  final Widget child;
  final int span;
  final int? mobileSpan;
  final int? tabletSpan;
  final double? rotation;
  final bool applyGlitchEffect;
  final bool applyBrokenEffect;

  const BrutalGridItem({
    required this.child,
    required this.span,
    this.mobileSpan,
    this.tabletSpan,
    this.rotation,
    this.applyGlitchEffect = false,
    this.applyBrokenEffect = false,
  });

  /// Crea un nuevo grid item aplicándole efectos brutales
  BrutalGridItem copyWith({
    Widget? child,
    int? span,
    int? mobileSpan,
    int? tabletSpan,
    double? rotation,
    bool? applyGlitchEffect,
    bool? applyBrokenEffect,
  }) {
    return BrutalGridItem(
      child: child ?? this.child,
      span: span ?? this.span,
      mobileSpan: mobileSpan ?? this.mobileSpan,
      tabletSpan: tabletSpan ?? this.tabletSpan,
      rotation: rotation ?? this.rotation,
      applyGlitchEffect: applyGlitchEffect ?? this.applyGlitchEffect,
      applyBrokenEffect: applyBrokenEffect ?? this.applyBrokenEffect,
    );
  }

  /// Crea un grid item con efecto broken
  factory BrutalGridItem.broken({
    required Widget child,
    required int span,
    int? mobileSpan,
    int? tabletSpan,
    double? rotation,
  }) {
    return BrutalGridItem(
      child: child,
      span: span,
      mobileSpan: mobileSpan,
      tabletSpan: tabletSpan,
      rotation: rotation ?? 0.01,
      applyGlitchEffect: true,
      applyBrokenEffect: true,
    );
  }
}

/// Configuración de breakpoints para el sistema de grid
class BrutalBreakpointGridConfig {
  final double mobileBreakpoint;
  final double tabletBreakpoint;
  final int mobileColumns;
  final int tabletColumns;
  final int desktopColumns;

  const BrutalBreakpointGridConfig({
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 960,
    this.mobileColumns = 4,
    this.tabletColumns = 8,
    this.desktopColumns = 12,
  });

  /// Configuración estándar de grid responsivo (12 columnas)
  factory BrutalBreakpointGridConfig.standard() {
    return const BrutalBreakpointGridConfig(
      mobileBreakpoint: 600,
      tabletBreakpoint: 960,
      mobileColumns: 4,
      tabletColumns: 8,
      desktopColumns: 12,
    );
  }

  /// Configuración compacta de grid responsivo (8 columnas)
  factory BrutalBreakpointGridConfig.compact() {
    return const BrutalBreakpointGridConfig(
      mobileBreakpoint: 480,
      tabletBreakpoint: 768,
      mobileColumns: 2,
      tabletColumns: 4,
      desktopColumns: 8,
    );
  }
}
