import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

/// A brutalist tab bar and tab view implementation
class BrutalTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final bool hasBorder;
  final bool isJagged;
  final bool isGlitched;
  final Color? backgroundColor;
  final Color? selectedTabColor;
  final Color? borderColor;
  final BrutalTabVariant variant;

  const BrutalTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
    this.hasBorder = true,
    this.isJagged = false,
    this.isGlitched = false,
    this.backgroundColor,
    this.selectedTabColor,
    this.borderColor,
    this.variant = BrutalTabVariant.default_,
  });

  /// Creates a minimal tab bar with a brutalist style
  factory BrutalTabBar.minimal({
    Key? key,
    required List<String> tabs,
    required int selectedIndex,
    required ValueChanged<int> onTabSelected,
    bool isGlitched = false,
  }) {
    return BrutalTabBar(
      key: key,
      tabs: tabs,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
      hasBorder: false,
      variant: BrutalTabVariant.minimal,
      isGlitched: isGlitched,
    );
  }

  /// Creates a broken/jagged tab bar with a brutalist style
  factory BrutalTabBar.broken({
    Key? key,
    required List<String> tabs,
    required int selectedIndex,
    required ValueChanged<int> onTabSelected,
  }) {
    return BrutalTabBar(
      key: key,
      tabs: tabs,
      selectedIndex: selectedIndex,
      onTabSelected: onTabSelected,
      isJagged: true,
      variant: BrutalTabVariant.broken,
      isGlitched: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determine colors based on variant
    final bgColor = backgroundColor ?? theme.colors.surface;
    final selectedBgColor = selectedTabColor ?? theme.colors.primary;
    final borderCol = borderColor ?? theme.colors.border;

    // Build tab buttons
    List<Widget> tabButtons = [];

    for (int i = 0; i < tabs.length; i++) {
      final isSelected = i == selectedIndex;

      // Determine text and background colors based on selection state
      Color tabBgColor;
      Color textColor;

      switch (variant) {
        case BrutalTabVariant.default_:
          tabBgColor = isSelected ? selectedBgColor : bgColor;
          textColor = isSelected ? theme.colors.background : theme.colors.text;
          break;
        case BrutalTabVariant.minimal:
          tabBgColor = bgColor;
          textColor = isSelected ? selectedBgColor : theme.colors.text;
          break;
        case BrutalTabVariant.broken:
          tabBgColor = isSelected ? selectedBgColor : bgColor;
          textColor = isSelected ? theme.colors.background : theme.colors.text;
          break;
      }

      // Build the tab button
      Widget tabButton = GestureDetector(
        onTap: () => onTabSelected(i),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: theme.spacing * 0.75,
              horizontal: theme.spacing,
            ),
            decoration: BoxDecoration(
              color: tabBgColor,
              border:
                  variant == BrutalTabVariant.minimal
                      ? Border(
                        bottom: BorderSide(
                          color:
                              isSelected
                                  ? selectedBgColor
                                  : BrutalConstants.transparent,
                          width: theme.borderWidth * 2,
                        ),
                      )
                      : null,
            ),
            child: BrutalText(
              tabs[i],
              brutalStyle: BrutalTextStyle.button,
              style: TextStyle(
                color: textColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              isGlitched: isGlitched && isSelected,
            ),
          ),
        ),
      );

      // For jagged variant, apply slight rotation
      if (isJagged && variant == BrutalTabVariant.broken) {
        // Alternate rotation direction for adjacent tabs
        final angle = i.isEven ? 0.02 : -0.02;
        tabButton = Transform.rotate(angle: angle, child: tabButton);
      }

      tabButtons.add(Expanded(child: tabButton));

      // Add divider between tabs except for the last one
      if (i < tabs.length - 1 && variant != BrutalTabVariant.minimal) {
        tabButtons.add(
          Container(width: hasBorder ? theme.borderWidth : 0, color: borderCol),
        );
      }
    }

    // Build the tab bar
    Widget tabBar = Row(children: tabButtons);

    // Add border if needed
    if (hasBorder && variant != BrutalTabVariant.minimal) {
      tabBar = Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderCol, width: theme.borderWidth),
        ),
        child: tabBar,
      );
    }

    return tabBar;
  }
}

/// A tab view that works with BrutalTabBar
class BrutalTabView extends StatelessWidget {
  final List<Widget> children;
  final int selectedIndex;
  final bool hasBorder;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final bool isGlitched;

  const BrutalTabView({
    super.key,
    required this.children,
    required this.selectedIndex,
    this.hasBorder = true,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.isGlitched = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final bgColor = backgroundColor ?? theme.colors.surface;
    final borderCol = borderColor ?? theme.colors.border;

    // Show the selected child
    Widget content = IndexedStack(
      index: selectedIndex.clamp(0, children.length - 1),
      children: children,
    );

    if (padding != null) {
      content = Padding(padding: padding!, child: content);
    }

    // Add border if needed
    if (hasBorder) {
      content = Container(
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(
            left: BorderSide(color: borderCol, width: theme.borderWidth),
            right: BorderSide(color: borderCol, width: theme.borderWidth),
            bottom: BorderSide(color: borderCol, width: theme.borderWidth),
          ),
        ),
        child: content,
      );
    }

    // Apply glitch effect if needed
    if (isGlitched) {
      content = Stack(
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
                child: content,
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
                child: content,
              ),
            ),
          ),
          content,
        ],
      );
    }

    return content;
  }
}

/// A combination of BrutalTabBar and BrutalTabView for easier usage
class BrutalTabs extends StatefulWidget {
  final List<BrutalTabItem> tabs;
  final int initialIndex;
  final ValueChanged<int>? onTabChanged;
  final bool hasBorder;
  final bool isJagged;
  final bool isGlitched;
  final Color? backgroundColor;
  final Color? selectedTabColor;
  final Color? borderColor;
  final BrutalTabVariant variant;
  final EdgeInsetsGeometry? contentPadding;

  const BrutalTabs({
    super.key,
    required this.tabs,
    this.initialIndex = 0,
    this.onTabChanged,
    this.hasBorder = true,
    this.isJagged = false,
    this.isGlitched = false,
    this.backgroundColor,
    this.selectedTabColor,
    this.borderColor,
    this.variant = BrutalTabVariant.default_,
    this.contentPadding,
  });

  @override
  State<BrutalTabs> createState() => _BrutalTabsState();
}

class _BrutalTabsState extends State<BrutalTabs> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex.clamp(0, widget.tabs.length - 1);
  }

  @override
  void didUpdateWidget(BrutalTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      _selectedIndex = widget.initialIndex.clamp(0, widget.tabs.length - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BrutalTabBar(
          tabs: widget.tabs.map((tab) => tab.title).toList(),
          selectedIndex: _selectedIndex,
          onTabSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
            widget.onTabChanged?.call(index);
          },
          hasBorder: widget.hasBorder,
          isJagged: widget.isJagged,
          isGlitched: widget.isGlitched,
          backgroundColor: widget.backgroundColor,
          selectedTabColor: widget.selectedTabColor,
          borderColor: widget.borderColor,
          variant: widget.variant,
        ),
        BrutalTabView(
          selectedIndex: _selectedIndex,
          hasBorder: widget.hasBorder,
          backgroundColor: widget.backgroundColor,
          borderColor: widget.borderColor,
          padding: widget.contentPadding,
          isGlitched: widget.isGlitched,
          children: widget.tabs.map((tab) => tab.content).toList(),
        ),
      ],
    );
  }
}

/// Data class for items in BrutalTabs
class BrutalTabItem {
  final String title;
  final Widget content;

  const BrutalTabItem({required this.title, required this.content});
}

/// Tab variants
enum BrutalTabVariant { default_, minimal, broken }
