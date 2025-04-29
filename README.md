# BRUTAL UI

```
██████  ██████  ██    ██ ████████  █████  ██          ██    ██ ██ 
██   ██ ██   ██ ██    ██    ██    ██   ██ ██          ██    ██ ██ 
██████  ██████  ██    ██    ██    ███████ ██          ██    ██ ██ 
██   ██ ██   ██ ██    ██    ██    ██   ██ ██          ██    ██    
██████  ██   ██  ██████     ██    ██   ██ ███████      ██████  ██ 
```

## DESIGN DOESN'T HAVE TO BE PRETTY. IT HAS TO BE BRUTAL.

**BRUTAL UI** is a Flutter design system that embraces the raw, honest, and uncompromising principles of Brutalist design. No rounded corners. No subtle drop shadows. No gentle gradients. Just pure, unapologetic interfaces that make a statement.

![Version](https://img.shields.io/badge/version-0.0.1-red)
![Flutter](https://img.shields.io/badge/flutter-3.7.2+-blue)
![Status](https://img.shields.io/badge/status-AGGRESSIVE_DEVELOPMENT-black)

---

## WHY GO BRUTAL?

Because we're tired of the same boring, cookie-cutter interfaces. In a world where every app looks the same, **BRUTAL UI** helps you create digital experiences that:

- **STAND OUT** - Break free from generic design patterns
- **PROVOKE** - Challenge users' expectations 
- **EXPRESS** - Show personality through unapologetic aesthetic choices
- **RESIST OBSOLESCENCE** - Reject transient design trends for raw functionality

---

## FEATURES THAT PUNCH YOU IN THE FACE

- 🔥 **MULTIPLE BRUTAL THEMES**: Cyberpunk, Neon, Vaporwave, Retro, Construction, Minimal
- 🔥 **VISUAL EFFECTS**: Glitch, Broken, Jagged, Pixel, Distorted
- 🔥 **RESPONSIVE**: Adapts to any screen size with breakpoint awareness
- 🔥 **30+ BRUTAL COMPONENTS**: Everything you need to build an interface that screams
- 🔥 **AGGRESSIVE TYPOGRAPHY**: Bold text treatments that command attention
- 🔥 **ZERO MATERIAL DEPENDENCIES**: We don't need no stinking Material Design

---

## INSTALLATION

```bash
# Don't ask for permission. Just do it.
flutter pub add brutal_ui
```

Add this to your pubspec.yaml:

```yaml
dependencies:
  brutal_ui: ^0.0.1 # Latest version might be different. WHO CARES?
```

---

## CORE COMPONENTS

### TEXT THAT SCREAMS

```dart
// Normal (boring) text
BrutalText("Your interface is forgettable");

// Text that DEMANDS attention
BrutalText.heading1("YOUR INTERFACE IS NOW BRUTAL", isGlitched: true);

// Styles: display, heading1, heading2, heading3, body, caption, mono
// Variants: marked, glitch, loud, redacted, subtle
```

### BUTTONS THAT ASSAULT YOUR SENSES

```dart
BrutalButton(
  text: "CLICK OR DIE",
  onPressed: () => print("BRUTALITY"),
);

// Variants: primary, secondary, destructive, broken, minimal
BrutalButton.broken(
  text: "SYSTEM ERROR",
  onPressed: () {},
  isGlitched: true,
);
```

### CARDS THAT REFUSE CONFORMITY

```dart
BrutalCard(
  title: "RAW DESIGN",
  subtitle: "No compromise",
  child: BrutalText("Interfaces that make a statement"),
);

BrutalCard.glitch(
  title: "SYSTEM FAILURE",
  child: BrutalText("Embrace the chaos", isGlitched: true),
);
```

---

## THEMES THAT REJECT SUBTLETY

BRUTAL UI comes with multiple themes that each express a different flavor of digital brutalism:

- **CYBERPUNK**: Neon yellows and blues against dark backgrounds
- **VAPORWAVE**: Nostalgic digital aesthetics with vibrant purples
- **MINIMAL**: Raw black and white, unadorned and honest
- **RETRO**: 8-bit inspired interfaces with pixel effects
- **CONSTRUCTION**: Industrial yellow and black warning aesthetics
- **DEFAULT**: Raw brutalist basics for the digital age

```dart
BrutalApp(
  theme: BrutalTheme.cyberpunkTheme, // Choose your weapon
  child: MyBrutalApp(),
);
```

---

## LAYOUT SYSTEM THAT BREAKS RULES

Our layout components don't just organize content - they actively participate in the aesthetic:

```dart
// Columns that refuse to behave
BrutalColumn(
  isJagged: true, // Elements are deliberately misaligned
  isGlitched: true, // Visual noise and distortion
  children: [
    BrutalText("DISORDER"),
    BrutalText("IS"),
    BrutalText("HONEST"),
  ],
);

// Responsive brutality
BrutalResponsiveBuilder(
  builder: (context, screenType) {
    return screenType == BrutalScreenType.mobile
      ? BrutalText("SMALL BUT ANGRY")
      : BrutalText("BIG AND FURIOUS");
  },
);

// Adaptive panels that know their place
BrutalAdaptivePanel(
  child: YourContent(),
  isBroken: true, // Slight rotation and distortion
);
```

---

## BRUTAL PHILOSOPHY

Brutalism in architecture values honesty of materials, exposure of structure, and rejection of decorative elements. BRUTAL UI applies these principles to digital interfaces:

1. **HONESTY**: We don't hide our interface elements behind subtle effects
2. **EXPOSURE**: Structure is visible and celebrated, not concealed 
3. **FUNCTION**: Every element serves a purpose, nothing is merely decorative
4. **RAW MATERIALS**: Digital interfaces have their own "raw materials" - pixels, vectors, fonts
5. **CONTRAST**: Bold contrasts in color, form, and scale create visual tension

---

## ROADMAP TO MORE BRUTALITY

BRUTAL UI is still in aggressive development. Future plans include:

- **ANIMATION SYSTEM**: Brutalist motion design principles 
- **CHARTS & DATA**: Data visualization with a brutal aesthetic
- **CODE GENERATOR**: Generate brutalist layouts from simple descriptions
- **MORE THEMES**: Industrial, Constructivist, Digital Trash aesthetic
- **WEB SHOWCASE**: Interactive demo site for all components
- **BRUTALIST ICON SET**: Custom iconography with brutal aesthetics

---

## WHO IS THIS FOR?

- Designers who are tired of the same clean, soulless interfaces
- Developers building apps for counterculture audiences
- Projects that need to stand out in a sea of sameness
- Anyone who appreciates the honesty of brutalist aesthetics
- YOU, if you're brave enough

---

## CONTRIBUTE TO THE BRUTALITY

BRUTAL UI wants your contributions, but only if they're BRUTAL. Here's how:

1. Fork the repo
2. Create your brutal feature branch
3. Commit your raw, honest changes
4. Push to your branch
5. Open a Pull Request (we'll crush it with constructive feedback)

---

## LICENSE

**WE DON'T CARE WHAT YOU DO WITH THIS CODE**

(But legally speaking, it's under MIT License)

---

```
BRUTAL UI - FOR WHEN YOUR INTERFACE 
NEEDS TO MAKE A STATEMENT, NOT FRIENDS.
```