import 'package:get_it/get_it.dart';
import '../presentation/authentication/data/authentication_provider.dart';


final GetIt locator = GetIt.instance;

void initServices() {
  ///
  /// Register provider
  ///

  locator.registerSingleton<AuthenticationProvider>(AuthenticationProvider());

  ///
  /// Example how to register if something is required
  ///
  // locator.registerSingleton<AuthenticationRepository>(
  //     AuthenticationRepository(authenticationProvider: locator.get<AuthenticationProvider>(), tokenProvider: locator.get<TokenProvider>()));
}
