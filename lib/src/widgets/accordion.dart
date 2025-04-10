import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';
import '../utils/constants.dart';
import 'text.dart';

/// A brutalist accordion widget for expandable content sections
class BrutalAccordion extends StatefulWidget {
  final String title;
  final Widget content;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final IconData? expandIcon;
  final IconData? collapseIcon;
  final BrutalAccordionVariant variant;
  final bool hasBorder;
  final bool isGlitched;

  const BrutalAccordion({
    super.key,
    required this.title,
    required this.content,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.backgroundColor,
    this.titleColor,
    this.borderColor,
    this.expandIcon,
    this.collapseIcon,
    this.variant = BrutalAccordionVariant.default_,
    this.hasBorder = true,
    this.isGlitched = false,
  });

  /// Creates a minimal accordion with a brutalist style
  factory BrutalAccordion.minimal({
    Key? key,
    required String title,
    required Widget content,
    bool initiallyExpanded = false,
    ValueChanged<bool>? onExpansionChanged,
  }) {
    return BrutalAccordion(
      key: key,
      title: title,
      content: content,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      variant: BrutalAccordionVariant.minimal,
      hasBorder: false,
    );
  }

  /// Creates a broken accordion with a brutalist style
  factory BrutalAccordion.broken({
    Key? key,
    required String title,
    required Widget content,
    bool initiallyExpanded = false,
    ValueChanged<bool>? onExpansionChanged,
  }) {
    return BrutalAccordion(
      key: key,
      title: title,
      content: content,
      initiallyExpanded: initiallyExpanded,
      onExpansionChanged: onExpansionChanged,
      variant: BrutalAccordionVariant.broken,
      isGlitched: true,
    );
  }

  @override
  State<BrutalAccordion> createState() => _BrutalAccordionState();
}

class _BrutalAccordionState extends State<BrutalAccordion>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  late Animation<double> _iconRotation;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _heightFactor = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    _iconRotation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(BrutalAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initiallyExpanded != oldWidget.initiallyExpanded) {
      setState(() {
        _isExpanded = widget.initiallyExpanded;
        if (_isExpanded) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onExpansionChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determine colors based on variant
    Color bgColor = widget.backgroundColor ?? theme.colors.surface;
    Color titleBgColor;
    Color textColor = widget.titleColor ?? theme.colors.text;
    Color borderCol = widget.borderColor ?? theme.colors.border;

    switch (widget.variant) {
      case BrutalAccordionVariant.default_:
        titleBgColor = bgColor;
        break;
      case BrutalAccordionVariant.minimal:
        titleBgColor = BrutalConstants.transparent;
        break;
      case BrutalAccordionVariant.broken:
        titleBgColor = bgColor;
        break;
    }

    // Create the header widget
    Widget header = GestureDetector(
      onTap: _toggleExpanded,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: EdgeInsets.all(theme.spacing),
          color: titleBgColor,
          child: Row(
            children: [
              Expanded(
                child: BrutalText(
                  widget.title,
                  brutalStyle: BrutalTextStyle.heading3,
                  style: TextStyle(color: textColor),
                  isGlitched: widget.isGlitched,
                ),
              ),
              SizedBox(width: theme.spacing),
              AnimatedBuilder(
                animation: _iconRotation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _iconRotation.value * math.pi * 2,
                    child: Icon(
                      _isExpanded
                          ? (widget.collapseIcon ??
                              const IconData(
                                0xe5ce,
                                fontFamily: 'MaterialIcons',
                              )) // expand_less
                          : (widget.expandIcon ??
                              const IconData(
                                0xe5cf,
                                fontFamily: 'MaterialIcons',
                              )), // expand_more
                      color: textColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    // Create the child content
    Widget childContent = ClipRect(
      child: AnimatedBuilder(
        animation: _heightFactor,
        builder: (context, child) {
          return SizeTransition(sizeFactor: _heightFactor, child: child);
        },
        child: Container(
          padding: EdgeInsets.all(theme.spacing),
          color: bgColor,
          child: widget.content,
        ),
      ),
    );

    // Apply appropriate border based on variant
    Widget accordion;

    if (widget.hasBorder) {
      switch (widget.variant) {
        case BrutalAccordionVariant.default_:
        case BrutalAccordionVariant.broken:
          accordion = Container(
            decoration: BoxDecoration(
              border: Border.all(color: borderCol, width: theme.borderWidth),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                if (_isExpanded || _controller.value > 0)
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: borderCol,
                          width: theme.borderWidth,
                        ),
                      ),
                    ),
                    child: childContent,
                  ),
              ],
            ),
          );
          break;
        case BrutalAccordionVariant.minimal:
          accordion = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header,
              if (_isExpanded || _controller.value > 0)
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: borderCol,
                        width: theme.borderWidth,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(left: theme.spacing),
                  margin: EdgeInsets.only(left: theme.spacing),
                  child: childContent,
                ),
            ],
          );
          break;
      }
    } else {
      accordion = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [header, childContent],
      );
    }

    // Apply rotation for variant broken
    if (widget.variant == BrutalAccordionVariant.broken) {
      accordion = Transform.rotate(angle: 0.01, child: accordion);
    }

    return accordion;
  }
}

/// A group of accordions with coordinated behavior
class BrutalAccordionGroup extends StatefulWidget {
  final List<BrutalAccordionItem> items;
  final bool allowMultipleOpen;
  final int? initialOpenIndex;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? borderColor;
  final BrutalAccordionVariant variant;
  final bool hasBorder;
  final bool isGlitched;

  const BrutalAccordionGroup({
    super.key,
    required this.items,
    this.allowMultipleOpen = false,
    this.initialOpenIndex,
    this.backgroundColor,
    this.titleColor,
    this.borderColor,
    this.variant = BrutalAccordionVariant.default_,
    this.hasBorder = true,
    this.isGlitched = false,
  });

  @override
  State<BrutalAccordionGroup> createState() => _BrutalAccordionGroupState();
}

class _BrutalAccordionGroupState extends State<BrutalAccordionGroup> {
  late Set<int> _openIndices;

  @override
  void initState() {
    super.initState();
    _openIndices = {};
    if (widget.initialOpenIndex != null &&
        widget.initialOpenIndex! >= 0 &&
        widget.initialOpenIndex! < widget.items.length) {
      _openIndices.add(widget.initialOpenIndex!);
    }
  }

  @override
  void didUpdateWidget(BrutalAccordionGroup oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialOpenIndex != oldWidget.initialOpenIndex) {
      if (widget.initialOpenIndex != null &&
          widget.initialOpenIndex! >= 0 &&
          widget.initialOpenIndex! < widget.items.length) {
        setState(() {
          _openIndices.clear();
          _openIndices.add(widget.initialOpenIndex!);
        });
      }
    }

    // If we switched from multiple open to single open, keep only the first open one
    if (oldWidget.allowMultipleOpen &&
        !widget.allowMultipleOpen &&
        _openIndices.length > 1) {
      setState(() {
        final firstOpenIndex = _openIndices.first;
        _openIndices.clear();
        _openIndices.add(firstOpenIndex);
      });
    }
  }

  void _handleExpansionChanged(int index, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        if (!widget.allowMultipleOpen) {
          _openIndices.clear();
        }
        _openIndices.add(index);
      } else {
        _openIndices.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final borderCol = widget.borderColor ?? theme.colors.border;

    List<Widget> accordions = [];

    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      accordions.add(
        BrutalAccordion(
          title: item.title,
          content: item.content,
          initiallyExpanded: _openIndices.contains(i),
          onExpansionChanged:
              (isExpanded) => _handleExpansionChanged(i, isExpanded),
          backgroundColor: widget.backgroundColor,
          titleColor: widget.titleColor,
          borderColor: widget.borderColor,
          variant: widget.variant,
          hasBorder: false, // We'll handle borders for the group
          isGlitched: widget.isGlitched,
        ),
      );

      // Add a divider except for the last item
      if (i < widget.items.length - 1) {
        accordions.add(Container(height: theme.borderWidth, color: borderCol));
      }
    }

    Widget group = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: accordions,
    );

    // Apply border for the entire group if needed
    if (widget.hasBorder) {
      group = Container(
        decoration: BoxDecoration(
          border: Border.all(color: borderCol, width: theme.borderWidth),
        ),
        child: group,
      );
    }

    return group;
  }
}

/// Data class for items in BrutalAccordionGroup
class BrutalAccordionItem {
  final String title;
  final Widget content;

  const BrutalAccordionItem({required this.title, required this.content});
}

/// Accordion variants
enum BrutalAccordionVariant { default_, minimal, broken }
