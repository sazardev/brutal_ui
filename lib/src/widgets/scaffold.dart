import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

/// Un scaffold brutalista para aplicaciones con soporte ultra responsivo
class BrutalScaffold extends StatelessWidget {
  final Widget? body;
  final Widget? appBar;
  final Widget? bottomBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool isGlitched;
  final bool isBreakpointAware;
  final double? maxWidth;
  final double? maxHeight;
  final EdgeInsetsGeometry? padding;
  final BrutalBreakpoints? customBreakpoints;

  const BrutalScaffold({
    super.key,
    this.body,
    this.appBar,
    this.bottomBar,
    this.drawer,
    this.endDrawer,
    this.backgroundColor,
    this.borderColor,
    this.isGlitched = false,
    this.isBreakpointAware = true,
    this.maxWidth,
    this.maxHeight,
    this.padding,
    this.customBreakpoints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final breakpoints = customBreakpoints ?? BrutalBreakpoints.standard();
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.background;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Determinar el tipo de layout basado en el tamaño de pantalla
    BrutalBreakpointType breakpointType = BrutalBreakpointType.desktop;
    if (screenSize.width <= breakpoints.mobile) {
      breakpointType = BrutalBreakpointType.mobile;
    } else if (screenSize.width <= breakpoints.tablet) {
      breakpointType = BrutalBreakpointType.tablet;
    }

    // Manejar las configuraciones de layout responsivo
    Widget? effectiveAppBar = appBar;
    Widget? effectiveBottomBar = bottomBar;
    Widget effectiveBody = body ?? Container();
    bool showDrawer =
        drawer != null &&
        isBreakpointAware &&
        (breakpointType == BrutalBreakpointType.tablet ||
            breakpointType == BrutalBreakpointType.desktop);
    bool showEndDrawer =
        endDrawer != null &&
        isBreakpointAware &&
        breakpointType == BrutalBreakpointType.desktop;

    // Crear el scaffold con layout responsivo
    Widget scaffold = Container(
      color: effectiveBackgroundColor,
      child: Column(
        children: [
          if (effectiveAppBar != null) effectiveAppBar,
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (showDrawer)
                  Container(
                    width:
                        breakpointType == BrutalBreakpointType.desktop
                            ? 250
                            : 200,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: effectiveBorderColor,
                          width: theme.borderWidth,
                        ),
                      ),
                    ),
                    child: drawer,
                  ),
                Expanded(
                  child: Container(
                    padding: padding ?? EdgeInsets.all(theme.spacing),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: maxWidth ?? double.infinity,
                          maxHeight: maxHeight ?? double.infinity,
                        ),
                        child: effectiveBody,
                      ),
                    ),
                  ),
                ),
                if (showEndDrawer)
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: effectiveBorderColor,
                          width: theme.borderWidth,
                        ),
                      ),
                    ),
                    child: endDrawer,
                  ),
              ],
            ),
          ),
          if (effectiveBottomBar != null) effectiveBottomBar,
        ],
      ),
    );

    // Aplicar efecto glitch si está habilitado
    if (isGlitched) {
      scaffold = Stack(
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
                child: scaffold,
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
                child: scaffold,
              ),
            ),
          ),
          scaffold,
        ],
      );
    }

    return scaffold;
  }

  /// Crea un scaffold con borde completo
  factory BrutalScaffold.bordered({
    Key? key,
    Widget? body,
    Widget? appBar,
    Widget? bottomBar,
    Widget? drawer,
    Widget? endDrawer,
    Color? backgroundColor,
    Color? borderColor,
    bool isGlitched = false,
    bool isBreakpointAware = true,
    double? maxWidth,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
  }) {
    Widget borderedBody = Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? BrutalTheme.defaultTheme.colors.border,
          width: BrutalTheme.defaultTheme.borderWidth,
        ),
      ),
      child: body,
    );

    return BrutalScaffold(
      key: key,
      body: borderedBody,
      appBar: appBar,
      bottomBar: bottomBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      isGlitched: isGlitched,
      isBreakpointAware: isBreakpointAware,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      padding: padding,
    );
  }

  /// Crea un scaffold con estilo glitch
  factory BrutalScaffold.glitched({
    Key? key,
    Widget? body,
    Widget? appBar,
    Widget? bottomBar,
    Widget? drawer,
    Widget? endDrawer,
    Color? backgroundColor,
    Color? borderColor,
    bool isBreakpointAware = true,
    double? maxWidth,
    double? maxHeight,
    EdgeInsetsGeometry? padding,
  }) {
    return BrutalScaffold(
      key: key,
      body: body,
      appBar: appBar,
      bottomBar: bottomBar,
      drawer: drawer,
      endDrawer: endDrawer,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      isGlitched: true,
      isBreakpointAware: isBreakpointAware,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      padding: padding,
    );
  }
}

/// AppBar brutalista para usar con BrutalScaffold
class BrutalAppBar extends StatelessWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? borderColor;
  final double height;
  final EdgeInsetsGeometry? padding;
  final bool isGlitched;

  const BrutalAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.borderColor,
    this.height = 56.0,
    this.padding,
    this.isGlitched = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.surface;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    Widget appBar = Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: effectiveBorderColor,
            width: theme.borderWidth,
          ),
        ),
      ),
      padding: padding ?? EdgeInsets.symmetric(horizontal: theme.spacing),
      child: Row(
        children: [
          if (leading != null) ...[leading!, SizedBox(width: theme.spacing)],
          if (title != null)
            Expanded(
              child: DefaultTextStyle(
                style: theme.typography.heading3,
                child: title!,
              ),
            ),
          if (actions != null) ...[
            ...actions!.map((action) {
              return Padding(
                padding: EdgeInsets.only(left: theme.spacing / 2),
                child: action,
              );
            }),
          ],
        ],
      ),
    );

    // Aplicar efecto glitch si está habilitado
    if (isGlitched) {
      appBar = Stack(
        children: [
          Positioned(
            left: 1,
            top: 0,
            right: -1,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: appBar,
              ),
            ),
          ),
          Positioned(
            left: -1,
            top: 0,
            right: 1,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: appBar,
              ),
            ),
          ),
          appBar,
        ],
      );
    }

    return appBar;
  }
}

/// BottomBar brutalista para usar con BrutalScaffold
class BrutalBottomBar extends StatelessWidget {
  final List<BrutalBottomBarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double height;
  final bool isGlitched;
  final BrutalBottomBarVariant variant;

  const BrutalBottomBar({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.height = 56.0,
    this.isGlitched = false,
    this.variant = BrutalBottomBarVariant.default_,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.surface;
    final effectiveBorderColor = borderColor ?? theme.colors.border;
    final effectiveSelectedItemColor =
        selectedItemColor ?? theme.colors.primary;
    final effectiveUnselectedItemColor =
        unselectedItemColor ?? theme.colors.textLight;

    List<Widget> bottomBarItems = [];

    for (int i = 0; i < items.length; i++) {
      final isSelected = i == selectedIndex;
      final item = items[i];

      Widget itemWidget;

      switch (variant) {
        case BrutalBottomBarVariant.default_:
          itemWidget = _buildDefaultItem(
            i,
            isSelected,
            item,
            theme,
            effectiveSelectedItemColor,
            effectiveUnselectedItemColor,
          );
          break;
        case BrutalBottomBarVariant.broken:
          itemWidget = _buildBrokenItem(
            i,
            isSelected,
            item,
            theme,
            effectiveSelectedItemColor,
            effectiveUnselectedItemColor,
          );
          break;
        case BrutalBottomBarVariant.minimal:
          itemWidget = _buildMinimalItem(
            i,
            isSelected,
            item,
            theme,
            effectiveSelectedItemColor,
            effectiveUnselectedItemColor,
          );
          break;
      }

      bottomBarItems.add(Expanded(child: itemWidget));

      if (i < items.length - 1 && variant != BrutalBottomBarVariant.minimal) {
        bottomBarItems.add(
          Container(width: theme.borderWidth, color: effectiveBorderColor),
        );
      }
    }

    Widget bottomBar = Container(
      height: height,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          top: BorderSide(
            color: effectiveBorderColor,
            width: theme.borderWidth,
          ),
        ),
      ),
      child: Row(children: bottomBarItems),
    );

    // Aplicar efecto glitch si está habilitado
    if (isGlitched || variant == BrutalBottomBarVariant.broken) {
      bottomBar = Stack(
        children: [
          Positioned(
            left: 1,
            top: 0,
            right: -1,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: bottomBar,
              ),
            ),
          ),
          Positioned(
            left: -1,
            top: 0,
            right: 1,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: bottomBar,
              ),
            ),
          ),
          bottomBar,
        ],
      );
    }

    return bottomBar;
  }

  Widget _buildDefaultItem(
    int index,
    bool isSelected,
    BrutalBottomBarItem item,
    BrutalTheme theme,
    Color selectedColor,
    Color unselectedColor,
  ) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        color:
            isSelected
                ? selectedColor.withOpacity(0.1)
                : BrutalConstants.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(
                color: isSelected ? selectedColor : unselectedColor,
                size: 24.0,
              ),
              child: item.icon,
            ),
            const SizedBox(height: 2),
            if (item.label != null)
              BrutalText(
                item.label!,
                brutalStyle: BrutalTextStyle.caption,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrokenItem(
    int index,
    bool isSelected,
    BrutalBottomBarItem item,
    BrutalTheme theme,
    Color selectedColor,
    Color unselectedColor,
  ) {
    final angle = (index.isEven ? 0.02 : -0.02);

    return GestureDetector(
      onTap: () => onTap(index),
      child: Transform.rotate(
        angle: isSelected ? angle : 0,
        child: Container(
          color:
              isSelected
                  ? selectedColor.withOpacity(0.1)
                  : BrutalConstants.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme(
                data: IconThemeData(
                  color: isSelected ? selectedColor : unselectedColor,
                  size: 24.0,
                ),
                child: item.icon,
              ),
              const SizedBox(height: 2),
              if (item.label != null)
                BrutalText(
                  item.label!,
                  brutalStyle: BrutalTextStyle.caption,
                  style: TextStyle(
                    color: isSelected ? selectedColor : unselectedColor,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  isGlitched: isSelected,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMinimalItem(
    int index,
    bool isSelected,
    BrutalBottomBarItem item,
    BrutalTheme theme,
    Color selectedColor,
    Color unselectedColor,
  ) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isSelected ? selectedColor : BrutalConstants.transparent,
              width: theme.borderWidth * 2,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconTheme(
              data: IconThemeData(
                color: isSelected ? selectedColor : unselectedColor,
                size: 24.0,
              ),
              child: item.icon,
            ),
            const SizedBox(height: 2),
            if (item.label != null)
              BrutalText(
                item.label!,
                brutalStyle: BrutalTextStyle.caption,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Crea un bottom bar con estilo glitcheado
  factory BrutalBottomBar.broken({
    Key? key,
    required List<BrutalBottomBarItem> items,
    required int selectedIndex,
    required ValueChanged<int> onTap,
    Color? backgroundColor,
    Color? borderColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    double height = 56.0,
  }) {
    return BrutalBottomBar(
      key: key,
      items: items,
      selectedIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      height: height,
      isGlitched: true,
      variant: BrutalBottomBarVariant.broken,
    );
  }

  /// Crea un bottom bar con estilo minimalista
  factory BrutalBottomBar.minimal({
    Key? key,
    required List<BrutalBottomBarItem> items,
    required int selectedIndex,
    required ValueChanged<int> onTap,
    Color? backgroundColor,
    Color? borderColor,
    Color? selectedItemColor,
    Color? unselectedItemColor,
    double height = 56.0,
  }) {
    return BrutalBottomBar(
      key: key,
      items: items,
      selectedIndex: selectedIndex,
      onTap: onTap,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: unselectedItemColor,
      height: height,
      variant: BrutalBottomBarVariant.minimal,
    );
  }
}

/// Item para el BrutalBottomBar
class BrutalBottomBarItem {
  final Widget icon;
  final String? label;

  const BrutalBottomBarItem({required this.icon, this.label});
}

/// Variantes para el BrutalBottomBar
enum BrutalBottomBarVariant { default_, broken, minimal }

/// Definición de puntos de quiebre para diseño responsivo
class BrutalBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const BrutalBreakpoints({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Puntos de quiebre estándar
  factory BrutalBreakpoints.standard() {
    return const BrutalBreakpoints(mobile: 600, tablet: 960, desktop: 1280);
  }

  /// Puntos de quiebre compactos
  factory BrutalBreakpoints.compact() {
    return const BrutalBreakpoints(mobile: 480, tablet: 768, desktop: 1024);
  }

  /// Puntos de quiebre expandidos
  factory BrutalBreakpoints.expanded() {
    return const BrutalBreakpoints(mobile: 768, tablet: 1024, desktop: 1440);
  }
}

/// Tipos de puntos de quiebre
enum BrutalBreakpointType { mobile, tablet, desktop }
