import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Build-time konfigurace (nahrazuje flutter_dotenv)
import '../config/build_config.dart';
import '../network/certificate_pinner.dart';

// Základní služby
import '../services/google_places_service.dart';

// Datové zdroje
import '../../modules/restaurant/data/datasources/favourite_remote_datasource.dart';
import '../../modules/restaurant/data/datasources/restaurant_remote_datasource.dart';
import '../../modules/restaurant/data/repositories/restaurant_repository_impl.dart';
import '../../modules/restaurant/domain/repositories/restaurant_repository.dart';
import '../../modules/restaurant/data/services/marker_data_service.dart';
import '../../modules/map/domain/usecases/explore_usecases.dart';
import '../../modules/map/domain/usecases/get_all_markers_usecase.dart';
import '../../modules/restaurant/domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../modules/restaurant/domain/usecases/toggle_favourite_usecase.dart';
import '../../modules/map/presentation/bloc/explore_bloc.dart';
import '../../modules/restaurant/presentation/customer/bloc/restaurant_detail_bloc.dart';

import '../../security/data/datasources/auth_remote_data_source.dart';
import '../../security/data/datasources/profile_remote_data_source.dart';
import '../../security/data/datasources/oauth_remote_data_source.dart';
import '../../security/data/local/token_storage.dart';

// Repozitáře
import '../../security/data/repositories/auth_repository_impl.dart';
import '../../security/data/repositories/profile_repository_impl.dart';
import '../../security/data/repositories/oauth_repository_impl.dart';
import '../../security/data/services/device_info_service.dart';
import '../../security/domain/repositories/auth_repository.dart';
import '../../security/domain/repositories/profile_repository.dart';
import '../../security/domain/repositories/oauth_repository.dart';

// Případy použití – ověřování (standardní)
import '../../security/domain/usecases/auth/check_auth_status_usecase.dart';
import '../../security/domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../security/domain/usecases/auth/login_usecase.dart';
import '../../security/domain/usecases/auth/logout_usecase.dart';
import '../../security/domain/usecases/auth/register_usecase.dart';
import '../../security/domain/usecases/auth/register_owner_usecase.dart';
import '../../security/domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../security/domain/usecases/auth/verify_email_usecase.dart';
import '../../security/domain/usecases/auth/forgot_password_usecase.dart';
import '../../security/domain/usecases/auth/reset_password_usecase.dart';

// Případy použití – OAuth
import '../../security/domain/usecases/oauth/login_with_apple_usecase.dart';
import '../../security/domain/usecases/oauth/login_with_google_usecase.dart';

// Případy použití – profil
import '../../security/domain/usecases/profile/change_password_usecase.dart';
import '../../security/domain/usecases/profile/get_active_devices_usecase.dart';
import '../../security/domain/usecases/profile/get_user_profile_usecase.dart';
import '../../security/domain/usecases/profile/logout_all_devices_usecase.dart';
import '../../security/domain/usecases/profile/logout_device_usecase.dart';
import '../../security/domain/usecases/profile/delete_device_usecase.dart';
import '../../security/domain/usecases/profile/delete_all_devices_usecase.dart';
import '../../security/domain/usecases/profile/update_profile_usecase.dart';
import '../../security/domain/usecases/profile/update_notification_preference_usecase.dart';
import '../../security/domain/usecases/profile/get_notification_preference_usecase.dart';
import '../../security/data/services/notification_service.dart';

// Interceptory a správci
import '../../security/interceptors/auth_interceptor.dart';
import '../../security/interceptors/refresh_token_manager.dart';

// BLoC
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/user/user_bloc.dart';

// Modul Moje restaurace (správa)
import '../../modules/restaurant/presentation/management/data/datasources/my_restaurant_remote_datasource.dart';
import '../../modules/restaurant/presentation/management/data/repositories/my_restaurant_repository_impl.dart';
import '../../modules/restaurant/presentation/management/domain/repositories/my_restaurant_repository.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/get_my_restaurant_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/get_my_restaurants_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/update_restaurant_info_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/get_employees_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/add_employee_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/update_employee_role_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/remove_employee_usecase.dart';
import '../../modules/restaurant/presentation/management/domain/usecases/update_employee_permissions_usecase.dart';
import '../../modules/restaurant/presentation/management/presentation/bloc/my_restaurant_bloc.dart';

// Modul rezervací
import '../../modules/reservation/data/datasources/reservation_remote_datasource.dart';
import '../../modules/reservation/data/repositories/reservation_repository_impl.dart';
import '../../modules/reservation/domain/repositories/reservation_repository.dart';
import '../../modules/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import '../../modules/reservation/domain/usecases/get_table_statuses_usecase.dart';
import '../../modules/reservation/domain/usecases/get_available_slots_usecase.dart';
import '../../modules/reservation/domain/usecases/create_reservation_usecase.dart';
import '../../modules/reservation/domain/usecases/get_my_reservations_overview_usecase.dart';
import '../../modules/reservation/domain/usecases/get_my_reservations_history_usecase.dart';
import '../../modules/reservation/domain/usecases/update_reservation_usecase.dart';
import '../../modules/reservation/domain/usecases/cancel_reservation_usecase.dart';
import '../../modules/reservation/domain/usecases/get_pending_changes_usecase.dart';
import '../../modules/reservation/domain/usecases/accept_change_request_usecase.dart';
import '../../modules/reservation/domain/usecases/decline_change_request_usecase.dart';
import '../../modules/reservation/domain/usecases/create_recurring_reservation_usecase.dart';
import '../../modules/reservation/domain/usecases/get_my_recurring_reservations_usecase.dart';
import '../../modules/reservation/domain/usecases/cancel_recurring_reservation_usecase.dart';
import '../../modules/reservation/presentation/customer/bloc/reservation_bloc.dart';
import '../../modules/reservation/presentation/customer/bloc/my_reservations_bloc.dart';

// Modul objednávek
import '../../modules/order/data/datasources/orders_remote_datasource.dart';
import '../../modules/order/data/repositories/orders_repository_impl.dart';
import '../../modules/order/domain/repositories/orders_repository.dart';
import '../../modules/order/domain/usecases/get_dining_context_usecase.dart';
import '../../modules/order/domain/usecases/get_menu_usecase.dart';
import '../../modules/order/domain/usecases/create_order_usecase.dart';
import '../../modules/order/domain/usecases/get_current_orders_usecase.dart';
import '../../modules/order/domain/usecases/initiate_payment_usecase.dart';
import '../../modules/order/domain/usecases/get_payment_status_usecase.dart';
import '../../modules/order/presentation/bloc/orders_bloc.dart';

// Modul rezervací personálu (správa)
import '../../modules/reservation/presentation/staff/data/datasources/staff_reservation_remote_datasource.dart';
import '../../modules/reservation/presentation/staff/data/repositories/staff_reservation_repository_impl.dart';
import '../../modules/reservation/presentation/staff/domain/repositories/staff_reservation_repository.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/get_staff_reservations_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/confirm_reservation_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/reject_reservation_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/check_in_reservation_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/complete_reservation_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/get_restaurant_tables_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/propose_change_usecase.dart';
import '../../modules/reservation/presentation/staff/domain/usecases/extend_reservation_usecase.dart';
import '../../modules/reservation/presentation/staff/presentation/bloc/staff_reservations_bloc.dart';

// Modul onboardingu vlastníka
import '../../modules/restaurant/presentation/onboarding/data/datasources/onboarding_remote_datasource.dart';
import '../../modules/restaurant/presentation/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../modules/restaurant/presentation/onboarding/domain/repositories/onboarding_repository.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/update_restaurant_info_usecase.dart'
    as ob_uc;
import '../../modules/restaurant/presentation/onboarding/domain/usecases/update_restaurant_hours_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/get_tables_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/add_table_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/update_table_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/delete_table_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/get_owner_menu_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/create_category_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/update_category_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/delete_category_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/create_menu_item_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/update_menu_item_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/delete_menu_item_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/publish_restaurant_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/create_panorama_session_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/upload_panorama_photo_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/finalize_panorama_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/get_panorama_status_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/domain/usecases/activate_panorama_usecase.dart';
import '../../modules/restaurant/presentation/onboarding/presentation/bloc/onboarding_wizard_bloc.dart';

// Pomocné nástroje
import '../utils/location_service.dart';

/// Globální service locator — vstupní bod pro dependency injection.
final sl = GetIt.instance;

/// Registruje všechny závislosti do [GetIt] service locatoru.
///
/// Musí být zavolána před spuštěním aplikace (před `runApp`).
Future<void> init() async {
  // ===========================================================================
  // 1. EXTERNÍ ZÁVISLOSTI, ÚLOŽIŠTĚ & ZÁKLADNÍ SLUŽBY
  // ===========================================================================

  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => TokenStorage(sl()));

  sl.registerLazySingleton(() => DeviceInfoPlugin());
  sl.registerLazySingleton(() => DeviceInfoService(sl()));

  sl.registerLazySingleton(() => LocationService());

  // Google Places API key: injected at build time via --dart-define, same
  // source as the native Maps SDK key. Dart side only needs it for the
  // Places REST API (autocomplete/details), not the MapView itself.
  const googlePlacesApiKey = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
  sl.registerLazySingleton(
    () => GooglePlacesService(apiKey: googlePlacesApiKey),
  );

  sl.registerLazySingleton(() => NotificationService());

  // Prostředí (build-time konstanta z BuildConfig)
  const apiBaseUrl = BuildConfig.apiBaseUrl;

  // ===========================================================================
  // 2. SÍŤ (DIO)
  // ===========================================================================

  // Ochrana: detekce duplicitní předpony /api/api/ v debug sestavení
  final apiPathGuard = InterceptorsWrapper(
    onRequest: (options, handler) {
      final uri = options.uri.toString();
      if (kDebugMode && uri.contains('/api/api/')) {
        throw DioException(
          requestOptions: options,
          message: 'BUG: Duplicate /api/api/ detected in URL: $uri. '
              'Endpoint paths must NOT start with /api — baseUrl already includes it.',
        );
      }
      handler.next(options);
    },
  );

  // A) DIO AUTH (Pro Login/Register/OAuth - bez interceptoru)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    // Certificate pinning — release builds insist the leaf cert's
    // SHA-256 fingerprint matches one of the values passed through
    // --dart-define=CERT_PIN_SHA256 at build time. Debug builds
    // skip the pin so LAN dev against self-signed certs still works.
    CertificatePinner.installOn(dio);
    dio.interceptors.add(apiPathGuard);
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true));
    }
    return dio;
  }, instanceName: 'dioAuth');

  // B) REFRESH MANAGER (Zajišťuje synchronizovaný refresh tokenu)
  sl.registerLazySingleton(() => RefreshTokenManager(sl()));

  // C) DIO MAIN (S AuthInterceptorem - pro autorizované požadavky)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    // Same certificate pinning installed on the authorised instance.
    CertificatePinner.installOn(dio);
    dio.interceptors.add(apiPathGuard);
    dio.interceptors.add(AuthInterceptor(sl(), sl(), dio));
    if (kDebugMode) {
      dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true));
    }
    return dio;
  });

  // ===========================================================================
  // 3. DATOVÉ ZDROJE
  // ===========================================================================

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl(instanceName: 'dioAuth')),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<OAuthRemoteDataSource>(
    () => OAuthRemoteDataSourceImpl(sl(instanceName: 'dioAuth')),
  );

  // ===========================================================================
  // 4. REPOZITÁŘE
  // ===========================================================================

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      tokenStorage: sl(),
      deviceInfoService: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<OAuthRepository>(
    () => OAuthRepositoryImpl(
      remoteDataSource: sl(),
      tokenStorage: sl(),
      deviceInfoService: sl(),
    ),
  );

  // ===========================================================================
  // 5. PŘÍPADY POUŽITÍ
  // ===========================================================================

  // Ověřování – standard
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => RegisterOwnerUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthenticatedUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationCodeUseCase(sl()));

  // Případ použití pro ověření stavu autentizace
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  // Zapomenuté/obnovení hesla
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));

  // OAuth ověřování
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithAppleUseCase(sl()));

  // Profil
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveDevicesUseCase(sl()));
  sl.registerLazySingleton(() => LogoutDeviceUseCase(sl()));
  sl.registerLazySingleton(() => LogoutAllDevicesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteDeviceUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAllDevicesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNotificationPreferenceUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificationPreferenceUseCase(sl()));

  // ===========================================================================
  // 6. BLOC
  // ===========================================================================

  sl.registerFactory(
    () => AuthBloc(
      loginUseCase: sl(),
      registerUseCase: sl(),
      registerOwnerUseCase: sl(),
      logoutUseCase: sl(),
      getAuthenticatedUserUseCase: sl(),
      verifyEmailUseCase: sl(),
      resendVerificationCodeUseCase: sl(),
      loginWithGoogleUseCase: sl(),
      loginWithAppleUseCase: sl(),
      checkAuthStatusUseCase: sl(),
      forgotPasswordUseCase: sl(),
      resetPasswordUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => UserBloc(
      getUserProfileUseCase: sl(),
      getActiveDevicesUseCase: sl(),
      updateProfileUseCase: sl(),
      changePasswordUseCase: sl(),
      logoutDeviceUseCase: sl(),
      logoutAllDevicesUseCase: sl(),
      deleteDeviceUseCase: sl(),
      deleteAllDevicesUseCase: sl(),
      updateNotificationPreferenceUseCase: sl(),
      getNotificationPreferenceUseCase: sl(),
      notificationService: sl(),
      deviceInfoService: sl(),
      profileRepository: sl(),
    ),
  );

  // ===========================================================================
  // 7. MODUL RESTAURACÍ
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FavouriteRemoteDataSource>(
    () => FavouriteRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(sl()),
  );

  // --- Případy použití ---

  // LocationService uz je registrovan v sekci 1. Zde registrujeme jen UseCase.
  sl.registerLazySingleton(() => GetLocationUseCase(sl()));

  sl.registerLazySingleton(() => GetRestaurantMarkersUseCase(sl()));
  sl.registerLazySingleton(() => GetNearestRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => GetRestaurantByIdUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavouriteUseCase(sl()));
  sl.registerLazySingleton(() => GetAllMarkersUseCase(sl()));
  sl.registerLazySingleton(() => MarkerDataService());

  // --- BLoC ---
  sl.registerFactory(
    () => ExploreBloc(
      getLocationUseCase: sl(),
      getMarkersUseCase: sl(),
      getNearestUseCase: sl(),
      restaurantRepository: sl(),
      getAllMarkersUseCase: sl(),
      markerDataService: sl(),
    ),
  );

  sl.registerFactory(
    () => RestaurantDetailBloc(
      getRestaurantByIdUseCase: sl(),
      toggleFavouriteUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 8. MODUL REZERVACÍ
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<ReservationRemoteDataSource>(
    () => ReservationRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(sl()),
  );

  // --- Případy použití ---
  sl.registerLazySingleton(() => GetReservationSceneUseCase(sl()));
  sl.registerLazySingleton(() => GetTableStatusesUseCase(sl()));
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase(sl()));
  sl.registerLazySingleton(() => CreateReservationUseCase(sl()));
  sl.registerLazySingleton(() => GetMyReservationsOverviewUseCase(sl()));
  sl.registerLazySingleton(() => GetMyReservationsHistoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateReservationUseCase(sl()));
  sl.registerLazySingleton(() => CancelReservationUseCase(sl()));
  sl.registerFactory(() => GetPendingChangesUseCase(sl()));
  sl.registerFactory(() => AcceptChangeRequestUseCase(sl()));
  sl.registerFactory(() => DeclineChangeRequestUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => ReservationBloc(
      getSceneUseCase: sl(),
      getStatusesUseCase: sl(),
      getSlotsUseCase: sl(),
      createReservationUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => MyReservationsBloc(
      getOverviewUseCase: sl(),
      getHistoryUseCase: sl(),
      cancelUseCase: sl(),
      updateUseCase: sl(),
      getSceneUseCase: sl(),
      getSlotsUseCase: sl(),
      getPendingChangesUseCase: sl(),
      acceptChangeRequestUseCase: sl(),
      declineChangeRequestUseCase: sl(),
      createRecurringUseCase: sl(),
      getRecurringUseCase: sl(),
      cancelRecurringUseCase: sl(),
    ),
  );

  // Případy použití pro opakující se rezervace
  sl.registerLazySingleton(() => CreateRecurringReservationUseCase(sl()));
  sl.registerLazySingleton(() => GetMyRecurringReservationsUseCase(sl()));
  sl.registerLazySingleton(() => CancelRecurringReservationUseCase(sl()));

  // ===========================================================================
  // 9. MODUL MOJE RESTAURACE (správa)
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<MyRestaurantRemoteDataSource>(
    () => MyRestaurantRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<MyRestaurantRepository>(
    () => MyRestaurantRepositoryImpl(sl()),
  );

  // --- Případy použití ---
  sl.registerLazySingleton(() => GetMyRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => GetMyRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRestaurantInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetEmployeesUseCase(sl()));
  sl.registerLazySingleton(() => AddEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmployeeRoleUseCase(sl()));
  sl.registerLazySingleton(() => RemoveEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmployeePermissionsUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => MyRestaurantBloc(
      getMyRestaurantUseCase: sl(),
      getMyRestaurantsUseCase: sl(),
      updateRestaurantInfoUseCase: sl(),
      getEmployeesUseCase: sl(),
      addEmployeeUseCase: sl(),
      updateEmployeeRoleUseCase: sl(),
      removeEmployeeUseCase: sl(),
      updateEmployeePermissionsUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 9b. MODUL REZERVACÍ PERSONÁLU (správa)
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<StaffReservationRemoteDataSource>(
    () => StaffReservationRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<StaffReservationRepository>(
    () => StaffReservationRepositoryImpl(sl()),
  );

  // --- Případy použití ---
  sl.registerLazySingleton(() => GetStaffReservationsUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmReservationUseCase(sl()));
  sl.registerLazySingleton(() => RejectReservationUseCase(sl()));
  sl.registerLazySingleton(() => CheckInReservationUseCase(sl()));
  sl.registerLazySingleton(() => CompleteReservationUseCase(sl()));
  sl.registerLazySingleton(() => GetRestaurantTablesUseCase(sl()));
  sl.registerFactory(() => ProposeChangeUseCase(sl()));
  sl.registerFactory(() => ExtendReservationUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => StaffReservationsBloc(
      getReservations: sl(),
      confirm: sl(),
      reject: sl(),
      checkIn: sl(),
      complete: sl(),
      getTables: sl(),
      proposeChange: sl(),
      extendReservation: sl(),
    ),
  );

  // ===========================================================================
  // 10. MODUL OBJEDNÁVEK
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(sl()),
  );

  // --- Případy použití ---
  sl.registerLazySingleton(() => GetDiningContextUseCase(sl()));
  sl.registerLazySingleton(() => GetMenuUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentOrdersUseCase(sl()));
  sl.registerLazySingleton(() => InitiatePaymentUseCase(sl()));
  sl.registerLazySingleton(() => GetPaymentStatusUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => OrdersBloc(
      getDiningContextUseCase: sl(),
      getMenuUseCase: sl(),
      createOrderUseCase: sl(),
      getCurrentOrdersUseCase: sl(),
      initiatePaymentUseCase: sl(),
      getPaymentStatusUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 11. MODUL ONBOARDINGU VLASTNÍKA
  // ===========================================================================

  // --- Datové zdroje ---
  sl.registerLazySingleton<OnboardingRemoteDataSource>(
    () => OnboardingRemoteDataSourceImpl(sl()),
  );

  // --- Repozitáře ---
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );

  // --- Případy použití ---
  sl.registerLazySingleton(() => GetOnboardingStatusUseCase(sl()));
  sl.registerLazySingleton<ob_uc.UpdateRestaurantInfoUseCase>(
    () => ob_uc.UpdateRestaurantInfoUseCase(sl()),
  );
  sl.registerLazySingleton(() => UpdateRestaurantHoursUseCase(sl()));
  sl.registerLazySingleton(() => GetTablesUseCase(sl()));
  sl.registerLazySingleton(() => AddTableUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTableUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTableUseCase(sl()));
  sl.registerLazySingleton(() => GetOwnerMenuUseCase(sl()));
  sl.registerLazySingleton(() => CreateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCategoryUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCategoryUseCase(sl()));
  sl.registerLazySingleton(() => CreateMenuItemUseCase(sl()));
  sl.registerLazySingleton(() => UpdateMenuItemUseCase(sl()));
  sl.registerLazySingleton(() => DeleteMenuItemUseCase(sl()));
  sl.registerLazySingleton(() => PublishRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => CreatePanoramaSessionUseCase(sl()));
  sl.registerLazySingleton(() => UploadPanoramaPhotoUseCase(sl()));
  sl.registerLazySingleton(() => FinalizePanoramaUseCase(sl()));
  sl.registerLazySingleton(() => GetPanoramaStatusUseCase(sl()));
  sl.registerLazySingleton(() => ActivatePanoramaUseCase(sl()));

  // --- BLoC ---
  sl.registerFactory(
    () => OnboardingWizardBloc(
      repository: sl(),
      getOnboardingStatus: sl(),
      updateInfo: sl<ob_uc.UpdateRestaurantInfoUseCase>(),
      updateHours: sl(),
      getTables: sl(),
      addTable: sl(),
      updateTable: sl(),
      deleteTable: sl(),
      getMenu: sl(),
      createCategory: sl(),
      updateCategory: sl(),
      deleteCategory: sl(),
      createItem: sl(),
      updateItem: sl(),
      deleteItem: sl(),
      publishRestaurant: sl(),
      createPanoramaSession: sl(),
      uploadPhoto: sl(),
      finalizePanorama: sl(),
      getPanoramaStatus: sl(),
      activatePanorama: sl(),
    ),
  );
}
