import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../security/data/datasources/auth_remote_data_source.dart';
import '../../security/data/datasources/profile_remote_data_source.dart';
import '../../security/data/local/token_storage.dart';
import '../../security/data/repositories/auth_repository_impl.dart';
import '../../security/data/repositories/profile_repository_impl.dart';
import '../../security/domain/repositories/auth_repository.dart';
import '../../security/domain/repositories/profile_repository.dart';
import '../../security/domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../security/domain/usecases/auth/login_usecase.dart';
import '../../security/domain/usecases/auth/logout_usecase.dart';
import '../../security/domain/usecases/auth/register_usecase.dart';
import '../../security/domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../security/domain/usecases/auth/verify_email_usecase.dart';
import '../../security/domain/usecases/profile/change_password_usecase.dart';
import '../../security/domain/usecases/profile/get_active_devices_usecase.dart';
import '../../security/domain/usecases/profile/get_user_profile_usecase.dart';
import '../../security/domain/usecases/profile/logout_all_devices_usecase.dart';
import '../../security/domain/usecases/profile/logout_device_usecase.dart';
import '../../security/domain/usecases/profile/update_profile_usecase.dart';
import '../../security/interceptors/auth_interceptor.dart';
import '../../security/interceptors/refresh_token_manager.dart';
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/user/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ===========================================================================
  // 1. EXTERNAL & LOCAL STORAGE
  // ===========================================================================
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => TokenStorage(sl()));

  // ===========================================================================
  // 2. NETWORK (DIO)
  // ===========================================================================

  // A) DIO AUTH (Bez interceptoru - pro Login/Register/Refresh)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8081', // Android Emulator
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }, instanceName: 'dioAuth');

  // B) REFRESH MANAGER
  sl.registerLazySingleton(() => RefreshTokenManager(sl(), sl()));

  // C) DIO MAIN (S AuthInterceptorem - pro zbytek appky)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://10.0.2.2:8081',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Přidání interceptoru
    dio.interceptors.add(AuthInterceptor(sl(), sl(), dio));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  });

  // ===========================================================================
  // 3. DATA SOURCES
  // ===========================================================================

  // AuthRemoteDataSource (používá 'dioAuth')
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(instanceName: 'dioAuth')),
  );

  // ProfileRemoteDataSource (používá hlavní Dio)
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  // ===========================================================================
  // 4. REPOSITORIES
  // ===========================================================================

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  // ===========================================================================
  // 5. USE CASES
  // ===========================================================================

  // --- Auth ---
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthenticatedUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationCodeUseCase(sl()));

  // --- Profile ---
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveDevicesUseCase(sl()));
  sl.registerLazySingleton(() => LogoutDeviceUseCase(sl()));
  sl.registerLazySingleton(() => LogoutAllDevicesUseCase(sl())); // PŘIDÁNO

  // ===========================================================================
  // 6. BLOCS
  // ===========================================================================

  // AuthBloc
  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      logoutUseCase: sl(),
      getAuthenticatedUserUseCase: sl(),
      verifyEmailUseCase: sl(),
      resendVerificationCodeUseCase: sl(),
    ),
  );

  // UserBloc (PŘIDÁNO)
  sl.registerFactory(
    () => UserBloc(
      getUserProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      changePasswordUseCase: sl(),
      logoutDeviceUseCase: sl(),
      logoutAllDevicesUseCase: sl(),
    ),
  );
}
