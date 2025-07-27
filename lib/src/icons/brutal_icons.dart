import 'package:flutter/material.dart';
import '../theme/brutal_theme.dart';
import '../effects/brutal_effects.dart';

/// Sistema de iconografía brutalista
///
/// Iconos únicos diseñados para romper las expectativas visuales
/// y crear una identidad visual agresiva y memorable

class BrutalIcons {
  // =============== ICONOS BÁSICOS BRUTALES ===============

  static const IconData skull = IconData(0xe900, fontFamily: 'BrutalIcons');
  static const IconData lightning = IconData(0xe901, fontFamily: 'BrutalIcons');
  static const IconData explosion = IconData(0xe902, fontFamily: 'BrutalIcons');
  static const IconData chainsaw = IconData(0xe903, fontFamily: 'BrutalIcons');
  static const IconData spikes = IconData(0xe904, fontFamily: 'BrutalIcons');
  static const IconData broken = IconData(0xe905, fontFamily: 'BrutalIcons');
  static const IconData glitch = IconData(0xe906, fontFamily: 'BrutalIcons');
  static const IconData matrix = IconData(0xe907, fontFamily: 'BrutalIcons');
  static const IconData cyberpunk = IconData(0xe908, fontFamily: 'BrutalIcons');
  static const IconData apocalypse = IconData(
    0xe909,
    fontFamily: 'BrutalIcons',
  );

  // =============== ICONOS DE SISTEMA BRUTAL ===============

  static const IconData brutalHome = IconData(
    0xe910,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalSettings = IconData(
    0xe911,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalProfile = IconData(
    0xe912,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalNotification = IconData(
    0xe913,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalMessage = IconData(
    0xe914,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalSearch = IconData(
    0xe915,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalMenu = IconData(
    0xe916,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalClose = IconData(
    0xe917,
    fontFamily: 'BrutalIcons',
  );
  static const IconData brutalAdd = IconData(0xe918, fontFamily: 'BrutalIcons');
  static const IconData brutalDelete = IconData(
    0xe919,
    fontFamily: 'BrutalIcons',
  );

  // =============== ICONOS DE ACCIÓN BRUTAL ===============

  static const IconData attack = IconData(0xe920, fontFamily: 'BrutalIcons');
  static const IconData defend = IconData(0xe921, fontFamily: 'BrutalIcons');
  static const IconData destroy = IconData(0xe922, fontFamily: 'BrutalIcons');
  static const IconData create = IconData(0xe923, fontFamily: 'BrutalIcons');
  static const IconData hack = IconData(0xe924, fontFamily: 'BrutalIcons');
  static const IconData virus = IconData(0xe925, fontFamily: 'BrutalIcons');
  static const IconData shield = IconData(0xe926, fontFamily: 'BrutalIcons');
  static const IconData sword = IconData(0xe927, fontFamily: 'BrutalIcons');
  static const IconData bomb = IconData(0xe928, fontFamily: 'BrutalIcons');
  static const IconData rocket = IconData(0xe929, fontFamily: 'BrutalIcons');
}

/// Widget para iconos brutales con efectos visuales
class BrutalIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final BrutalIconVariant variant;
  final bool hasGlow;
  final bool isAnimated;
  final double intensity;

  const BrutalIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.variant = BrutalIconVariant.standard,
    this.hasGlow = false,
    this.isAnimated = false,
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final iconColor = color ?? theme.colors.primary;
    final iconSize = size ?? 24.0;

    Widget icon = Icon(this.icon, size: iconSize, color: iconColor);

    // Aplicar variante
    switch (variant) {
      case BrutalIconVariant.standard:
        break;
      case BrutalIconVariant.glitch:
        icon = BrutalEffects.glitch(
          intensity: intensity,
          isAnimated: isAnimated,
          child: icon,
        );
        break;
      case BrutalIconVariant.neon:
        icon = BrutalEffects.neonGlow(
          glowColor: iconColor,
          glowRadius: iconSize * 0.5,
          isPulsing: isAnimated,
          intensity: intensity,
          child: icon,
        );
        break;
      case BrutalIconVariant.electric:
        icon = BrutalEffects.staticElectricity(
          electricColor: iconColor,
          intensity: intensity,
          isAnimated: isAnimated,
          child: icon,
        );
        break;
      case BrutalIconVariant.destructive:
        icon = BrutalEffects.violentShake(
          intensity: intensity * 3,
          isContinuous: isAnimated,
          child: BrutalEffects.colorInvert(
            intensity: 0.3,
            isFlickering: isAnimated,
            child: icon,
          ),
        );
        break;
      case BrutalIconVariant.hologram:
        icon = BrutalEffects.hologram(
          interferenceIntensity: intensity * 0.3,
          isShimmering: isAnimated,
          child: icon,
        );
        break;
      case BrutalIconVariant.apocalyptic:
        icon = BrutalEffects.apocalypse(intensity: intensity, child: icon);
        break;
    }

    // Añadir glow adicional si se solicita
    if (hasGlow) {
      icon = BrutalEffects.neonGlow(
        glowColor: iconColor,
        glowRadius: iconSize * 0.3,
        isPulsing: false,
        child: icon,
      );
    }

    return icon;
  }
}

enum BrutalIconVariant {
  standard,
  glitch,
  neon,
  electric,
  destructive,
  hologram,
  apocalyptic,
}

/// Generador de iconos ASCII brutales
class BrutalAsciiIcon extends StatelessWidget {
  final String ascii;
  final double size;
  final Color? color;
  final bool hasGlow;
  final bool isAnimated;

  const BrutalAsciiIcon({
    super.key,
    required this.ascii,
    this.size = 24.0,
    this.color,
    this.hasGlow = false,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final iconColor = color ?? theme.colors.primary;

    Widget icon = Text(
      ascii,
      style: TextStyle(
        fontFamily: 'Courier New',
        fontSize: size,
        color: iconColor,
        fontWeight: FontWeight.bold,
      ),
    );

    if (hasGlow) {
      icon = BrutalEffects.neonGlow(
        glowColor: iconColor,
        glowRadius: size * 0.3,
        isPulsing: isAnimated,
        child: icon,
      );
    }

    if (isAnimated) {
      icon = BrutalEffects.glitch(intensity: 0.5, child: icon);
    }

    return icon;
  }

  // =============== ICONOS ASCII PREDEFINIDOS ===============

  static const String skull = '''
    ▄▄▄▄▄▄▄▄▄
   ▄█▀▀▀▀▀▀▀█▄
  ▄█▀ ▄▄ ▄▄ ▀█▄
 ▄█▀  ██  ██  ▀█▄
▄█▀    ▀▀▀▀    ▀█▄
█▀      ▄▄      ▀█
█      ▄██▄      █
█▄    ▀▀▀▀▀▀    ▄█
 █▄▄▄▄▄▄▄▄▄▄▄▄▄█
  ▀▀▀▀▀▀▀▀▀▀▀▀▀''';

  static const String lightning = '''
    ▄█
   ▄██
  ▄███
 ▄████▄▄▄▄▄
▄█████████▄
██████████▀
█████████▀
████████▀
███████▀
██████▀
█████▀
████▀
███▀
██▀
█▀''';

  static const String explosion = '''
      ▄█▄
   ▄██▄█▄██▄
  ▄███████████▄
 ▄█████████████▄
▄███████████████▄
███████████████
▀███████████████▀
 ▀█████████████▀
  ▀███████████▀
   ▀██▄█▄██▀
      ▀█▀''';

  static const String glitch = '''
█▀▀▀█▄▄▄█▀▀▀█
█▄▄▄█▀▀▀█▄▄▄█
█▀▀▀█▄▄▄█▀▀▀█
█▄▄▄█▀▀▀█▄▄▄█
█▀▀▀█▄▄▄█▀▀▀█
█▄▄▄█▀▀▀█▄▄▄█''';

  static const String matrix = '''
01001001
10110010
01101001
10010110
01100101
10011010
01010110
10101001''';

  static const String cyberpunk = '''
▄▄▄▄▄▄▄▄▄▄▄▄▄
█▀▀▀▀▀▀▀▀▀▀▀█
█ ▄▄▄ ▄▄▄ ▄▄█
█ ███ ███ ███
█ ▀▀▀ ▀▀▀ ▀▀█
█▄▄▄▄▄▄▄▄▄▄▄█
▀▀▀▀▀▀▀▀▀▀▀▀▀''';

  static const String bomb = '''
      ▄▄▄
    ▄▄█▀▀▀█▄▄
   ▄█▀ ▄▄▄ ▀█▄
  ▄█▀▄█████▄▀█▄
 ▄█▀▄███████▄▀█▄
▄█▀▄█████████▄▀█▄
█▀▄███████████▄▀█
█▄▀█████████▀▄█
 █▄▀███████▀▄█
  █▄▀█████▀▄█
   █▄▀███▀▄█
    █▄▀█▀▄█
     █▄▄▄█''';

  static const String virus = '''
    ▄▄▄▄▄▄▄
  ▄██▀▀▀▀▀██▄
 ▄█▀ ▄███▄ ▀█▄
▄█▀ ▄█████▄ ▀█▄
█▀ ▄███████▄ ▀█
█ ▄█████████▄ █
█▄▀█████████▀▄█
▀█▄▀███████▀▄█▀
 ▀█▄▀█████▀▄█▀
  ▀█▄▀███▀▄█▀
   ▀██▄▄▄██▀
    ▀▀▀▀▀▀▀''';

  static const String chainsaw = '''
█████████████████
█▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
█████████████████
█▀▀▀▀▀▀▀▀▀▀▀▀▀▀█
█████████████████
█▄▄▄▄▄▄▄▄▄▄▄▄▄▄█
█████████████████
    ████████
    ████████
    ████████''';
}

/// Conjunto de iconos para diferentes categorías brutales
class BrutalIconSet {
  // =============== NAVEGACIÓN BRUTAL ===============

  static List<IconData> get navigation => [
    BrutalIcons.brutalHome,
    BrutalIcons.brutalSettings,
    BrutalIcons.brutalProfile,
    BrutalIcons.brutalSearch,
    BrutalIcons.brutalMenu,
  ];

  // =============== ACCIONES DESTRUCTIVAS ===============

  static List<IconData> get destructive => [
    BrutalIcons.attack,
    BrutalIcons.destroy,
    BrutalIcons.bomb,
    BrutalIcons.explosion,
    BrutalIcons.chainsaw,
  ];

  // =============== TECNOLOGÍA BRUTAL ===============

  static List<IconData> get technology => [
    BrutalIcons.hack,
    BrutalIcons.virus,
    BrutalIcons.glitch,
    BrutalIcons.matrix,
    BrutalIcons.cyberpunk,
  ];

  // =============== EFECTOS VISUALES ===============

  static List<IconData> get effects => [
    BrutalIcons.lightning,
    BrutalIcons.spikes,
    BrutalIcons.broken,
    BrutalIcons.skull,
    BrutalIcons.apocalypse,
  ];
}

/// Widget para crear grids de iconos brutales
class BrutalIconGrid extends StatelessWidget {
  final List<IconData> icons;
  final Function(IconData)? onIconTap;
  final int crossAxisCount;
  final double iconSize;
  final BrutalIconVariant variant;
  final bool hasEffects;

  const BrutalIconGrid({
    super.key,
    required this.icons,
    this.onIconTap,
    this.crossAxisCount = 4,
    this.iconSize = 32.0,
    this.variant = BrutalIconVariant.standard,
    this.hasEffects = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: theme.spacing,
        mainAxisSpacing: theme.spacing,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];

        Widget iconWidget = Container(
          decoration: BoxDecoration(
            color: theme.colors.surface,
            border: Border.all(
              color: theme.colors.border,
              width: theme.borderWidth,
            ),
          ),
          child: Center(
            child: BrutalIcon(
              icon,
              size: iconSize,
              variant: variant,
              hasGlow: hasEffects,
              isAnimated: hasEffects,
            ),
          ),
        );

        if (onIconTap != null) {
          iconWidget = GestureDetector(
            onTap: () => onIconTap!(icon),
            child: iconWidget,
          );
        }

        return iconWidget;
      },
    );
  }
}

/// Picker de iconos brutal con efectos
class BrutalIconPicker extends StatefulWidget {
  final Function(IconData) onIconSelected;
  final List<IconData> icons;
  final String title;

  const BrutalIconPicker({
    super.key,
    required this.onIconSelected,
    required this.icons,
    this.title = 'SELECT BRUTAL ICON',
  });

  @override
  State<BrutalIconPicker> createState() => _BrutalIconPickerState();
}

class _BrutalIconPickerState extends State<BrutalIconPicker> {
  IconData? _selectedIcon;

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return Container(
      padding: EdgeInsets.all(theme.spacing * 2),
      decoration: BoxDecoration(
        color: theme.colors.background,
        border: Border.all(
          color: theme.colors.border,
          width: theme.borderWidth * 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título
          Text(
            widget.title,
            style: theme.typography.heading2.copyWith(letterSpacing: 2),
          ),

          SizedBox(height: theme.spacing * 2),

          // Grid de iconos
          BrutalIconGrid(
            icons: widget.icons,
            onIconTap: (icon) {
              setState(() {
                _selectedIcon = icon;
              });
              widget.onIconSelected(icon);
            },
            hasEffects: true,
            variant: BrutalIconVariant.neon,
          ),

          if (_selectedIcon != null) ...[
            SizedBox(height: theme.spacing * 2),

            // Vista previa del icono seleccionado
            Container(
              padding: EdgeInsets.all(theme.spacing),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                border: Border.all(
                  color: theme.colors.primary,
                  width: theme.borderWidth * 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SELECTED: ',
                    style: theme.typography.caption.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: theme.spacing),
                  BrutalIcon(
                    _selectedIcon!,
                    size: 32,
                    variant: BrutalIconVariant.glitch,
                    hasGlow: true,
                    isAnimated: true,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Extensiones para iconos Material con efectos brutales
extension BrutalMaterialIcons on Icons {
  static Widget brutal(
    IconData icon, {
    double? size,
    Color? color,
    BrutalIconVariant variant = BrutalIconVariant.standard,
    bool hasGlow = false,
    bool isAnimated = false,
    double intensity = 1.0,
  }) {
    return BrutalIcon(
      icon,
      size: size,
      color: color,
      variant: variant,
      hasGlow: hasGlow,
      isAnimated: isAnimated,
      intensity: intensity,
    );
  }
}
