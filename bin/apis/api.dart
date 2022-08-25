import 'package:shelf/shelf.dart';

abstract class Api {
  Handler getHandler({List<Middleware>? middlewares});

  Handler createHandler({
    required Handler router,
    List<Middleware>? middlewares,
  }) {
    middlewares ??= [];
    var pipeLine = Pipeline();
    middlewares.forEach((m) => pipeLine = pipeLine.addMiddleware(m));
    return pipeLine.addHandler((router));
  }
}
