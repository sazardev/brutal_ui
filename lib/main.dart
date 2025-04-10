import 'package:flutter/material.dart';
import 'brutal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Current theme that can be changed
  BrutalTheme _currentTheme = BrutalTheme.darkTheme;

  // Method to change theme
  void _changeTheme(BrutalTheme newTheme) {
    setState(() {
      _currentTheme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BrutalApp(
      theme: _currentTheme,
      child: BrutalToastOverlay(
        child: ShowcasePage(onThemeChanged: _changeTheme),
      ),
    );
  }
}

class ShowcasePage extends StatefulWidget {
  final Function(BrutalTheme) onThemeChanged;

  const ShowcasePage({super.key, required this.onThemeChanged});

  @override
  State<ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<ShowcasePage> {
  final _textController = TextEditingController();
  final List<String> _listItems = [
    'Brutalist element 1',
    'Brutalist element 2',
    'Brutalist element 3',
    'Brutalist element 4',
    'Brutalist element 5',
  ];

  // Controllers for interactive component demos
  bool _checkboxValue1 = true;
  bool _checkboxValue2 = false;
  bool _toggleValue = true;
  String _radioValue = 'option1';
  // Variable to control the selected minimal tab
  int _minimalTabIndex = 0;

  // Show a Toast
  void _showToast(BuildContext context, BrutalToastVariant variant) {
    String message = '';
    Widget? iconWidget;

    switch (variant) {
      case BrutalToastVariant.success:
        message = 'Operation successful';
        iconWidget = const Icon(Icons.check_circle);
        BrutalToasts.showSuccess(context, message, icon: iconWidget);
        break;
      case BrutalToastVariant.error:
        message = 'An error occurred';
        iconWidget = const Icon(Icons.error);
        BrutalToasts.showError(context, message, icon: iconWidget);
        break;
      case BrutalToastVariant.warning:
        message = 'Warning: action in progress';
        iconWidget = const Icon(Icons.warning);
        BrutalToasts.showWarning(context, message, icon: iconWidget);
        break;
      case BrutalToastVariant.glitch:
        message = 'System error';
        iconWidget = const Icon(Icons.build_circle);
        BrutalToasts.show(
          context,
          message,
          icon: iconWidget,
          variant: BrutalToastVariant.glitch,
        );
        break;
      default:
        message = 'Information message';
        iconWidget = const Icon(Icons.info);
        BrutalToasts.show(context, message, icon: iconWidget);
    }
  }

  // Show a Dialog
  void _showDialog(BuildContext context, BrutalDialogVariant variant) {
    BrutalDialog dialog;

    switch (variant) {
      case BrutalDialogVariant.alert:
        dialog = BrutalDialog.alert(
          title: 'Alert',
          content: BrutalText(
            'This is an important alert that requires your attention.',
          ),
          onConfirm: () => Navigator.of(context).pop(),
          confirmText: 'Understood',
        );
        break;
      case BrutalDialogVariant.broken:
        dialog = BrutalDialog.glitched(
          title: 'System Error',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BrutalText(
                'An unexpected error has occurred in the system.',
                isGlitched: true,
              ),
              SizedBox(height: 8),
              BrutalText.caption(
                'Code: 0xBF34A',
                variant: BrutalTextVariant.subtle,
              ),
            ],
          ),
          actions: [
            BrutalDialogAction(
              label: 'Retry',
              onPressed: () => Navigator.of(context).pop(),
              isDefault: true,
            ),
            BrutalDialogAction(
              label: 'Cancel',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
        break;
      default:
        dialog = BrutalDialog.confirm(
          title: 'Confirmation',
          content: BrutalText(
            'Are you sure you want to continue with this action?',
          ),
          onConfirm: () => Navigator.of(context).pop(),
          onCancel: () => Navigator.of(context).pop(),
          confirmText: 'Confirm',
          cancelText: 'Cancel',
        );
    }

    BrutalDialog.show(context: context, dialog: dialog);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return DirectionalityProvider(
      textDirection: TextDirection.ltr,
      child: BrutalToastOverlay(
        child: ColoredBox(
          color: theme.colors.background,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(theme.spacing * 2),
            child: Center(
              child: BrutalContainer(
                width: 500,
                hasShadow: true,
                padding: EdgeInsets.all(theme.spacing * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    BrutalText.display('Brutal UI', isGlitched: true),
                    SizedBox(height: theme.spacing),
                    BrutalText('A brutalist design system for Flutter'),
                    SizedBox(height: theme.spacing * 3),

                    // Themes Section
                    _buildSection('Themes', [
                      BrutalText('Select a theme:'),
                      SizedBox(height: theme.spacing),
                      BrutalWrapper(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(
                            text: 'Default',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.defaultTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(theme, BrutalTheme.defaultTheme)
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(theme, BrutalTheme.defaultTheme)
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Dark',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.darkTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(theme, BrutalTheme.darkTheme)
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(theme, BrutalTheme.darkTheme)
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Neon',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.neonTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(theme, BrutalTheme.neonTheme)
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(theme, BrutalTheme.neonTheme)
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Minimal',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.minimalTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(theme, BrutalTheme.minimalTheme)
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(theme, BrutalTheme.minimalTheme)
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Typewriter',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.typewriterTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.typewriterTheme,
                                    )
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.typewriterTheme,
                                    )
                                    ? theme.colors.background
                                    : null,
                          ),
                          // New buttons for additional themes
                          BrutalButton(
                            text: 'Retro',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.retroTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(theme, BrutalTheme.retroTheme)
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(theme, BrutalTheme.retroTheme)
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Vaporwave',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.vaporwaveTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.vaporwaveTheme,
                                    )
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.vaporwaveTheme,
                                    )
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Cyberpunk',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.cyberpunkTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.cyberpunkTheme,
                                    )
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.cyberpunkTheme,
                                    )
                                    ? theme.colors.background
                                    : null,
                          ),
                          BrutalButton(
                            text: 'Construction',
                            onPressed:
                                () => widget.onThemeChanged(
                                  BrutalTheme.constructionTheme,
                                ),
                            backgroundColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.constructionTheme,
                                    )
                                    ? theme.colors.primary
                                    : null,
                            textColor:
                                _isCurrentTheme(
                                      theme,
                                      BrutalTheme.constructionTheme,
                                    )
                                    ? theme.colors.background
                                    : null,
                          ),
                        ],
                      ),
                    ]),

                    // Layouts Section
                    _buildSection('Brutal Layouts', [
                      // BrutalRow
                      BrutalText.heading3('BrutalRow'),
                      SizedBox(height: theme.spacing),
                      BrutalRow(
                        hasBorder: true,
                        padding: EdgeInsets.all(theme.spacing),
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('1')),
                          ),
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('2')),
                          ),
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('3')),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('With jagged effect:'),
                      SizedBox(height: theme.spacing / 2),
                      BrutalRow(
                        isJagged: true,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('1')),
                          ),
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('2')),
                          ),
                          BrutalContainer(
                            width: 50,
                            height: 50,
                            child: Center(child: BrutalText('3')),
                          ),
                        ],
                      ),

                      SizedBox(height: theme.spacing * 2),

                      // BrutalColumn
                      BrutalText.heading3('BrutalColumn'),
                      SizedBox(height: theme.spacing),
                      Center(
                        child: BrutalColumn(
                          hasBorder: true,
                          padding: EdgeInsets.all(theme.spacing),
                          children: [
                            BrutalText('Item 1'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Item 2'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Item 3'),
                          ],
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('With glitched effect:'),
                      SizedBox(height: theme.spacing / 2),
                      Center(
                        child: BrutalColumn(
                          isGlitched: true,
                          padding: EdgeInsets.all(theme.spacing),
                          children: [
                            BrutalText('Item 1'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Item 2'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Item 3'),
                          ],
                        ),
                      ),

                      SizedBox(height: theme.spacing * 2),

                      // BrutalGrid
                      BrutalText.heading3('BrutalGrid'),
                      SizedBox(height: theme.spacing),
                      BrutalGrid(
                        crossAxisCount: 3,
                        mainAxisSpacing: theme.spacing,
                        crossAxisSpacing: theme.spacing,
                        children: List.generate(
                          6,
                          (index) => BrutalContainer(
                            height: 60,
                            child: Center(child: BrutalText('${index + 1}')),
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('With skewed effect:'),
                      SizedBox(height: theme.spacing / 2),
                      BrutalGrid(
                        crossAxisCount: 3,
                        mainAxisSpacing: theme.spacing,
                        crossAxisSpacing: theme.spacing,
                        isSkewed: true,
                        children: List.generate(
                          6,
                          (index) => BrutalContainer(
                            height: 60,
                            child: Center(child: BrutalText('${index + 1}')),
                          ),
                        ),
                      ),

                      SizedBox(height: theme.spacing * 2),

                      // BrutalList
                      BrutalText.heading3('BrutalList'),
                      SizedBox(height: theme.spacing),
                      SizedBox(
                        height: 180,
                        child: BrutalList(
                          hasBorder: true,
                          hasSeparators: true,
                          hasAlternatingColors: true,
                          itemPadding: EdgeInsets.all(theme.spacing),
                          children:
                              _listItems
                                  .map((item) => BrutalText(item))
                                  .toList(),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('Horizontal list:'),
                      SizedBox(height: theme.spacing / 2),
                      SizedBox(
                        height: 80,
                        child: BrutalList(
                          hasBorder: true,
                          hasSeparators: true,
                          direction: Axis.horizontal,
                          itemPadding: EdgeInsets.all(theme.spacing),
                          children:
                              _listItems
                                  .map((item) => BrutalText(item))
                                  .toList(),
                        ),
                      ),

                      SizedBox(height: theme.spacing * 2),

                      // BrutalStack
                      BrutalText.heading3('BrutalStack'),
                      SizedBox(height: theme.spacing),
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Center(
                          child: BrutalStack(
                            hasBorder: true,
                            padding: EdgeInsets.all(theme.spacing),
                            children: [
                              BrutalContainer(
                                width: 100,
                                height: 70,
                                backgroundColor: theme.colors.primary
                                    .withOpacity(0.2),
                                child: Center(child: BrutalText('Back')),
                              ),
                              Positioned(
                                top: 15,
                                left: 35,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.5),
                                  child: Center(child: BrutalText('Middle')),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 70,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.8),
                                  child: Center(child: BrutalText('Front')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('With rotation:'),
                      SizedBox(height: theme.spacing / 2),
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: Center(
                          child: BrutalStack(
                            isRotated: true,
                            hasBorder: true,
                            padding: EdgeInsets.all(theme.spacing),
                            children: [
                              BrutalContainer(
                                width: 100,
                                height: 70,
                                backgroundColor: theme.colors.primary
                                    .withOpacity(0.2),
                                child: Center(child: BrutalText('Back')),
                              ),
                              Positioned(
                                top: 15,
                                left: 35,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.5),
                                  child: Center(child: BrutalText('Middle')),
                                ),
                              ),
                              Positioned(
                                top: 30,
                                left: 70,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.8),
                                  child: Center(child: BrutalText('Front')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: theme.spacing * 2),

                      // BrutalWrapper
                      BrutalText.heading3('BrutalWrapper'),
                      SizedBox(height: theme.spacing),
                      BrutalWrapper(
                        hasBorder: true,
                        padding: EdgeInsets.all(theme.spacing),
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalChip(label: 'Tag 1'),
                          BrutalChip(label: 'Tag 2'),
                          BrutalChip(label: 'Large tag 3'),
                          BrutalChip(label: 'Tag 4'),
                          BrutalChip(label: 'Tag 5'),
                          BrutalChip(label: 'Long tag 6'),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('With jagged effect:'),
                      SizedBox(height: theme.spacing / 2),
                      BrutalWrapper(
                        hasBorder: true,
                        isJagged: true,
                        padding: EdgeInsets.all(theme.spacing),
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalChip(label: 'Tag 1'),
                          BrutalChip(label: 'Tag 2'),
                          BrutalChip(label: 'Large tag 3'),
                          BrutalChip(label: 'Tag 4'),
                          BrutalChip(label: 'Tag 5'),
                          BrutalChip(label: 'Long tag 6'),
                        ],
                      ),
                    ]),

                    // Typography Section
                    _buildSection('Typography', [
                      BrutalText.heading1('Heading 1'),
                      BrutalText.heading2('Heading 2'),
                      BrutalText.heading3('Heading 3'),
                      BrutalText('Normal text (body)'),
                      BrutalText.caption('Caption'),
                      BrutalText.mono('Monospace text'),
                      SizedBox(height: theme.spacing),
                      BrutalText(
                        'Marked text',
                        variant: BrutalTextVariant.marked,
                      ),
                      BrutalText('Glitched text', isGlitched: true),
                    ]),

                    // Buttons Section
                    _buildSection('Buttons', [
                      Wrap(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(text: 'Standard', onPressed: () {}),
                          BrutalButton.primary(
                            text: 'Primary',
                            onPressed: () {},
                          ),
                          BrutalButton.secondary(
                            text: 'Secondary',
                            onPressed: () {},
                          ),
                          BrutalButton.destructive(
                            text: 'Destructive',
                            onPressed: () {},
                          ),
                          BrutalButton.broken(text: 'Broken', onPressed: () {}),
                        ],
                      ),
                    ]),

                    // Containers Section
                    _buildSection('Containers', [
                      Wrap(
                        spacing: theme.spacing * 2,
                        runSpacing: theme.spacing * 2,
                        children: [
                          BrutalContainer(
                            width: 120,
                            height: 80,
                            child: Center(child: BrutalText('Normal')),
                          ),
                          BrutalContainer.callout(
                            width: 120,
                            height: 80,
                            child: Center(child: BrutalText('Callout')),
                          ),
                          BrutalContainer.floating(
                            width: 120,
                            height: 80,
                            child: Center(child: BrutalText('Float')),
                          ),
                          BrutalContainer.broken(
                            width: 120,
                            height: 80,
                            child: Center(child: BrutalText('Broken')),
                          ),
                        ],
                      ),
                    ]),

                    // Inputs Section
                    _buildSection('Inputs', [
                      BrutalInput(
                        label: 'Standard input',
                        controller: _textController,
                        placeholder: 'Type here...',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalInput.search(placeholder: 'Search...'),
                      SizedBox(height: theme.spacing),
                      BrutalInput.code(
                        label: 'Code input',
                        controller: TextEditingController(
                          text: 'console.log("Brutal");',
                        ),
                      ),
                    ]),

                    // Interactive Components Section
                    _buildSection('Interactive Components', [
                      // Checkboxes
                      BrutalText.heading3('Checkboxes'),
                      SizedBox(height: theme.spacing),
                      BrutalCheckbox(
                        value: _checkboxValue1,
                        onChanged: (value) {
                          setState(() {
                            _checkboxValue1 = value;
                          });
                        },
                        label: 'Checkbox 1',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalCheckbox(
                        value: _checkboxValue2,
                        onChanged: (value) {
                          setState(() {
                            _checkboxValue2 = value;
                          });
                        },
                        label: 'Checkbox 2',
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Toggles
                      BrutalText.heading3('Toggles'),
                      SizedBox(height: theme.spacing),
                      BrutalToggle(
                        value: _toggleValue,
                        onChanged: (value) {
                          setState(() {
                            _toggleValue = value;
                          });
                        },
                        label: 'Toggle',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalToggle(
                        value: !_toggleValue,
                        onChanged: (value) {
                          setState(() {
                            _toggleValue = !value;
                          });
                        },
                        label: 'Toggle (broken variant)',
                        variant: BrutalToggleVariant.broken,
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Radio Buttons
                      BrutalText.heading3('Radio Buttons'),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'option1',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Option 1',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'option2',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Option 2',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'option3',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Option 3 (square variant)',
                        variant: BrutalRadioVariant.square,
                      ),
                    ]),

                    // Accordions Section
                    _buildSection('Accordions', [
                      BrutalText.heading3('Individual Accordions'),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion(
                        title: 'Standard Accordion',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'This is the accordion content. It expands and collapses when you click on the title.',
                          ),
                        ),
                        initiallyExpanded: true,
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion.minimal(
                        title: 'Minimal Accordion',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'This accordion has a minimalist style without full borders.',
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion.broken(
                        title: 'Broken Accordion',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'This accordion has a "broken" style with rotation and glitch effects.',
                            isGlitched: true,
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Accordion Group'),
                      SizedBox(height: theme.spacing),
                      BrutalAccordionGroup(
                        items: [
                          BrutalAccordionItem(
                            title: 'Section 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Content of the first section of the accordion group.',
                              ),
                            ),
                          ),
                          BrutalAccordionItem(
                            title: 'Section 2',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Content of the second section of the accordion group.',
                              ),
                            ),
                          ),
                          BrutalAccordionItem(
                            title: 'Section 3',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText('Content with multiple elements'),
                                  SizedBox(height: theme.spacing),
                                  BrutalButton(
                                    text: 'A button inside the accordion',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                        initialOpenIndex: 0,
                      ),
                    ]),

                    // Cards Section
                    _buildSection('Cards', [
                      BrutalText.heading3('Card Variants'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing * 2,
                        runSpacing: theme.spacing * 2,
                        children: [
                          BrutalCard(
                            width: 200,
                            title: 'Standard Card',
                            subtitle: 'With title and subtitle',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'Card content with default style.',
                              ),
                            ),
                          ),
                          BrutalCard.featured(
                            width: 200,
                            title: 'Featured Card',
                            subtitle: 'With stronger shadow',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'This card has a more prominent style for featured content.',
                              ),
                            ),
                          ),
                          BrutalCard.glitch(
                            width: 200,
                            title: 'Glitch Card',
                            subtitle: 'With error effects',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'This card simulates visual errors for a brutalist effect.',
                                isGlitched: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalCard(
                        title: 'Card with actions',
                        subtitle: 'Example card with interactive components',
                        leading: Container(
                          width: 40,
                          height: 40,
                          color: theme.colors.primary,
                          child: Center(
                            child: BrutalText(
                              'B',
                              style: TextStyle(
                                color: theme.colors.background,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        trailing: BrutalButton(
                          text: 'Action',
                          onPressed: () {},
                          variant: BrutalButtonVariant.primary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: theme.spacing,
                          ),
                          child: BrutalText(
                            'This is a card with an avatar icon, title, subtitle, and an action button.',
                          ),
                        ),
                      ),
                    ]),

                    // Alerts Section
                    _buildSection('Alerts and Notifications', [
                      BrutalText.heading3('Alerts'),
                      SizedBox(height: theme.spacing),
                      BrutalAlert(
                        title: 'Information alert',
                        message: 'This is a general information message.',
                        icon: Icon(Icons.info),
                        variant: BrutalAlertVariant.info,
                        onClose: () {},
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.success(
                        title: 'Operation successful',
                        message: 'Data has been saved successfully.',
                        icon: Icon(Icons.check_circle),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.warning(
                        title: 'Warning',
                        message: 'This process may take several minutes.',
                        icon: Icon(Icons.warning),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.error(
                        title: 'Error',
                        message: 'Unable to connect to the server.',
                        icon: Icon(Icons.error),
                        actions: [
                          BrutalAlertAction(
                            label: 'Retry',
                            onPressed: () {},
                            isPrimary: true,
                          ),
                          BrutalAlertAction(label: 'Cancel', onPressed: () {}),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Toasts
                      BrutalText.heading3('Toasts'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(
                            text: 'Success Toast',
                            onPressed:
                                () => _showToast(
                                  context,
                                  BrutalToastVariant.success,
                                ),
                          ),
                          BrutalButton(
                            text: 'Error Toast',
                            onPressed:
                                () => _showToast(
                                  context,
                                  BrutalToastVariant.error,
                                ),
                          ),
                          BrutalButton(
                            text: 'Warning Toast',
                            onPressed:
                                () => _showToast(
                                  context,
                                  BrutalToastVariant.warning,
                                ),
                          ),
                          BrutalButton(
                            text: 'Glitch Toast',
                            onPressed:
                                () => _showToast(
                                  context,
                                  BrutalToastVariant.glitch,
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Tooltips
                      BrutalText.heading3('Tooltips'),
                      SizedBox(height: theme.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BrutalTooltip(
                            message: 'This is a standard tooltip',
                            child: BrutalButton(
                              text: 'Hover',
                              onPressed: () {},
                            ),
                          ),
                          BrutalTooltip(
                            message: 'Tooltip with glitch effect',
                            isGlitched: true,
                            child: BrutalButton(
                              text: 'Glitch',
                              onPressed: () {},
                              variant: BrutalButtonVariant.broken,
                            ),
                          ),
                        ],
                      ),
                    ]),

                    // Dialogs Section
                    _buildSection('Dialogs', [
                      BrutalText.heading3('Modal Dialogs'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(
                            text: 'Confirmation Dialog',
                            onPressed:
                                () => _showDialog(
                                  context,
                                  BrutalDialogVariant.default_,
                                ),
                          ),
                          BrutalButton(
                            text: 'Alert Dialog',
                            onPressed:
                                () => _showDialog(
                                  context,
                                  BrutalDialogVariant.alert,
                                ),
                          ),
                          BrutalButton(
                            text: 'Glitched Dialog',
                            onPressed:
                                () => _showDialog(
                                  context,
                                  BrutalDialogVariant.broken,
                                ),
                            variant: BrutalButtonVariant.broken,
                          ),
                        ],
                      ),
                    ]),

                    // Tabs Section
                    _buildSection('Tabs', [
                      BrutalText.heading3('Standard Tabs'),
                      SizedBox(height: theme.spacing),
                      BrutalTabs(
                        tabs: [
                          BrutalTabItem(
                            title: 'Tab 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText.heading3('Content of Tab 1'),
                                  SizedBox(height: theme.spacing),
                                  BrutalText(
                                    'This is the content of the first tab. Tabs are useful for organizing related information.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BrutalTabItem(
                            title: 'Tab 2',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText.heading3('Content of Tab 2'),
                                  SizedBox(height: theme.spacing),
                                  BrutalButton(
                                    text: 'A button in Tab 2',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BrutalTabItem(
                            title: 'Tab 3',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText('Content of the third tab.'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Minimal Tabs'),
                      SizedBox(height: theme.spacing),
                      Container(
                        decoration: BoxDecoration(color: theme.colors.surface),
                        child: Column(
                          children: [
                            BrutalTabBar.minimal(
                              tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
                              selectedIndex: _minimalTabIndex,
                              onTabSelected: (index) {
                                setState(() {
                                  _minimalTabIndex = index;
                                });
                              },
                            ),
                            Container(
                              height: 100,
                              padding: EdgeInsets.all(theme.spacing),
                              child: Center(
                                child: BrutalText(
                                  'Content of Tab ${_minimalTabIndex + 1}',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Tabs with broken effect'),
                      SizedBox(height: theme.spacing),
                      BrutalTabs(
                        tabs: [
                          BrutalTabItem(
                            title: 'Broken 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Content with broken and glitch effect.',
                                isGlitched: true,
                              ),
                            ),
                          ),
                          BrutalTabItem(
                            title: 'Broken 2',
                            content: Container(),
                          ),
                        ],
                        isJagged: true,
                        isGlitched: true,
                        variant: BrutalTabVariant.broken,
                      ),
                    ]),

                    // Badges and Indicators Section
                    _buildSection('Badges and Indicators', [
                      BrutalText.heading3('Badges'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing * 2,
                        runSpacing: theme.spacing * 2,
                        children: [
                          BrutalBadge(label: 'New', isStandalone: true),
                          BrutalBadge(
                            label: '5',
                            isStandalone: true,
                            variant: BrutalBadgeVariant.error,
                          ),
                          BrutalBadge(
                            label: 'Promo',
                            isStandalone: true,
                            variant: BrutalBadgeVariant.secondary,
                          ),
                          BrutalBadge(
                            label: 'Info',
                            isStandalone: true,
                            variant: BrutalBadgeVariant.minimal,
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BrutalBadge(
                            child: BrutalButton(
                              text: 'Notifications',
                              onPressed: () {},
                            ),
                            label: '3',
                            position: BrutalBadgePosition.topRight,
                            variant: BrutalBadgeVariant.error,
                          ),
                          BrutalBadge(
                            child: BrutalContainer(
                              width: 80,
                              height: 80,
                              child: Center(child: BrutalText('Element')),
                            ),
                            label: 'NEW',
                            position: BrutalBadgePosition.topLeft,
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Progress indicators
                      BrutalText.heading3('Progress Bars'),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar(
                        value: 0.7,
                        label: 'Progress: 70%',
                        showPercentage: true,
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar.minimal(value: 0.4, label: 'Minimal'),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar.broken(
                        value: 0.6,
                        label: 'Broken style',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar(label: 'Indeterminate'),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Spinners'),
                      SizedBox(height: theme.spacing),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              BrutalProgressSpinner(size: 40),
                              SizedBox(height: 8),
                              BrutalText.caption('Default'),
                            ],
                          ),
                          Column(
                            children: [
                              BrutalProgressSpinner(value: 0.7, size: 40),
                              SizedBox(height: 8),
                              BrutalText.caption('Determinate'),
                            ],
                          ),
                          Column(
                            children: [
                              BrutalProgressSpinner.broken(size: 40),
                              SizedBox(height: 8),
                              BrutalText.caption('Broken'),
                            ],
                          ),
                          Column(
                            children: [
                              BrutalProgressSpinner.pixel(size: 40),
                              SizedBox(height: 8),
                              BrutalText.caption('Pixel'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalContainer(
                        padding: EdgeInsets.all(theme.spacing),
                        child: Center(
                          child: BrutalLoading(
                            message: 'Loading resources...',
                            spinnerSize: 50,
                            variant: BrutalProgressVariant.broken,
                            isGlitched: true,
                            fullScreen: false,
                          ),
                        ),
                      ),
                    ]),

                    SizedBox(height: theme.spacing * 3),
                    Center(
                      child: BrutalText.caption(
                        '© 2025 Brutal UI - A brutalist design system',
                        variant: BrutalTextVariant.subtle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper to determine if a theme is currently selected
  bool _isCurrentTheme(BrutalTheme current, BrutalTheme compare) {
    // Improved comparison for all themes
    if (current == BrutalTheme.defaultTheme &&
        compare == BrutalTheme.defaultTheme) {
      return true;
    }
    if (current == BrutalTheme.darkTheme && compare == BrutalTheme.darkTheme) {
      return true;
    }
    if (current == BrutalTheme.neonTheme && compare == BrutalTheme.neonTheme) {
      return true;
    }
    if (current == BrutalTheme.minimalTheme &&
        compare == BrutalTheme.minimalTheme) {
      return true;
    }
    if (current == BrutalTheme.typewriterTheme &&
        compare == BrutalTheme.typewriterTheme) {
      return true;
    }
    // Comparison for new themes
    if (current == BrutalTheme.retroTheme &&
        compare == BrutalTheme.retroTheme) {
      return true;
    }
    if (current == BrutalTheme.vaporwaveTheme &&
        compare == BrutalTheme.vaporwaveTheme) {
      return true;
    }
    if (current == BrutalTheme.cyberpunkTheme &&
        compare == BrutalTheme.cyberpunkTheme) {
      return true;
    }
    if (current == BrutalTheme.constructionTheme &&
        compare == BrutalTheme.constructionTheme) {
      return true;
    }
    return false;
  }

  Widget _buildSection(String title, List<Widget> children) {
    final theme = BrutalTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrutalText.heading2(title),
        SizedBox(height: theme.spacing / 2),
        BrutalDivider(),
        SizedBox(height: theme.spacing),
        ...children,
        SizedBox(height: theme.spacing * 3),
      ],
    );
  }
}

/// Widget to provide text directionality
class DirectionalityProvider extends StatelessWidget {
  final Widget child;
  final TextDirection textDirection;

  const DirectionalityProvider({
    super.key,
    required this.child,
    required this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection: textDirection, child: child);
  }
}
