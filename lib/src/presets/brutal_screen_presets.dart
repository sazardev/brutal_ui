import 'package:flutter/material.dart';
import '../theme/brutal_theme.dart';
import '../widgets/brutal_extreme_widgets.dart';
import '../effects/brutal_effects.dart';

/// Presets de pantallas completas brutalistas
///
/// Esta colección incluye pantallas pre-diseñadas que demuestran
/// el poder total del brutalismo digital

// =============== BRUTAL SPLASH SCREENS ===============

/// Pantalla de splash brutalista que destruye las expectativas
class BrutalSplashScreen extends StatefulWidget {
  final Widget? logo;
  final String appName;
  final String tagline;
  final Duration splashDuration;
  final VoidCallback? onSplashComplete;
  final BrutalSplashVariant variant;

  const BrutalSplashScreen({
    super.key,
    this.logo,
    required this.appName,
    this.tagline = 'POWERED BY BRUTALITY',
    this.splashDuration = const Duration(seconds: 3),
    this.onSplashComplete,
    this.variant = BrutalSplashVariant.glitchOverload,
  });

  @override
  State<BrutalSplashScreen> createState() => _BrutalSplashScreenState();
}

class _BrutalSplashScreenState extends State<BrutalSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _glitchController;
  late AnimationController _textController;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: widget.splashDuration,
      vsync: this,
    );

    _glitchController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _startSplashSequence();
  }

  void _startSplashSequence() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _glitchController.repeat();
    _textController.forward();

    _mainController.forward().then((_) {
      widget.onSplashComplete?.call();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _glitchController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          // Fondo con efectos
          _buildBackground(theme),

          // Contenido principal
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo con efectos
                if (widget.logo != null) _buildLogo(theme),

                SizedBox(height: theme.spacing * 2),

                // Nombre de la app
                _buildAppName(theme),

                SizedBox(height: theme.spacing),

                // Tagline
                _buildTagline(theme),

                SizedBox(height: theme.spacing * 4),

                // Loading indicator brutal
                _buildLoadingIndicator(theme),
              ],
            ),
          ),

          // Efectos de overlay
          _buildOverlayEffects(theme),
        ],
      ),
    );
  }

  Widget _buildBackground(BrutalTheme theme) {
    switch (widget.variant) {
      case BrutalSplashVariant.glitchOverload:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                theme.colors.background,
                theme.colors.surface,
                theme.colors.background,
              ],
            ),
          ),
          child: BrutalMatrixRain(
            intensity: 0.3,
            rainColor: theme.colors.primary.withOpacity(0.1),
          ),
        );
      case BrutalSplashVariant.terminalHacker:
        return Container(
          color: Colors.black,
          child: BrutalMatrixRain(intensity: 1.0, rainColor: Colors.green),
        );
      case BrutalSplashVariant.apocalyptic:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.red.withOpacity(0.3), Colors.black],
            ),
          ),
        );
      case BrutalSplashVariant.neonOverdrive:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.purple.withOpacity(0.3),
                Colors.black,
                Colors.cyan.withOpacity(0.3),
              ],
            ),
          ),
        );
    }
  }

  Widget _buildLogo(BrutalTheme theme) {
    Widget logo = SizedBox(width: 120, height: 120, child: widget.logo!);

    switch (widget.variant) {
      case BrutalSplashVariant.glitchOverload:
        return AnimatedBuilder(
          animation: _glitchController,
          builder: (context, child) {
            return BrutalEffects.glitch(
              intensity: 2.0,
              child: BrutalEffects.neonGlow(
                glowColor: theme.colors.primary,
                glowRadius: 30,
                isPulsing: true,
                child: logo,
              ),
            );
          },
        );
      case BrutalSplashVariant.terminalHacker:
        return BrutalEffects.hackerTerminal(
          scanlineColor: Colors.green,
          child: logo,
        );
      case BrutalSplashVariant.apocalyptic:
        return BrutalEffects.violentShake(
          intensity: 3,
          isContinuous: true,
          child: BrutalEffects.colorInvert(
            intensity: 0.5,
            isFlickering: true,
            child: logo,
          ),
        );
      case BrutalSplashVariant.neonOverdrive:
        return BrutalEffects.neonGlow(
          glowColor: Colors.cyan,
          glowRadius: 40,
          isPulsing: true,
          child: BrutalEffects.hologram(child: logo),
        );
    }
  }

  Widget _buildAppName(BrutalTheme theme) {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        Widget text = Text(
          widget.appName,
          style: theme.typography.display.copyWith(
            color: theme.colors.primary,
            fontWeight: FontWeight.w900,
            letterSpacing: 5,
          ),
          textAlign: TextAlign.center,
        );

        switch (widget.variant) {
          case BrutalSplashVariant.glitchOverload:
            return Transform.scale(
              scale: 0.5 + (_textController.value * 0.5),
              child: BrutalEffects.textGlitch(
                text: widget.appName,
                style: theme.typography.display.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 5,
                ),
                intensity: 3.0,
              ),
            );
          case BrutalSplashVariant.terminalHacker:
            return TypewriterText(
              text: widget.appName,
              style: theme.typography.display.copyWith(
                color: Colors.green,
                fontFamily: 'Courier New',
              ),
            );
          case BrutalSplashVariant.apocalyptic:
            return BrutalEffects.violentShake(intensity: 2, child: text);
          case BrutalSplashVariant.neonOverdrive:
            return BrutalEffects.neonGlow(
              glowColor: Colors.cyan,
              glowRadius: 20,
              isPulsing: true,
              child: text,
            );
        }
      },
    );
  }

  Widget _buildTagline(BrutalTheme theme) {
    Widget tagline = Text(
      widget.tagline,
      style: theme.typography.body.copyWith(
        color: theme.colors.textLight,
        letterSpacing: 2,
      ),
      textAlign: TextAlign.center,
    );

    if (widget.variant == BrutalSplashVariant.terminalHacker) {
      return TypewriterText(
        text: widget.tagline,
        style: theme.typography.body.copyWith(
          color: Colors.green,
          fontFamily: 'Courier New',
        ),
        delay: const Duration(milliseconds: 1500),
      );
    }

    return tagline;
  }

  Widget _buildLoadingIndicator(BrutalTheme theme) {
    switch (widget.variant) {
      case BrutalSplashVariant.glitchOverload:
        return BrutalDestructionMeter(
          value: _mainController.value,
          label: 'LOADING BRUTALITY',
          destructionColor: theme.colors.primary,
          hasExplosions: true,
        );
      case BrutalSplashVariant.terminalHacker:
        return Container(
          width: 200,
          child: LinearProgressIndicator(
            value: _mainController.value,
            backgroundColor: Colors.green.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation(Colors.green),
          ),
        );
      case BrutalSplashVariant.apocalyptic:
        return BrutalEffects.violentShake(
          intensity: 4,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.red, width: 3),
            ),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red),
            ),
          ),
        );
      case BrutalSplashVariant.neonOverdrive:
        return BrutalEffects.neonGlow(
          glowColor: Colors.cyan,
          isPulsing: true,
          child: Container(
            width: 200,
            child: LinearProgressIndicator(
              value: _mainController.value,
              backgroundColor: Colors.cyan.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation(Colors.cyan),
            ),
          ),
        );
    }
  }

  Widget _buildOverlayEffects(BrutalTheme theme) {
    if (widget.variant == BrutalSplashVariant.terminalHacker) {
      return BrutalEffects.hackerTerminal(
        scanlineColor: Colors.green,
        scanlineOpacity: 0.05,
        child: Container(),
      );
    }
    return Container();
  }
}

enum BrutalSplashVariant {
  glitchOverload,
  terminalHacker,
  apocalyptic,
  neonOverdrive,
}

// =============== BRUTAL LANDING PAGES ===============

/// Landing page brutalista que impacta desde el primer segundo
class BrutalLandingPage extends StatelessWidget {
  final String heroTitle;
  final String heroSubtitle;
  final String ctaText;
  final VoidCallback? onCtaPressed;
  final List<BrutalFeature> features;
  final BrutalLandingVariant variant;

  const BrutalLandingPage({
    super.key,
    required this.heroTitle,
    required this.heroSubtitle,
    required this.ctaText,
    this.onCtaPressed,
    this.features = const [],
    this.variant = BrutalLandingVariant.cyberpunkRebel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          // Fondo con efectos
          _buildBackground(theme),

          // Contenido scrolleable
          SingleChildScrollView(
            child: Column(
              children: [
                // Hero section
                _buildHeroSection(theme),

                // Features section
                if (features.isNotEmpty) _buildFeaturesSection(theme),

                // CTA section
                _buildCtaSection(theme),
              ],
            ),
          ),

          // Efectos de overlay
          _buildOverlayEffects(theme),
        ],
      ),
    );
  }

  Widget _buildBackground(BrutalTheme theme) {
    switch (variant) {
      case BrutalLandingVariant.cyberpunkRebel:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.withOpacity(0.3),
                Colors.black,
                Colors.cyan.withOpacity(0.3),
              ],
            ),
          ),
          child: BrutalMatrixRain(
            intensity: 0.2,
            rainColor: Colors.cyan.withOpacity(0.1),
          ),
        );
      case BrutalLandingVariant.industrialWarzone:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey[900]!,
                Colors.orange.withOpacity(0.3),
                Colors.black,
              ],
            ),
          ),
        );
      case BrutalLandingVariant.neonNightmare:
        return Container(
          color: Colors.black,
          child: BrutalMatrixRain(
            intensity: 1.0,
            rainColor: theme.colors.primary,
          ),
        );
      case BrutalLandingVariant.apocalypticDestruction:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              colors: [Colors.red.withOpacity(0.5), Colors.black],
            ),
          ),
        );
    }
  }

  Widget _buildHeroSection(BrutalTheme theme) {
    return Builder(
      builder:
          (context) => Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(theme.spacing * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título hero con efectos
                _buildHeroTitle(theme),

                SizedBox(height: theme.spacing * 2),

                // Subtítulo
                _buildHeroSubtitle(theme),

                SizedBox(height: theme.spacing * 4),

                // CTA button
                _buildHeroCta(theme),
              ],
            ),
          ),
    );
  }

  Widget _buildHeroTitle(BrutalTheme theme) {
    Widget title = Text(
      heroTitle,
      style: theme.typography.display.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w900,
        letterSpacing: 3,
        height: 0.9,
      ),
      textAlign: TextAlign.center,
    );

    switch (variant) {
      case BrutalLandingVariant.cyberpunkRebel:
        return BrutalEffects.textGlitch(
          text: heroTitle,
          style: theme.typography.display.copyWith(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            height: 0.9,
            color: Colors.cyan,
          ),
          intensity: 4.0,
        );
      case BrutalLandingVariant.industrialWarzone:
        return BrutalEffects.neonGlow(
          glowColor: Colors.orange,
          glowRadius: 25,
          child: title,
        );
      case BrutalLandingVariant.neonNightmare:
        return BrutalEffects.neonGlow(
          glowColor: theme.colors.primary,
          glowRadius: 30,
          isPulsing: true,
          child: BrutalEffects.violentShake(intensity: 2, child: title),
        );
      case BrutalLandingVariant.apocalypticDestruction:
        return BrutalEffects.apocalypse(intensity: 1.5, child: title);
    }
  }

  Widget _buildHeroSubtitle(BrutalTheme theme) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Text(
        heroSubtitle,
        style: theme.typography.heading2.copyWith(
          color: theme.colors.textLight,
          letterSpacing: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildHeroCta(BrutalTheme theme) {
    return BrutalAssaultButton(
      text: ctaText,
      onPressed: onCtaPressed,
      aggressionLevel: 2.0,
      isPulsing: true,
      hasGlitch: variant == BrutalLandingVariant.cyberpunkRebel,
      isViolent: true,
    );
  }

  Widget _buildFeaturesSection(BrutalTheme theme) {
    return Container(
      padding: EdgeInsets.all(theme.spacing * 2),
      child: Column(
        children: [
          Text(
            'BRUTAL FEATURES',
            style: theme.typography.heading1.copyWith(letterSpacing: 4),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: theme.spacing * 3),
          BrutalChaosLayout(
            children:
                features
                    .map((feature) => _buildFeatureCard(feature, theme))
                    .toList(),
            chaosIntensity: 0.3,
            isAnimated: true,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(BrutalFeature feature, BrutalTheme theme) {
    Widget card = Container(
      width: 280,
      padding: EdgeInsets.all(theme.spacing * 1.5),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(
          color: theme.colors.border,
          width: theme.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(feature.icon, color: theme.colors.primary, size: 32),
          SizedBox(height: theme.spacing),
          Text(
            feature.title,
            style: theme.typography.heading3.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: theme.spacing * 0.5),
          Text(
            feature.description,
            style: theme.typography.body.copyWith(
              color: theme.colors.textLight,
            ),
          ),
        ],
      ),
    );

    if (variant == BrutalLandingVariant.cyberpunkRebel) {
      card = BrutalEffects.glitch(intensity: 0.5, child: card);
    }

    return card;
  }

  Widget _buildCtaSection(BrutalTheme theme) {
    return Container(
      height: 300,
      width: double.infinity,
      color: theme.colors.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'READY TO GO BRUTAL?',
              style: theme.typography.heading1.copyWith(
                color: theme.colors.background,
                letterSpacing: 3,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: theme.spacing * 2),
            BrutalAssaultButton(
              text: 'DESTROY THE NORM',
              aggressionLevel: 3.0,
              isPulsing: true,
              hasGlitch: true,
              isViolent: true,
              backgroundColor: theme.colors.background,
              textColor: theme.colors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlayEffects(BrutalTheme theme) {
    if (variant == BrutalLandingVariant.neonNightmare) {
      return BrutalEffects.hackerTerminal(
        scanlineColor: theme.colors.primary,
        scanlineOpacity: 0.03,
        child: Container(),
      );
    }
    return Container();
  }
}

enum BrutalLandingVariant {
  cyberpunkRebel,
  industrialWarzone,
  neonNightmare,
  apocalypticDestruction,
}

class BrutalFeature {
  final IconData icon;
  final String title;
  final String description;

  const BrutalFeature({
    required this.icon,
    required this.title,
    required this.description,
  });
}

// =============== BRUTAL DASHBOARD ===============

/// Dashboard brutalista para aplicaciones de control/monitoreo
class BrutalDashboard extends StatefulWidget {
  final String title;
  final List<BrutalDashboardCard> cards;
  final List<BrutalMetric> metrics;
  final BrutalDashboardVariant variant;

  const BrutalDashboard({
    super.key,
    required this.title,
    this.cards = const [],
    this.metrics = const [],
    this.variant = BrutalDashboardVariant.cyberpunkCommand,
  });

  @override
  State<BrutalDashboard> createState() => _BrutalDashboardState();
}

class _BrutalDashboardState extends State<BrutalDashboard>
    with TickerProviderStateMixin {
  late AnimationController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _refreshController.repeat();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: Stack(
        children: [
          // Fondo con efectos
          _buildBackground(theme),

          // Contenido principal
          Column(
            children: [
              // Header
              _buildHeader(theme),

              // Métricas principales
              _buildMetricsSection(theme),

              // Cards del dashboard
              Expanded(child: _buildCardsSection(theme)),
            ],
          ),

          // Efectos de overlay
          _buildOverlayEffects(theme),
        ],
      ),
    );
  }

  Widget _buildBackground(BrutalTheme theme) {
    switch (widget.variant) {
      case BrutalDashboardVariant.cyberpunkCommand:
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.purple.withOpacity(0.1),
                Colors.black,
                Colors.cyan.withOpacity(0.1),
              ],
            ),
          ),
          child: BrutalMatrixRain(
            intensity: 0.1,
            rainColor: Colors.cyan.withOpacity(0.05),
          ),
        );
      case BrutalDashboardVariant.militaryControl:
        return Container(color: Colors.black);
      case BrutalDashboardVariant.apocalypseMonitor:
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topRight,
              colors: [Colors.red.withOpacity(0.2), Colors.black],
            ),
          ),
        );
    }
  }

  Widget _buildHeader(BrutalTheme theme) {
    Widget header = Container(
      padding: EdgeInsets.all(theme.spacing * 2),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colors.border,
            width: theme.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.title,
              style: theme.typography.heading1.copyWith(letterSpacing: 2),
            ),
          ),
          // Status indicator
          _buildStatusIndicator(theme),
        ],
      ),
    );

    if (widget.variant == BrutalDashboardVariant.cyberpunkCommand) {
      header = BrutalEffects.glitch(intensity: 0.3, child: header);
    }

    return header;
  }

  Widget _buildStatusIndicator(BrutalTheme theme) {
    return AnimatedBuilder(
      animation: _refreshController,
      builder: (context, child) {
        Color statusColor;
        String statusText;

        switch (widget.variant) {
          case BrutalDashboardVariant.cyberpunkCommand:
            statusColor = Colors.cyan;
            statusText = 'ONLINE';
            break;
          case BrutalDashboardVariant.militaryControl:
            statusColor = Colors.green;
            statusText = 'OPERATIONAL';
            break;
          case BrutalDashboardVariant.apocalypseMonitor:
            statusColor = Colors.red;
            statusText = 'CRITICAL';
            break;
        }

        return Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: statusColor,
                boxShadow: [
                  BoxShadow(color: statusColor, blurRadius: 5, spreadRadius: 1),
                ],
              ),
            ),
            SizedBox(width: theme.spacing * 0.5),
            Text(
              statusText,
              style: theme.typography.caption.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMetricsSection(BrutalTheme theme) {
    return Container(
      padding: EdgeInsets.all(theme.spacing),
      child: Row(
        children:
            widget.metrics
                .map(
                  (metric) => Expanded(child: _buildMetricCard(metric, theme)),
                )
                .toList(),
      ),
    );
  }

  Widget _buildMetricCard(BrutalMetric metric, BrutalTheme theme) {
    Widget card = Container(
      margin: EdgeInsets.symmetric(horizontal: theme.spacing * 0.5),
      padding: EdgeInsets.all(theme.spacing),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(
          color: theme.colors.border,
          width: theme.borderWidth,
        ),
      ),
      child: Column(
        children: [
          Text(
            metric.label,
            style: theme.typography.caption.copyWith(
              color: theme.colors.textLight,
            ),
          ),
          SizedBox(height: theme.spacing * 0.5),
          Text(
            metric.value,
            style: theme.typography.heading2.copyWith(
              color: metric.color ?? theme.colors.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );

    if (metric.isAlertMode) {
      card = BrutalEffects.violentShake(
        intensity: 3,
        isContinuous: true,
        child: card,
      );
    }

    return card;
  }

  Widget _buildCardsSection(BrutalTheme theme) {
    return Padding(
      padding: EdgeInsets.all(theme.spacing),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
        ),
        itemCount: widget.cards.length,
        itemBuilder: (context, index) {
          return _buildDashboardCard(widget.cards[index], theme);
        },
      ),
    );
  }

  Widget _buildDashboardCard(BrutalDashboardCard card, BrutalTheme theme) {
    Widget cardWidget = Container(
      padding: EdgeInsets.all(theme.spacing),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        border: Border.all(
          color: theme.colors.border,
          width: theme.borderWidth,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                card.icon,
                color: card.color ?? theme.colors.primary,
                size: 24,
              ),
              SizedBox(width: theme.spacing * 0.5),
              Expanded(
                child: Text(
                  card.title,
                  style: theme.typography.heading3.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing),
          Expanded(child: card.content),
        ],
      ),
    );

    if (card.hasEffects) {
      switch (widget.variant) {
        case BrutalDashboardVariant.cyberpunkCommand:
          cardWidget = BrutalEffects.glitch(intensity: 0.2, child: cardWidget);
          break;
        case BrutalDashboardVariant.militaryControl:
          cardWidget = BrutalEffects.hackerTerminal(
            scanlineColor: Colors.green,
            scanlineOpacity: 0.05,
            child: cardWidget,
          );
          break;
        case BrutalDashboardVariant.apocalypseMonitor:
          cardWidget = BrutalEffects.violentShake(
            intensity: 1,
            child: cardWidget,
          );
          break;
      }
    }

    return cardWidget;
  }

  Widget _buildOverlayEffects(BrutalTheme theme) {
    if (widget.variant == BrutalDashboardVariant.militaryControl) {
      return BrutalEffects.hackerTerminal(
        scanlineColor: Colors.green,
        scanlineOpacity: 0.02,
        child: Container(),
      );
    }
    return Container();
  }
}

enum BrutalDashboardVariant {
  cyberpunkCommand,
  militaryControl,
  apocalypseMonitor,
}

class BrutalDashboardCard {
  final IconData icon;
  final String title;
  final Widget content;
  final Color? color;
  final bool hasEffects;

  const BrutalDashboardCard({
    required this.icon,
    required this.title,
    required this.content,
    this.color,
    this.hasEffects = false,
  });
}

class BrutalMetric {
  final String label;
  final String value;
  final Color? color;
  final bool isAlertMode;

  const BrutalMetric({
    required this.label,
    required this.value,
    this.color,
    this.isAlertMode = false,
  });
}

// =============== BRUTAL UTILITIES ===============

/// Widget de texto que se escribe como máquina de escribir
class TypewriterText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration delay;
  final Duration speed;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.delay = Duration.zero,
    this.speed = const Duration(milliseconds: 50),
  });

  @override
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = '';

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() async {
    await Future.delayed(widget.delay);

    for (int i = 0; i <= widget.text.length; i++) {
      if (mounted) {
        setState(() {
          _displayedText = widget.text.substring(0, i);
        });
        await Future.delayed(widget.speed);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(_displayedText, style: widget.style);
  }
}
