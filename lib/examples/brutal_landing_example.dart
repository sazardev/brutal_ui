import 'package:flutter/material.dart';
import '../brutal.dart';

void main() {
  runApp(const BrutalLandingExample());
}

class BrutalLandingExample extends StatelessWidget {
  const BrutalLandingExample({super.key});

  @override
  Widget build(BuildContext context) {
    return BrutalApp(
      theme: BrutalTheme.minimalTheme,
      child: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    return BrutalScaffold(
      appBar: BrutalAppBar(
        title: BrutalText(
          "BRUTAL UI",
          isGlitched: true,
          brutalStyle: BrutalTextStyle.heading2,
        ),
        actions: [
          BrutalButton.primary(text: "Features", onPressed: () {}),
          BrutalButton.secondary(text: "Docs", onPressed: () {}),
          BrutalButton.destructive(text: "Download", onPressed: () {}),
        ],
      ),
      body: BrutalResponsiveBuilder(
        builder: (context, screenType) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Hero section
                _buildHeroSection(theme, screenType),

                // Features section
                _buildFeatureSection(theme, screenType),

                // Themes showcase
                _buildThemeShowcase(theme, screenType),

                // Components showcase
                _buildComponentShowcase(theme),

                // FAQ section
                _buildFaqSection(theme),

                // CTA section
                _buildCtaSection(theme),

                // Footer
                _buildFooter(theme),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(BrutalTheme theme, BrutalScreenType screenType) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 4),
      hasShadow: true,
      child: BrutalStack(
        isGlitched: true,
        children: [
          BrutalAdaptivePanel.centered(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrutalText.display(
                  "BRUTAL UI",
                  isGlitched: true,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spacing),
                BrutalText(
                  "A brutalist design system for Flutter",
                  textAlign: TextAlign.center,
                  brutalStyle: BrutalTextStyle.heading3,
                ),
                SizedBox(height: theme.spacing * 2),
                BrutalText(
                  "Create unique, raw, and uncompromising interfaces",
                  variant: BrutalTextVariant.marked,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: theme.spacing * 3),
                BrutalRow(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BrutalButton.primary(
                      text: "Get Started",
                      onPressed: () {},
                      icon: const IconData(
                        0xe037,
                        fontFamily: 'MaterialIcons',
                      ), // arrow_forward
                      iconRight: true,
                    ),
                    SizedBox(width: theme.spacing),
                    BrutalButton(
                      text: "GitHub",
                      onPressed: () {},
                      icon: const IconData(
                        0xf413,
                        fontFamily: 'MaterialIcons',
                      ), // github
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection(BrutalTheme theme, BrutalScreenType screenType) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 3),
      child: Column(
        children: [
          BrutalText.heading2("WHY BRUTAL UI?", textAlign: TextAlign.center),
          SizedBox(height: theme.spacing * 2),

          BrutalGrid(
            crossAxisCount: screenType == BrutalScreenType.mobile ? 1 : 3,
            mainAxisSpacing: theme.spacing * 2,
            crossAxisSpacing: theme.spacing * 2,
            children: [
              BrutalCard(
                hasShadow: true,
                title: "Expressive",
                subtitle: "Make a statement with bold designs",
                child: BrutalText(
                  "Create interfaces that stand out with raw and honest aesthetics",
                ),
              ),
              BrutalCard.glitch(
                title: "Customizable",
                subtitle: "Multiple themes and variants",
                child: BrutalText(
                  "Choose from cyberpunk, neon, vaporwave, retro and more",
                ),
              ),
              BrutalCard(
                variant: BrutalCardVariant.featured,
                title: "Responsive",
                subtitle: "Adapts to any screen size",
                child: BrutalText(
                  "Built-in responsive layouts and breakpoint awareness",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeShowcase(BrutalTheme theme, BrutalScreenType screenType) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 3),
      backgroundColor: theme.colors.surface,
      child: Column(
        children: [
          BrutalText.heading2("CHOOSE YOUR STYLE", textAlign: TextAlign.center),
          SizedBox(height: theme.spacing * 2),

          BrutalTabs(
            variant:
                screenType == BrutalScreenType.mobile
                    ? BrutalTabVariant.minimal
                    : BrutalTabVariant.default_,
            tabs: [
              BrutalTabItem(
                title: "Cyberpunk",
                content: BrutalContainer.floating(
                  padding: EdgeInsets.all(theme.spacing * 2),
                  child: BrutalText(
                    "Bold neon colors with high contrast and futuristic aesthetics",
                    variant: BrutalTextVariant.marked,
                  ),
                ),
              ),
              BrutalTabItem(
                title: "Vaporwave",
                content: BrutalContainer.floating(
                  padding: EdgeInsets.all(theme.spacing * 2),
                  child: BrutalText(
                    "Retro digital aesthetics with vivid purples and blues",
                  ),
                ),
              ),
              BrutalTabItem(
                title: "Minimal",
                content: BrutalContainer.floating(
                  padding: EdgeInsets.all(theme.spacing * 2),
                  child: BrutalText(
                    "Clean, stripped back design for a focused interface",
                  ),
                ),
              ),
              BrutalTabItem(
                title: "Construction",
                content: BrutalContainer.floating(
                  padding: EdgeInsets.all(theme.spacing * 2),
                  child: BrutalText(
                    "Raw and utilitarian aesthetics with industrial touches",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildComponentShowcase(BrutalTheme theme) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 3),
      child: Column(
        children: [
          BrutalText.heading2(
            "POWERFUL COMPONENTS",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: theme.spacing * 2),

          BrutalWrapper(
            hasBorder: true,
            isJagged: true,
            padding: EdgeInsets.all(theme.spacing * 2),
            spacing: theme.spacing,
            runSpacing: theme.spacing,
            children: [
              BrutalBadge(
                label: "Buttons",
                variant: BrutalBadgeVariant.default_,
                isStandalone: true,
              ),
              BrutalBadge(
                label: "Cards",
                variant: BrutalBadgeVariant.secondary,
                isStandalone: true,
              ),
              BrutalBadge(
                label: "Containers",
                variant: BrutalBadgeVariant.error,
                isStandalone: true,
              ),
              BrutalBadge(
                label: "Inputs",
                variant: BrutalBadgeVariant.minimal,
                isStandalone: true,
              ),
              BrutalBadge(label: "Layout", isStandalone: true),
              BrutalBadge(label: "Dialogs", isStandalone: true),
              BrutalBadge(label: "Tabs", isStandalone: true),
              BrutalBadge(label: "Progress", isStandalone: true),
              BrutalBadge(label: "Text", isStandalone: true),
              BrutalBadge(
                label: "And more...",
                variant: BrutalBadgeVariant.minimal,
                isStandalone: true,
              ),
            ],
          ),

          SizedBox(height: theme.spacing * 2),
          BrutalText(
            "Over 30+ customizable components to build unique interfaces",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection(BrutalTheme theme) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 3),
      backgroundColor: theme.colors.surface,
      child: Column(
        children: [
          BrutalText.heading2("FAQ", textAlign: TextAlign.center),
          SizedBox(height: theme.spacing * 2),

          BrutalAccordionGroup(
            variant: BrutalAccordionVariant.default_,
            items: [
              BrutalAccordionItem(
                title: "Is Brutal UI suitable for production apps?",
                content: Padding(
                  padding: EdgeInsets.all(theme.spacing),
                  child: BrutalText(
                    "Absolutely! While the aesthetic is bold and unique, Brutal UI is built with production-quality code and performance in mind.",
                  ),
                ),
              ),
              BrutalAccordionItem(
                title: "Can I customize the themes?",
                content: Padding(
                  padding: EdgeInsets.all(theme.spacing),
                  child: BrutalText(
                    "Yes, all themes are fully customizable. You can modify colors, typography, spacing, and more to match your brand.",
                  ),
                ),
              ),
              BrutalAccordionItem(
                title: "Does it work with Material Design?",
                content: Padding(
                  padding: EdgeInsets.all(theme.spacing),
                  child: BrutalText(
                    "Brutal UI is designed to be self-contained, but it can coexist with Material components. However, for the best brutalist experience, we recommend using Brutal UI components.",
                  ),
                ),
              ),
              BrutalAccordionItem(
                title: "Is it responsive?",
                content: Padding(
                  padding: EdgeInsets.all(theme.spacing),
                  child: BrutalText(
                    "Yes! Brutal UI includes responsive components like BrutalResponsiveBuilder, BrutalAdaptivePanel, and BrutalGrid that make it easy to create layouts that work on any device.",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BrutalTheme theme) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 4),
      variant: BrutalContainerVariant.neon,
      hasShadow: true,
      child: BrutalAdaptivePanel.centered(
        child: Column(
          children: [
            BrutalText.heading2(
              "READY TO GET BRUTAL?",
              textAlign: TextAlign.center,
              isGlitched: true,
            ),
            SizedBox(height: theme.spacing * 2),
            BrutalText(
              "Start creating unique interfaces today",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: theme.spacing * 3),
            BrutalInput(
              label: "Subscribe to updates",
              placeholder: "Enter your email",
              suffix: BrutalButton(text: "Subscribe", onPressed: () {}),
            ),
            SizedBox(height: theme.spacing),
            BrutalText.caption(
              "We'll keep you updated with new features and releases",
              variant: BrutalTextVariant.subtle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BrutalTheme theme) {
    return BrutalContainer(
      padding: EdgeInsets.all(theme.spacing * 3),
      backgroundColor: theme.colors.surface,
      child: Column(
        children: [
          BrutalDivider(),
          SizedBox(height: theme.spacing * 2),
          BrutalRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BrutalText(
                "© 2023 Brutal UI",
                brutalStyle: BrutalTextStyle.caption,
              ),
              BrutalRow(
                children: [
                  BrutalButton.primary(text: "GitHub", onPressed: () {}),
                  BrutalButton.secondary(text: "Docs", onPressed: () {}),
                  BrutalButton.destructive(text: "Examples", onPressed: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
