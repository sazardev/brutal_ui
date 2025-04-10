import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';

/// Un contenedor de aplicación brutalista que evita depender de MaterialApp
class BrutalApp extends StatelessWidget {
  final Widget child;
  final BrutalTheme theme;
  final String title;
  final Locale? locale;
  final Iterable<LocalizationsDelegate<dynamic>>? localizationsDelegates;
  final Iterable<Locale>? supportedLocales;
  final TextDirection? textDirection;
  final bool debugShowCheckedModeBanner;

  const BrutalApp({
    super.key,
    required this.child,
    required this.theme,
    this.title = 'Brutal UI App',
    this.locale,
    this.localizationsDelegates,
    this.supportedLocales,
    this.textDirection,
    this.debugShowCheckedModeBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: title,
      color: theme.colors.primary,
      debugShowCheckedModeBanner: debugShowCheckedModeBanner,
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales ?? const [Locale('en', 'US')],
      textStyle: theme.typography.body,
      builder: (context, child) {
        return _BrutalThemeProvider(
          theme: theme,
          child: Builder(
            builder:
                (context) => Directionality(
                  textDirection: textDirection ?? TextDirection.ltr,
                  child: child ?? Container(),
                ),
          ),
        );
      },
      home: child,
    );
  }
}

class _BrutalThemeProvider extends InheritedWidget {
  final BrutalTheme theme;

  const _BrutalThemeProvider({required this.theme, required super.child});

  @override
  bool updateShouldNotify(_BrutalThemeProvider oldWidget) {
    return oldWidget.theme != theme;
  }
}
