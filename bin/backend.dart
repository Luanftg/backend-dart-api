import 'package:shelf/shelf.dart';
import 'apis/blog_noticias.dart';
import 'apis/login_api.dart';
import 'infra/custom_server.dart';
import 'services/noticia_service.dart';
import 'util/custom_env.dart';

void main() async {
  CustomEnv.fromFile('.env-dev');

  var cascadeHandler = Cascade()
      .add(LoginApi().handler)
      .add(BlogApi(NoticiaService()).handler)
      .handler;

  var handler =
      Pipeline().addMiddleware(logRequests()).addHandler(cascadeHandler);

  await CustomServer().initialize(
      handler: handler,
      address: await CustomEnv.get<String>(key: 'server_address'),
      port: await CustomEnv.get<int>(key: 'server_port'));
}
