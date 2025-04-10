import 'package:flutter/widgets.dart';
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
  // Tema actual que podemos cambiar
  BrutalTheme _currentTheme = BrutalTheme.darkTheme;

  // Método para cambiar de tema
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
    'Elemento brutalista 1',
    'Elemento brutalista 2',
    'Elemento brutalista 3',
    'Elemento brutalista 4',
    'Elemento brutalista 5',
  ];

  // Controladores para demostración de componentes interactivos
  bool _checkboxValue1 = true;
  bool _checkboxValue2 = false;
  bool _toggleValue = true;
  String _radioValue = 'opcion1';

  // Mostrar un Toast
  void _showToast(BuildContext context, BrutalToastVariant variant) {
    String mensaje = '';
    Widget? iconWidget;

    switch (variant) {
      case BrutalToastVariant.success:
        mensaje = 'Operación exitosa';
        iconWidget = const Icon(IconData(0xe876, fontFamily: 'MaterialIcons'));
        BrutalToasts.showSuccess(context, mensaje, icon: iconWidget);
        break;
      case BrutalToastVariant.error:
        mensaje = 'Ha ocurrido un error';
        iconWidget = const Icon(IconData(0xe237, fontFamily: 'MaterialIcons'));
        BrutalToasts.showError(context, mensaje, icon: iconWidget);
        break;
      case BrutalToastVariant.warning:
        mensaje = 'Precaución: acción en curso';
        iconWidget = const Icon(IconData(0xe002, fontFamily: 'MaterialIcons'));
        BrutalToasts.showWarning(context, mensaje, icon: iconWidget);
        break;
      case BrutalToastVariant.glitch:
        mensaje = 'Error en el sistema';
        iconWidget = const Icon(IconData(0xe3e0, fontFamily: 'MaterialIcons'));
        BrutalToasts.show(
          context,
          mensaje,
          icon: iconWidget,
          variant: BrutalToastVariant.glitch,
        );
        break;
      default:
        mensaje = 'Mensaje informativo';
        iconWidget = const Icon(IconData(0xe3e0, fontFamily: 'MaterialIcons'));
        BrutalToasts.show(context, mensaje, icon: iconWidget);
    }
  }

  // Mostrar un Dialog
  void _showDialog(BuildContext context, BrutalDialogVariant variant) {
    BrutalDialog dialog;

    switch (variant) {
      case BrutalDialogVariant.alert:
        dialog = BrutalDialog.alert(
          title: 'Alerta',
          content: BrutalText(
            'Esta es una alerta importante que requiere tu atención.',
          ),
          onConfirm: () => Navigator.of(context).pop(),
          confirmText: 'Entendido',
        );
        break;
      case BrutalDialogVariant.broken:
        dialog = BrutalDialog.glitched(
          title: 'Error del Sistema',
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BrutalText(
                'Se ha producido un error inesperado en el sistema.',
                isGlitched: true,
              ),
              SizedBox(height: 8),
              BrutalText.caption(
                'Código: 0xBF34A',
                variant: BrutalTextVariant.subtle,
              ),
            ],
          ),
          actions: [
            BrutalDialogAction(
              label: 'Reintentar',
              onPressed: () => Navigator.of(context).pop(),
              isDefault: true,
            ),
            BrutalDialogAction(
              label: 'Cancelar',
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
        break;
      default:
        dialog = BrutalDialog.confirm(
          title: 'Confirmación',
          content: BrutalText(
            '¿Estás seguro de que deseas continuar con esta acción?',
          ),
          onConfirm: () => Navigator.of(context).pop(),
          onCancel: () => Navigator.of(context).pop(),
          confirmText: 'Confirmar',
          cancelText: 'Cancelar',
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
                    // Encabezado
                    BrutalText.display('Brutal UI', isGlitched: true),
                    SizedBox(height: theme.spacing),
                    BrutalText('Un sistema de diseño brutalista para Flutter'),
                    SizedBox(height: theme.spacing * 3),

                    // Sección Temas
                    _buildSection('Temas', [
                      BrutalText('Selecciona un tema:'),
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
                            text: 'Neón',
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
                          // Nuevos botones para los temas adicionales
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
                            text: 'Construcción',
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

                    // Sección Layouts
                    _buildSection('Layouts Brutales', [
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
                      BrutalText('Con efecto jagged:'),
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
                            BrutalText('Elemento 1'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Elemento 2'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Elemento 3'),
                          ],
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('Con efecto glitched:'),
                      SizedBox(height: theme.spacing / 2),
                      Center(
                        child: BrutalColumn(
                          isGlitched: true,
                          padding: EdgeInsets.all(theme.spacing),
                          children: [
                            BrutalText('Elemento 1'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Elemento 2'),
                            SizedBox(height: theme.spacing / 2),
                            BrutalText('Elemento 3'),
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
                      BrutalText('Con efecto skewed:'),
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
                      BrutalText('Lista horizontal:'),
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
                                child: Center(child: BrutalText('Atrás')),
                              ),
                              Positioned(
                                top: 15,
                                left: 35,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.5),
                                  child: Center(child: BrutalText('Medio')),
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
                                  child: Center(child: BrutalText('Frente')),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('Con rotación:'),
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
                                child: Center(child: BrutalText('Atrás')),
                              ),
                              Positioned(
                                top: 15,
                                left: 35,
                                child: BrutalContainer(
                                  width: 100,
                                  height: 70,
                                  backgroundColor: theme.colors.primary
                                      .withOpacity(0.5),
                                  child: Center(child: BrutalText('Medio')),
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
                                  child: Center(child: BrutalText('Frente')),
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
                          BrutalChip(label: 'Etiqueta 1'),
                          BrutalChip(label: 'Etiqueta 2'),
                          BrutalChip(label: 'Etiqueta grande 3'),
                          BrutalChip(label: 'Etiq 4'),
                          BrutalChip(label: 'Etiqueta 5'),
                          BrutalChip(label: 'Etiqueta larga 6'),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalText('Con efecto jagged:'),
                      SizedBox(height: theme.spacing / 2),
                      BrutalWrapper(
                        hasBorder: true,
                        isJagged: true,
                        padding: EdgeInsets.all(theme.spacing),
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalChip(label: 'Etiqueta 1'),
                          BrutalChip(label: 'Etiqueta 2'),
                          BrutalChip(label: 'Etiqueta grande 3'),
                          BrutalChip(label: 'Etiq 4'),
                          BrutalChip(label: 'Etiqueta 5'),
                          BrutalChip(label: 'Etiqueta larga 6'),
                        ],
                      ),
                    ]),

                    // Sección Tipografía
                    _buildSection('Tipografía', [
                      BrutalText.heading1('Heading 1'),
                      BrutalText.heading2('Heading 2'),
                      BrutalText.heading3('Heading 3'),
                      BrutalText('Texto normal (body)'),
                      BrutalText.caption('Caption'),
                      BrutalText.mono('Monospace text'),
                      SizedBox(height: theme.spacing),
                      BrutalText(
                        'Texto marcado',
                        variant: BrutalTextVariant.marked,
                      ),
                      BrutalText('Texto glitcheado', isGlitched: true),
                    ]),

                    // Sección Botones
                    _buildSection('Botones', [
                      Wrap(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(text: 'Estándar', onPressed: () {}),
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

                    // Sección Contenedores
                    _buildSection('Contenedores', [
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

                    // Sección Inputs
                    _buildSection('Inputs', [
                      BrutalInput(
                        label: 'Input estándar',
                        controller: _textController,
                        placeholder: 'Escribe aquí...',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalInput.search(placeholder: 'Buscar...'),
                      SizedBox(height: theme.spacing),
                      BrutalInput.code(
                        label: 'Input de código',
                        controller: TextEditingController(
                          text: 'console.log("Brutal");',
                        ),
                      ),
                    ]),

                    // Sección Interactivos
                    _buildSection('Componentes Interactivos', [
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
                        label: 'Toggle (variante broken)',
                        variant: BrutalToggleVariant.broken,
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Radio Buttons
                      BrutalText.heading3('Radio Buttons'),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'opcion1',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Opción 1',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'opcion2',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Opción 2',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalRadio(
                        value: 'opcion3',
                        groupValue: _radioValue,
                        onChanged: (value) {
                          setState(() {
                            _radioValue = value;
                          });
                        },
                        label: 'Opción 3 (variante square)',
                        variant: BrutalRadioVariant.square,
                      ),
                    ]),

                    // Sección Acordeones
                    _buildSection('Acordeones', [
                      BrutalText.heading3('Acordeones individuales'),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion(
                        title: 'Acordeón estándar',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'Este es el contenido del acordeón. Se expande y contrae al hacer clic en el título.',
                          ),
                        ),
                        initiallyExpanded: true,
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion.minimal(
                        title: 'Acordeón minimalista',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'Este acordeón tiene un estilo minimalista sin bordes completos.',
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAccordion.broken(
                        title: 'Acordeón broken',
                        content: Padding(
                          padding: EdgeInsets.all(theme.spacing),
                          child: BrutalText(
                            'Este acordeón tiene un estilo "roto" con rotación y efectos glitch.',
                            isGlitched: true,
                          ),
                        ),
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Grupo de acordeones'),
                      SizedBox(height: theme.spacing),
                      BrutalAccordionGroup(
                        items: [
                          BrutalAccordionItem(
                            title: 'Sección 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Contenido de la primera sección del grupo de acordeones.',
                              ),
                            ),
                          ),
                          BrutalAccordionItem(
                            title: 'Sección 2',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Contenido de la segunda sección del grupo de acordeones.',
                              ),
                            ),
                          ),
                          BrutalAccordionItem(
                            title: 'Sección 3',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText(
                                    'Contenido con múltiples elementos',
                                  ),
                                  SizedBox(height: theme.spacing),
                                  BrutalButton(
                                    text: 'Un botón dentro del acordeón',
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

                    // Sección Tarjetas
                    _buildSection('Tarjetas', [
                      BrutalText.heading3('Variantes de tarjetas'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing * 2,
                        runSpacing: theme.spacing * 2,
                        children: [
                          BrutalCard(
                            width: 200,
                            title: 'Tarjeta estándar',
                            subtitle: 'Con título y subtítulo',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'Contenido de la tarjeta con estilo por defecto.',
                              ),
                            ),
                          ),
                          BrutalCard.featured(
                            width: 200,
                            title: 'Tarjeta destacada',
                            subtitle: 'Con sombra más intensa',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'Esta tarjeta tiene un estilo más prominente para contenido destacado.',
                              ),
                            ),
                          ),
                          BrutalCard.glitch(
                            width: 200,
                            title: 'Tarjeta glitch',
                            subtitle: 'Con efectos de error',
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: theme.spacing,
                              ),
                              child: BrutalText(
                                'Esta tarjeta simula errores visuales para un efecto brutalist.',
                                isGlitched: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalCard(
                        title: 'Tarjeta con acciones',
                        subtitle:
                            'Ejemplo de tarjeta con componentes interactivos',
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
                          text: 'Acción',
                          onPressed: () {},
                          variant: BrutalButtonVariant.primary,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: theme.spacing,
                          ),
                          child: BrutalText(
                            'Esta es una tarjeta con un icono de avatar, un título, un subtítulo y un botón de acción.',
                          ),
                        ),
                      ),
                    ]),

                    // Sección Alertas
                    _buildSection('Alertas y Notificaciones', [
                      BrutalText.heading3('Alertas'),
                      SizedBox(height: theme.spacing),
                      BrutalAlert(
                        title: 'Alerta informativa',
                        message: 'Este es un mensaje informativo general.',
                        icon: Icon(
                          IconData(0xe3e0, fontFamily: 'MaterialIcons'),
                        ),
                        variant: BrutalAlertVariant.info,
                        onClose: () {},
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.success(
                        title: 'Operación exitosa',
                        message: 'Los datos se han guardado correctamente.',
                        icon: Icon(
                          IconData(0xe876, fontFamily: 'MaterialIcons'),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.warning(
                        title: 'Advertencia',
                        message: 'Este proceso puede tardar varios minutos.',
                        icon: Icon(
                          IconData(0xe002, fontFamily: 'MaterialIcons'),
                        ),
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalAlert.error(
                        title: 'Error',
                        message: 'No se ha podido conectar al servidor.',
                        icon: Icon(
                          IconData(0xe237, fontFamily: 'MaterialIcons'),
                        ),
                        actions: [
                          BrutalAlertAction(
                            label: 'Reintentar',
                            onPressed: () {},
                            isPrimary: true,
                          ),
                          BrutalAlertAction(
                            label: 'Cancelar',
                            onPressed: () {},
                          ),
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
                            message: 'Este es un tooltip estándar',
                            child: BrutalButton(
                              text: 'Hover',
                              onPressed: () {},
                            ),
                          ),
                          BrutalTooltip(
                            message: 'Tooltip con efecto glitch',
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

                    // Sección Dialogs
                    _buildSection('Diálogos', [
                      BrutalText.heading3('Diálogos modales'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing,
                        runSpacing: theme.spacing,
                        children: [
                          BrutalButton(
                            text: 'Diálogo de confirmación',
                            onPressed:
                                () => _showDialog(
                                  context,
                                  BrutalDialogVariant.default_,
                                ),
                          ),
                          BrutalButton(
                            text: 'Diálogo de alerta',
                            onPressed:
                                () => _showDialog(
                                  context,
                                  BrutalDialogVariant.alert,
                                ),
                          ),
                          BrutalButton(
                            text: 'Diálogo glitched',
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

                    // Sección Pestañas
                    _buildSection('Pestañas', [
                      BrutalText.heading3('Pestañas estándar'),
                      SizedBox(height: theme.spacing),
                      BrutalTabs(
                        tabs: [
                          BrutalTabItem(
                            title: 'Pestaña 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText.heading3(
                                    'Contenido de la pestaña 1',
                                  ),
                                  SizedBox(height: theme.spacing),
                                  BrutalText(
                                    'Este es el contenido de la primera pestaña. Las pestañas son útiles para organizar información relacionada.',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BrutalTabItem(
                            title: 'Pestaña 2',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BrutalText.heading3(
                                    'Contenido de la pestaña 2',
                                  ),
                                  SizedBox(height: theme.spacing),
                                  BrutalButton(
                                    text: 'Un botón en la pestaña 2',
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BrutalTabItem(
                            title: 'Pestaña 3',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Contenido de la tercera pestaña.',
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Pestañas minimalistas'),
                      SizedBox(height: theme.spacing),
                      Container(
                        decoration: BoxDecoration(color: theme.colors.surface),
                        child: Column(
                          children: [
                            BrutalTabBar.minimal(
                              tabs: ['Tab 1', 'Tab 2', 'Tab 3'],
                              selectedIndex: 0,
                              onTabSelected: (_) {},
                            ),
                            Container(
                              height: 100,
                              padding: EdgeInsets.all(theme.spacing),
                              child: Center(
                                child: BrutalText(
                                  'Contenido de pestañas minimalistas',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: theme.spacing * 2),

                      BrutalText.heading3('Pestañas con efecto broken'),
                      SizedBox(height: theme.spacing),
                      BrutalTabs(
                        tabs: [
                          BrutalTabItem(
                            title: 'Broken 1',
                            content: Padding(
                              padding: EdgeInsets.all(theme.spacing),
                              child: BrutalText(
                                'Contenido con efecto broken y glitch.',
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

                    // Sección Badges e Indicadores
                    _buildSection('Badges e Indicadores', [
                      BrutalText.heading3('Badges'),
                      SizedBox(height: theme.spacing),
                      Wrap(
                        spacing: theme.spacing * 2,
                        runSpacing: theme.spacing * 2,
                        children: [
                          BrutalBadge(label: 'Nuevo', isStandalone: true),
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
                              text: 'Notificaciones',
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
                              child: Center(child: BrutalText('Elemento')),
                            ),
                            label: 'NUEVO',
                            position: BrutalBadgePosition.topLeft,
                          ),
                        ],
                      ),
                      SizedBox(height: theme.spacing * 2),

                      // Indicadores de progreso
                      BrutalText.heading3('Barras de progreso'),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar(
                        value: 0.7,
                        label: 'Progreso: 70%',
                        showPercentage: true,
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar.minimal(
                        value: 0.4,
                        label: 'Minimalista',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar.broken(
                        value: 0.6,
                        label: 'Estilo broken',
                      ),
                      SizedBox(height: theme.spacing),
                      BrutalProgressBar(label: 'Indeterminado'),
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
                            message: 'Cargando recursos...',
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
                        '© 2025 Brutal UI - Un design system brutalist',
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

  // Helper para determinar si un tema es el actualmente seleccionado
  bool _isCurrentTheme(BrutalTheme current, BrutalTheme compare) {
    // Comparación mejorada para todos los temas
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
    // Comparación para los nuevos temas
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

/// Widget para proporcionar direccionalidad al texto
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
