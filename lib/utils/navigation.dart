import 'package:flutter_modular/flutter_modular.dart';
import 'package:pneumonia_detection/screens/homepage.dart';

class BaseNavigation extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute,
        child: (context, args) => const HomePage()),
  ];
}
