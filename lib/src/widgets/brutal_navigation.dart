import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'button.dart';
import 'text.dart';

/// Navegación brutalista que rompe todas las convenciones
class BrutalNavigation extends StatefulWidget {
  final List<BrutalNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;
  final BrutalNavStyle style;
  final bool isGlitched;
  final bool allowChaos;
  final Color? backgroundColor;
  final Color? selectedColor;
  final double? itemSpacing;

  const BrutalNavigation({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onItemTapped,
    this.style = BrutalNavStyle.sidebar,
    this.isGlitched = false,
    this.allowChaos = false,
    this.backgroundColor,
    this.selectedColor,
    this.itemSpacing,
  });

  /// Navegación sidebar destrozada
  factory BrutalNavigation.destroyedSidebar({
    Key? key,
    required List<BrutalNavItem> items,
    required int selectedIndex,
    required ValueChanged<int> onItemTapped,
    bool isGlitched = true,
    Color? backgroundColor,
  }) {
    return BrutalNavigation(
      key: key,
      items: items,
      selectedIndex: selectedIndex,
      onItemTapped: onItemTapped,
      style: BrutalNavStyle.destroyedSidebar,
      isGlitched: isGlitched,
      allowChaos: true,
      backgroundColor: backgroundColor,
    );
  }

  /// Navegación flotante caótica
  factory BrutalNavigation.floatingChaos({
    Key? key,
    required List<BrutalNavItem> items,
    required int selectedIndex,
    required ValueChanged<int> onItemTapped,
    Color? selectedColor,
  }) {
    return BrutalNavigation(
      key: key,
      items: items,
      selectedIndex: selectedIndex,
      onItemTapped: onItemTapped,
      style: BrutalNavStyle.floatingChaos,
      allowChaos: true,
      selectedColor: selectedColor,
    );
  }

  /// Navegación de esquinas brutales
  factory BrutalNavigation.corners({
    Key? key,
    required List<BrutalNavItem> items,
    required int selectedIndex,
    required ValueChanged<int> onItemTapped,
    bool isGlitched = false,
  }) {
    return BrutalNavigation(
      key: key,
      items: items,
      selectedIndex: selectedIndex,
      onItemTapped: onItemTapped,
      style: BrutalNavStyle.corners,
      isGlitched: isGlitched,
    );
  }

  @override
  State<BrutalNavigation> createState() => _BrutalNavigationState();
}

class _BrutalNavigationState extends State<BrutalNavigation>
    with TickerProviderStateMixin {
  late AnimationController _glitchController;
  late AnimationController _chaosController;

  @override
  void initState() {
    super.initState();
    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _chaosController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    if (widget.isGlitched) {
      _glitchController.repeat(reverse: true);
    }
    if (widget.allowChaos) {
      _chaosController.repeat();
    }
  }

  @override
  void dispose() {
    _glitchController.dispose();
    _chaosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    switch (widget.style) {
      case BrutalNavStyle.sidebar:
        return _buildSidebar(theme);
      case BrutalNavStyle.destroyedSidebar:
        return _buildDestroyedSidebar(theme);
      case BrutalNavStyle.floatingChaos:
        return _buildFloatingChaos(theme);
      case BrutalNavStyle.corners:
        return _buildCorners(theme);
      case BrutalNavStyle.exploded:
        return _buildExploded(theme);
      case BrutalNavStyle.magnetic:
        return _buildMagnetic(theme);
    }
  }

  Widget _buildSidebar(BrutalTheme theme) {
    return Container(
      width: 240,
      color: widget.backgroundColor ?? theme.colors.surface,
      child: Column(
        children:
            widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.selectedIndex;

              return Container(
                margin: EdgeInsets.symmetric(
                  vertical: widget.itemSpacing ?? theme.spacing / 2,
                  horizontal: theme.spacing,
                ),
                child: _buildNavButton(item, index, isSelected, theme),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildDestroyedSidebar(BrutalTheme theme) {
    return AnimatedBuilder(
      animation: _glitchController,
      builder: (context, child) {
        final random = math.Random();
        return Container(
          width:
              240 + (widget.isGlitched ? (random.nextDouble() - 0.5) * 20 : 0),
          color: widget.backgroundColor ?? theme.colors.surface,
          child: Column(
            children:
                widget.items.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = index == widget.selectedIndex;

                  final offset =
                      widget.isGlitched
                          ? Offset((random.nextDouble() - 0.5) * 10, 0)
                          : Offset.zero;

                  return Transform.translate(
                    offset: offset,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: widget.itemSpacing ?? theme.spacing / 2,
                        horizontal: theme.spacing,
                      ),
                      child: Transform.rotate(
                        angle:
                            widget.isGlitched
                                ? (random.nextDouble() - 0.5) * 0.1
                                : 0,
                        child: _buildNavButton(item, index, isSelected, theme),
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildFloatingChaos(BrutalTheme theme) {
    return AnimatedBuilder(
      animation: _chaosController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children:
                  widget.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = index == widget.selectedIndex;

                    // Crear movimiento caótico pero predecible
                    final time = _chaosController.value * math.pi * 2;
                    final x =
                        math.sin(time + index) * 100 + constraints.maxWidth / 2;
                    final y =
                        math.cos(time + index * 0.7) * 80 +
                        constraints.maxHeight / 2;

                    return Positioned(
                      left: x.clamp(0, constraints.maxWidth - 100),
                      top: y.clamp(0, constraints.maxHeight - 50),
                      child: Transform.rotate(
                        angle: time + index,
                        child: _buildNavButton(item, index, isSelected, theme),
                      ),
                    );
                  }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildCorners(BrutalTheme theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final corners = [
          Alignment.topLeft,
          Alignment.topRight,
          Alignment.bottomLeft,
          Alignment.bottomRight,
        ];

        return Stack(
          children:
              widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == widget.selectedIndex;
                final corner = corners[index % corners.length];

                return Align(
                  alignment: corner,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: _buildNavButton(item, index, isSelected, theme),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildExploded(BrutalTheme theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final centerX = constraints.maxWidth / 2;
        final centerY = constraints.maxHeight / 2;

        return Stack(
          children:
              widget.items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                final isSelected = index == widget.selectedIndex;

                final angle = (index / widget.items.length) * math.pi * 2;
                final radius = 150.0;
                final x = centerX + math.cos(angle) * radius;
                final y = centerY + math.sin(angle) * radius;

                return Positioned(
                  left: x.clamp(0, constraints.maxWidth - 100),
                  top: y.clamp(0, constraints.maxHeight - 50),
                  child: Transform.rotate(
                    angle: angle,
                    child: _buildNavButton(item, index, isSelected, theme),
                  ),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildMagnetic(BrutalTheme theme) {
    return AnimatedBuilder(
      animation: _chaosController,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final attractorX = constraints.maxWidth * 0.3;
            final attractorY = constraints.maxHeight * 0.3;

            return Stack(
              children:
                  widget.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final isSelected = index == widget.selectedIndex;

                    // Simular atracción magnética
                    final baseAngle =
                        (index / widget.items.length) * math.pi * 2;
                    final baseDistance = 100 + index * 30;
                    final time = _chaosController.value * math.pi * 2;

                    final magneticForce = 0.3 + math.sin(time + index) * 0.2;
                    final x =
                        attractorX +
                        math.cos(baseAngle) * baseDistance * magneticForce;
                    final y =
                        attractorY +
                        math.sin(baseAngle) * baseDistance * magneticForce;

                    return Positioned(
                      left: x.clamp(0, constraints.maxWidth - 100),
                      top: y.clamp(0, constraints.maxHeight - 50),
                      child: Transform.scale(
                        scale: 0.8 + magneticForce * 0.4,
                        child: _buildNavButton(item, index, isSelected, theme),
                      ),
                    );
                  }).toList(),
            );
          },
        );
      },
    );
  }

  Widget _buildNavButton(
    BrutalNavItem item,
    int index,
    bool isSelected,
    BrutalTheme theme,
  ) {
    final backgroundColor =
        isSelected
            ? (widget.selectedColor ?? theme.colors.primary)
            : theme.colors.surface;

    final textColor = isSelected ? theme.colors.background : theme.colors.text;

    return BrutalButton(
      text: item.label,
      onPressed: () => widget.onItemTapped(index),
      backgroundColor: backgroundColor,
      textColor: textColor,
      variant:
          isSelected
              ? BrutalButtonVariant.primary
              : BrutalButtonVariant.secondary,
      borderStyle: theme.borderStyle,
      icon: item.icon,
    );
  }
}

/// Elemento de navegación brutal
class BrutalNavItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const BrutalNavItem({required this.label, this.icon, this.onTap});
}

/// Estilos de navegación brutal
enum BrutalNavStyle {
  sidebar, // Sidebar clásico
  destroyedSidebar, // Sidebar destrozado
  floatingChaos, // Flotante caótico
  corners, // En las esquinas
  exploded, // Explotado en círculo
  magnetic, // Atracción magnética
}

/// Barra de navegación superior ultra brutal
class BrutalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final Color? textColor;
  final BrutalAppBarStyle style;
  final bool isGlitched;
  final double? rotation;

  const BrutalAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.textColor,
    this.style = BrutalAppBarStyle.standard,
    this.isGlitched = false,
    this.rotation,
  });

  /// AppBar glitcheado
  factory BrutalAppBar.glitched({
    Key? key,
    String? title,
    List<Widget>? actions,
    Widget? leading,
    Color? backgroundColor,
  }) {
    return BrutalAppBar(
      key: key,
      title: title,
      actions: actions,
      leading: leading,
      backgroundColor: backgroundColor,
      style: BrutalAppBarStyle.glitched,
      isGlitched: true,
    );
  }

  /// AppBar fragmentado
  factory BrutalAppBar.shattered({
    Key? key,
    String? title,
    List<Widget>? actions,
    Color? backgroundColor,
    double rotation = 0.05,
  }) {
    return BrutalAppBar(
      key: key,
      title: title,
      actions: actions,
      backgroundColor: backgroundColor,
      style: BrutalAppBarStyle.shattered,
      rotation: rotation,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.primary;
    final effectiveTextColor = textColor ?? theme.colors.background;

    Widget appBarContent = Container(
      height: preferredSize.height,
      color: effectiveBackgroundColor,
      child: Row(
        children: [
          if (leading != null) leading!,
          const SizedBox(width: 16),
          if (title != null)
            Expanded(
              child: BrutalText(
                title!,
                style: theme.typography.heading2.copyWith(
                  color: effectiveTextColor,
                ),
              ),
            ),
          if (actions != null) ...actions!,
        ],
      ),
    );

    switch (style) {
      case BrutalAppBarStyle.standard:
        return appBarContent;
      case BrutalAppBarStyle.glitched:
        return _buildGlitchedAppBar(appBarContent, theme);
      case BrutalAppBarStyle.shattered:
        return _buildShatteredAppBar(appBarContent);
      case BrutalAppBarStyle.distorted:
        return _buildDistortedAppBar(appBarContent);
    }
  }

  Widget _buildGlitchedAppBar(Widget content, BrutalTheme theme) {
    return Stack(
      children: [
        Transform.translate(
          offset: const Offset(2, 0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              BrutalConstants.red.withOpacity(0.7),
              BlendMode.multiply,
            ),
            child: content,
          ),
        ),
        Transform.translate(
          offset: const Offset(-2, 0),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              BrutalConstants.cyan.withOpacity(0.7),
              BlendMode.multiply,
            ),
            child: content,
          ),
        ),
        content,
      ],
    );
  }

  Widget _buildShatteredAppBar(Widget content) {
    return Transform.rotate(angle: rotation ?? 0.05, child: content);
  }

  Widget _buildDistortedAppBar(Widget content) {
    return Transform(
      transform:
          Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.1)
            ..rotateY(0.05),
      alignment: Alignment.center,
      child: content,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

/// Estilos de AppBar brutal
enum BrutalAppBarStyle { standard, glitched, shattered, distorted }

/// Sistema de menú contextual brutal
class BrutalContextMenu extends StatelessWidget {
  final List<BrutalMenuItem> items;
  final Widget child;
  final bool isEnabled;

  const BrutalContextMenu({
    super.key,
    required this.items,
    required this.child,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!isEnabled) return child;

    return GestureDetector(
      onSecondaryTapUp: (details) {
        _showContextMenu(context, details.globalPosition);
      },
      onLongPress: () {
        _showContextMenu(context, Offset.zero);
      },
      child: child,
    );
  }

  void _showContextMenu(BuildContext context, Offset position) {
    final theme = BrutalTheme.of(context);
    final random = math.Random();

    showMenu<BrutalMenuItem>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + 1,
        position.dy + 1,
      ),
      items:
          items.map((item) {
            return PopupMenuItem<BrutalMenuItem>(
              value: item,
              child: Transform.rotate(
                angle: (random.nextDouble() - 0.5) * 0.1,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    border: Border.all(
                      color: theme.colors.border,
                      width: theme.borderWidth,
                    ),
                  ),
                  child: BrutalText(item.label, style: theme.typography.body),
                ),
              ),
            );
          }).toList(),
    ).then((selectedItem) {
      if (selectedItem != null) {
        selectedItem.onTap?.call();
      }
    });
  }
}

/// Elemento de menú contextual
class BrutalMenuItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;

  const BrutalMenuItem({required this.label, this.icon, this.onTap});
}
