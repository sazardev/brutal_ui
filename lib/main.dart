import 'package:flutter/widgets.dart';
import 'brutal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BrutalApp(theme: BrutalTheme.darkTheme, child: const ShowcasePage());
  }
}

class ShowcasePage extends StatefulWidget {
  const ShowcasePage({super.key});

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

                  // Sección Layouts (NUEVA)
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
