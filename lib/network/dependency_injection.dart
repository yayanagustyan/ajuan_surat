import 'package:flutter_simple_dependency_injection/injector.dart';

class DependencyInjection {
  Injector initialise(Injector injector) {
    // injector.map<SocketService>((i) => SocketService(), isSingleton: true);
    return injector;
  }
}
