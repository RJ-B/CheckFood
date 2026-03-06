import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_info_plus/device_info_plus.dart';

// Core Services

// Data Sources
import '../../modules/customer/restaurant/data/datasources/favourite_remote_datasource.dart';
import '../../modules/customer/restaurant/data/datasources/restaurant_remote_datasource.dart';
import '../../modules/customer/restaurant/data/repositories/restaurant_repository_impl.dart';
import '../../modules/customer/restaurant/domain/repositories/restaurant_repository.dart';
import '../../modules/customer/restaurant/domain/usecases/explore_usecases.dart';
import '../../modules/customer/restaurant/domain/usecases/get_restaurant_by_id_usecase.dart';
import '../../modules/customer/restaurant/domain/usecases/toggle_favourite_usecase.dart';
import '../../modules/customer/restaurant/presentation/bloc/explore_bloc.dart';
import '../../modules/customer/restaurant/presentation/bloc/restaurant_detail_bloc.dart';

import '../../security/data/datasources/auth_remote_data_source.dart';
import '../../security/data/datasources/profile_remote_data_source.dart';
import '../../security/data/datasources/oauth_remote_data_source.dart';
import '../../security/data/local/token_storage.dart';

// Repositories
import '../../security/data/repositories/auth_repository_impl.dart';
import '../../security/data/repositories/profile_repository_impl.dart';
import '../../security/data/repositories/oauth_repository_impl.dart';
import '../../security/data/services/device_info_service.dart';
import '../../security/domain/repositories/auth_repository.dart';
import '../../security/domain/repositories/profile_repository.dart';
import '../../security/domain/repositories/oauth_repository.dart';

// Use Cases - Auth (Standard)
import '../../security/domain/usecases/auth/check_auth_status_usecase.dart';
import '../../security/domain/usecases/auth/get_authenticated_user_usecase.dart';
import '../../security/domain/usecases/auth/login_usecase.dart';
import '../../security/domain/usecases/auth/logout_usecase.dart';
import '../../security/domain/usecases/auth/register_usecase.dart';
import '../../security/domain/usecases/auth/register_owner_usecase.dart';
import '../../security/domain/usecases/auth/resend_verification_code_usecase.dart';
import '../../security/domain/usecases/auth/verify_email_usecase.dart';

// Use Cases - OAuth
import '../../security/domain/usecases/oauth/login_with_apple_usecase.dart';
import '../../security/domain/usecases/oauth/login_with_google_usecase.dart';

// Use Cases - Profile
import '../../security/domain/usecases/profile/change_password_usecase.dart';
import '../../security/domain/usecases/profile/get_active_devices_usecase.dart';
import '../../security/domain/usecases/profile/get_user_profile_usecase.dart';
import '../../security/domain/usecases/profile/logout_all_devices_usecase.dart';
import '../../security/domain/usecases/profile/logout_device_usecase.dart';
import '../../security/domain/usecases/profile/update_profile_usecase.dart';
import '../../security/domain/usecases/profile/update_notification_preference_usecase.dart';
import '../../security/domain/usecases/profile/get_notification_preference_usecase.dart';
import '../../security/data/services/notification_service.dart';

// Interceptors & Managers
import '../../security/interceptors/auth_interceptor.dart';
import '../../security/interceptors/refresh_token_manager.dart';

// Blocs
import '../../security/presentation/bloc/auth/auth_bloc.dart';
import '../../security/presentation/bloc/user/user_bloc.dart';

// My Restaurant Module (Management)
import '../../modules/management/my_restaurant/data/datasources/my_restaurant_remote_datasource.dart';
import '../../modules/management/my_restaurant/data/repositories/my_restaurant_repository_impl.dart';
import '../../modules/management/my_restaurant/domain/repositories/my_restaurant_repository.dart';
import '../../modules/management/my_restaurant/domain/usecases/get_my_restaurant_usecase.dart';
import '../../modules/management/my_restaurant/domain/usecases/update_restaurant_info_usecase.dart';
import '../../modules/management/my_restaurant/domain/usecases/get_employees_usecase.dart';
import '../../modules/management/my_restaurant/domain/usecases/add_employee_usecase.dart';
import '../../modules/management/my_restaurant/domain/usecases/update_employee_role_usecase.dart';
import '../../modules/management/my_restaurant/domain/usecases/remove_employee_usecase.dart';
import '../../modules/management/my_restaurant/presentation/bloc/my_restaurant_bloc.dart';

// Reservation Module
import '../../modules/customer/reservation/data/datasources/reservation_remote_datasource.dart';
import '../../modules/customer/reservation/data/repositories/reservation_repository_impl.dart';
import '../../modules/customer/reservation/domain/repositories/reservation_repository.dart';
import '../../modules/customer/reservation/domain/usecases/get_reservation_scene_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/get_table_statuses_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/get_available_slots_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/create_reservation_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/get_my_reservations_overview_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/get_my_reservations_history_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/update_reservation_usecase.dart';
import '../../modules/customer/reservation/domain/usecases/cancel_reservation_usecase.dart';
import '../../modules/customer/reservation/presentation/bloc/reservation_bloc.dart';
import '../../modules/customer/reservation/presentation/bloc/my_reservations_bloc.dart';

// Orders Module
import '../../modules/customer/orders/data/datasources/orders_remote_datasource.dart';
import '../../modules/customer/orders/data/repositories/orders_repository_impl.dart';
import '../../modules/customer/orders/domain/repositories/orders_repository.dart';
import '../../modules/customer/orders/domain/usecases/get_dining_context_usecase.dart';
import '../../modules/customer/orders/domain/usecases/get_menu_usecase.dart';
import '../../modules/customer/orders/domain/usecases/create_order_usecase.dart';
import '../../modules/customer/orders/domain/usecases/get_current_orders_usecase.dart';
import '../../modules/customer/orders/presentation/bloc/orders_bloc.dart';

// Staff Reservations Module (Management)
import '../../modules/management/staff_reservations/data/datasources/staff_reservation_remote_datasource.dart';
import '../../modules/management/staff_reservations/data/repositories/staff_reservation_repository_impl.dart';
import '../../modules/management/staff_reservations/domain/repositories/staff_reservation_repository.dart';
import '../../modules/management/staff_reservations/domain/usecases/get_staff_reservations_usecase.dart';
import '../../modules/management/staff_reservations/domain/usecases/confirm_reservation_usecase.dart';
import '../../modules/management/staff_reservations/domain/usecases/reject_reservation_usecase.dart';
import '../../modules/management/staff_reservations/domain/usecases/check_in_reservation_usecase.dart';
import '../../modules/management/staff_reservations/domain/usecases/complete_reservation_usecase.dart';
import '../../modules/management/staff_reservations/presentation/bloc/staff_reservations_bloc.dart';

// Owner Claim Module
import '../../modules/owner/data/datasources/owner_claim_remote_datasource.dart';
import '../../modules/owner/data/repositories/owner_claim_repository_impl.dart';
import '../../modules/owner/domain/repositories/owner_claim_repository.dart';
import '../../modules/owner/domain/usecases/lookup_ares_usecase.dart';
import '../../modules/owner/domain/usecases/verify_bankid_usecase.dart';
import '../../modules/owner/domain/usecases/start_email_claim_usecase.dart';
import '../../modules/owner/domain/usecases/confirm_email_claim_usecase.dart';
import '../../modules/owner/presentation/bloc/owner_claim_bloc.dart';

// Owner Onboarding Module
import '../../modules/owner/onboarding/data/datasources/onboarding_remote_datasource.dart';
import '../../modules/owner/onboarding/data/repositories/onboarding_repository_impl.dart';
import '../../modules/owner/onboarding/domain/repositories/onboarding_repository.dart';
import '../../modules/owner/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/update_restaurant_info_usecase.dart'
    as ob_uc;
import '../../modules/owner/onboarding/domain/usecases/update_restaurant_hours_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/get_tables_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/add_table_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/update_table_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/delete_table_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/get_owner_menu_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/create_category_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/update_category_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/delete_category_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/create_menu_item_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/update_menu_item_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/delete_menu_item_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/publish_restaurant_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/create_panorama_session_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/upload_panorama_photo_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/finalize_panorama_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/get_panorama_status_usecase.dart';
import '../../modules/owner/onboarding/domain/usecases/activate_panorama_usecase.dart';
import '../../modules/owner/onboarding/presentation/bloc/onboarding_wizard_bloc.dart';

// Utils
import '../utils/location_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ===========================================================================
  // 1. EXTERNAL, STORAGE & CORE SERVICES
  // ===========================================================================

  // Storage
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton(() => TokenStorage(sl()));

  // Device Identity
  sl.registerLazySingleton(() => DeviceInfoPlugin());
  sl.registerLazySingleton(() => DeviceInfoService(sl()));

  // Location Service (Potřebné pro GetLocationUseCase)
  // Zde registrujeme službu jako singleton.
  sl.registerLazySingleton(() => LocationService());

  // Notification Service (Firebase Messaging wrapper)
  sl.registerLazySingleton(() => NotificationService());

  // Environment
  final String apiBaseUrl = dotenv.get(
    'API_BASE_URL',
    fallback: 'http://10.0.2.2:8081/api',
  );

  // ===========================================================================
  // 2. NETWORK (DIO)
  // ===========================================================================

  // Guard: detect duplicate /api/api/ prefix in debug builds
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
    dio.interceptors.add(apiPathGuard);
    dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true));
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

    dio.interceptors.add(apiPathGuard);
    dio.interceptors.add(AuthInterceptor(sl(), sl(), dio));
    dio.interceptors.add(LogInterceptor(requestBody: false, responseBody: true));
    return dio;
  });

  // ===========================================================================
  // 3. DATA SOURCES
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
  // 4. REPOSITORIES
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
  // 5. USE CASES
  // ===========================================================================

  // Auth Standard
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => RegisterOwnerUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => GetAuthenticatedUserUseCase(sl()));
  sl.registerLazySingleton(() => VerifyEmailUseCase(sl()));
  sl.registerLazySingleton(() => ResendVerificationCodeUseCase(sl()));

  // CheckAuthStatusUseCase
  sl.registerLazySingleton(() => CheckAuthStatusUseCase(sl()));

  // Auth OAuth
  sl.registerLazySingleton(() => LoginWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => LoginWithAppleUseCase(sl()));

  // Profile
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetActiveDevicesUseCase(sl()));
  sl.registerLazySingleton(() => LogoutDeviceUseCase(sl()));
  sl.registerLazySingleton(() => LogoutAllDevicesUseCase(sl()));
  sl.registerLazySingleton(() => UpdateNotificationPreferenceUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificationPreferenceUseCase(sl()));

  // ===========================================================================
  // 6. BLOCS
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
      updateNotificationPreferenceUseCase: sl(),
      getNotificationPreferenceUseCase: sl(),
      notificationService: sl(),
      deviceInfoService: sl(),
    ),
  );

  // ===========================================================================
  // 7. RESTAURANT MODULE
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<RestaurantRemoteDataSource>(
    () => RestaurantRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<FavouriteRemoteDataSource>(
    () => FavouriteRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<RestaurantRepository>(
    () => RestaurantRepositoryImpl(sl()),
  );

  // --- Use Cases ---

  // LocationService uz je registrovan v sekci 1. Zde registrujeme jen UseCase.
  sl.registerLazySingleton(() => GetLocationUseCase(sl()));

  sl.registerLazySingleton(() => GetRestaurantMarkersUseCase(sl()));
  sl.registerLazySingleton(() => GetNearestRestaurantsUseCase(sl()));

  sl.registerLazySingleton(() => GetRestaurantByIdUseCase(sl()));
  sl.registerLazySingleton(() => ToggleFavouriteUseCase(sl()));

  // --- Blocs ---
  sl.registerFactory(
    () => ExploreBloc(
      getLocationUseCase: sl(),
      getMarkersUseCase: sl(),
      getNearestUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => RestaurantDetailBloc(
      getRestaurantByIdUseCase: sl(),
      toggleFavouriteUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 8. RESERVATION MODULE
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<ReservationRemoteDataSource>(
    () => ReservationRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<ReservationRepository>(
    () => ReservationRepositoryImpl(sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => GetReservationSceneUseCase(sl()));
  sl.registerLazySingleton(() => GetTableStatusesUseCase(sl()));
  sl.registerLazySingleton(() => GetAvailableSlotsUseCase(sl()));
  sl.registerLazySingleton(() => CreateReservationUseCase(sl()));
  sl.registerLazySingleton(() => GetMyReservationsOverviewUseCase(sl()));
  sl.registerLazySingleton(() => GetMyReservationsHistoryUseCase(sl()));
  sl.registerLazySingleton(() => UpdateReservationUseCase(sl()));
  sl.registerLazySingleton(() => CancelReservationUseCase(sl()));

  // --- Blocs ---
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
    ),
  );

  // ===========================================================================
  // 9. MY RESTAURANT MODULE (Management)
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<MyRestaurantRemoteDataSource>(
    () => MyRestaurantRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<MyRestaurantRepository>(
    () => MyRestaurantRepositoryImpl(sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => GetMyRestaurantUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRestaurantInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetEmployeesUseCase(sl()));
  sl.registerLazySingleton(() => AddEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEmployeeRoleUseCase(sl()));
  sl.registerLazySingleton(() => RemoveEmployeeUseCase(sl()));

  // --- Blocs ---
  sl.registerFactory(
    () => MyRestaurantBloc(
      getMyRestaurantUseCase: sl(),
      updateRestaurantInfoUseCase: sl(),
      getEmployeesUseCase: sl(),
      addEmployeeUseCase: sl(),
      updateEmployeeRoleUseCase: sl(),
      removeEmployeeUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 9b. STAFF RESERVATIONS MODULE (Management)
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<StaffReservationRemoteDataSource>(
    () => StaffReservationRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<StaffReservationRepository>(
    () => StaffReservationRepositoryImpl(sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => GetStaffReservationsUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmReservationUseCase(sl()));
  sl.registerLazySingleton(() => RejectReservationUseCase(sl()));
  sl.registerLazySingleton(() => CheckInReservationUseCase(sl()));
  sl.registerLazySingleton(() => CompleteReservationUseCase(sl()));

  // --- Blocs ---
  sl.registerFactory(
    () => StaffReservationsBloc(
      getReservations: sl(),
      confirm: sl(),
      reject: sl(),
      checkIn: sl(),
      complete: sl(),
    ),
  );

  // ===========================================================================
  // 10. ORDERS MODULE
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<OrdersRemoteDataSource>(
    () => OrdersRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<OrdersRepository>(
    () => OrdersRepositoryImpl(sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => GetDiningContextUseCase(sl()));
  sl.registerLazySingleton(() => GetMenuUseCase(sl()));
  sl.registerLazySingleton(() => CreateOrderUseCase(sl()));
  sl.registerLazySingleton(() => GetCurrentOrdersUseCase(sl()));

  // --- Blocs ---
  sl.registerFactory(
    () => OrdersBloc(
      getDiningContextUseCase: sl(),
      getMenuUseCase: sl(),
      createOrderUseCase: sl(),
      getCurrentOrdersUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 11. OWNER CLAIM MODULE
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<OwnerClaimRemoteDataSource>(
    () => OwnerClaimRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<OwnerClaimRepository>(
    () => OwnerClaimRepositoryImpl(sl()),
  );

  // --- Use Cases ---
  sl.registerLazySingleton(() => LookupAresUseCase(sl()));
  sl.registerLazySingleton(() => VerifyBankIdUseCase(sl()));
  sl.registerLazySingleton(() => StartEmailClaimUseCase(sl()));
  sl.registerLazySingleton(() => ConfirmEmailClaimUseCase(sl()));

  // --- Blocs ---
  sl.registerFactory(
    () => OwnerClaimBloc(
      lookupAresUseCase: sl(),
      verifyBankIdUseCase: sl(),
      startEmailClaimUseCase: sl(),
      confirmEmailClaimUseCase: sl(),
    ),
  );

  // ===========================================================================
  // 12. OWNER ONBOARDING MODULE
  // ===========================================================================

  // --- Data Sources ---
  sl.registerLazySingleton<OnboardingRemoteDataSource>(
    () => OnboardingRemoteDataSourceImpl(sl()),
  );

  // --- Repositories ---
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );

  // --- Use Cases ---
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

  // --- Blocs ---
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
