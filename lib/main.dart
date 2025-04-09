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
      child: ShowcasePage(onThemeChanged: _changeTheme),
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
                              () =>
                                  widget.onThemeChanged(BrutalTheme.darkTheme),
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
                              () =>
                                  widget.onThemeChanged(BrutalTheme.neonTheme),
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
                              () =>
                                  widget.onThemeChanged(BrutalTheme.retroTheme),
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
                              _isCurrentTheme(theme, BrutalTheme.vaporwaveTheme)
                                  ? theme.colors.primary
                                  : null,
                          textColor:
                              _isCurrentTheme(theme, BrutalTheme.vaporwaveTheme)
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
                              _isCurrentTheme(theme, BrutalTheme.cyberpunkTheme)
                                  ? theme.colors.primary
                                  : null,
                          textColor:
                              _isCurrentTheme(theme, BrutalTheme.cyberpunkTheme)
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
                            _listItems.map((item) => BrutalText(item)).toList(),
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
                            _listItems.map((item) => BrutalText(item)).toList(),
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
                              backgroundColor: theme.colors.primary.withOpacity(
                                0.2,
                              ),
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
                              backgroundColor: theme.colors.primary.withOpacity(
                                0.2,
                              ),
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
                        BrutalButton.primary(text: 'Primary', onPressed: () {}),
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
    );
  }

  // Helper para determinar si un tema es el actualmente seleccionado
  bool _isCurrentTheme(BrutalTheme current, BrutalTheme compare) {
    // Comparación mejorada para todos los temas
    if (current == BrutalTheme.defaultTheme &&
        compare == BrutalTheme.defaultTheme)
      return true;
    if (current == BrutalTheme.darkTheme && compare == BrutalTheme.darkTheme)
      return true;
    if (current == BrutalTheme.neonTheme && compare == BrutalTheme.neonTheme)
      return true;
    if (current == BrutalTheme.minimalTheme &&
        compare == BrutalTheme.minimalTheme)
      return true;
    if (current == BrutalTheme.typewriterTheme &&
        compare == BrutalTheme.typewriterTheme)
      return true;
    // Comparación para los nuevos temas
    if (current == BrutalTheme.retroTheme && compare == BrutalTheme.retroTheme)
      return true;
    if (current == BrutalTheme.vaporwaveTheme &&
        compare == BrutalTheme.vaporwaveTheme)
      return true;
    if (current == BrutalTheme.cyberpunkTheme &&
        compare == BrutalTheme.cyberpunkTheme)
      return true;
    if (current == BrutalTheme.constructionTheme &&
        compare == BrutalTheme.constructionTheme)
      return true;
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
