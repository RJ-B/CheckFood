// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_wizard_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$OnboardingWizardEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingWizardEventCopyWith<$Res> {
  factory $OnboardingWizardEventCopyWith(
    OnboardingWizardEvent value,
    $Res Function(OnboardingWizardEvent) then,
  ) = _$OnboardingWizardEventCopyWithImpl<$Res, OnboardingWizardEvent>;
}

/// @nodoc
class _$OnboardingWizardEventCopyWithImpl<
  $Res,
  $Val extends OnboardingWizardEvent
>
    implements $OnboardingWizardEventCopyWith<$Res> {
  _$OnboardingWizardEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadOnboardingImplCopyWith<$Res> {
  factory _$$LoadOnboardingImplCopyWith(
    _$LoadOnboardingImpl value,
    $Res Function(_$LoadOnboardingImpl) then,
  ) = __$$LoadOnboardingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadOnboardingImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$LoadOnboardingImpl>
    implements _$$LoadOnboardingImplCopyWith<$Res> {
  __$$LoadOnboardingImplCopyWithImpl(
    _$LoadOnboardingImpl _value,
    $Res Function(_$LoadOnboardingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadOnboardingImpl implements LoadOnboarding {
  const _$LoadOnboardingImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.loadOnboarding()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadOnboardingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return loadOnboarding();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return loadOnboarding?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (loadOnboarding != null) {
      return loadOnboarding();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return loadOnboarding(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return loadOnboarding?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (loadOnboarding != null) {
      return loadOnboarding(this);
    }
    return orElse();
  }
}

abstract class LoadOnboarding implements OnboardingWizardEvent {
  const factory LoadOnboarding() = _$LoadOnboardingImpl;
}

/// @nodoc
abstract class _$$GoToStepImplCopyWith<$Res> {
  factory _$$GoToStepImplCopyWith(
    _$GoToStepImpl value,
    $Res Function(_$GoToStepImpl) then,
  ) = __$$GoToStepImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int step});
}

/// @nodoc
class __$$GoToStepImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$GoToStepImpl>
    implements _$$GoToStepImplCopyWith<$Res> {
  __$$GoToStepImplCopyWithImpl(
    _$GoToStepImpl _value,
    $Res Function(_$GoToStepImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? step = null}) {
    return _then(
      _$GoToStepImpl(
        null == step
            ? _value.step
            : step // ignore: cast_nullable_to_non_nullable
                as int,
      ),
    );
  }
}

/// @nodoc

class _$GoToStepImpl implements GoToStep {
  const _$GoToStepImpl(this.step);

  @override
  final int step;

  @override
  String toString() {
    return 'OnboardingWizardEvent.goToStep(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GoToStepImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GoToStepImplCopyWith<_$GoToStepImpl> get copyWith =>
      __$$GoToStepImplCopyWithImpl<_$GoToStepImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return goToStep(step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return goToStep?.call(step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (goToStep != null) {
      return goToStep(step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return goToStep(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return goToStep?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (goToStep != null) {
      return goToStep(this);
    }
    return orElse();
  }
}

abstract class GoToStep implements OnboardingWizardEvent {
  const factory GoToStep(final int step) = _$GoToStepImpl;

  int get step;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GoToStepImplCopyWith<_$GoToStepImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateInfoImplCopyWith<$Res> {
  factory _$$UpdateInfoImplCopyWith(
    _$UpdateInfoImpl value,
    $Res Function(_$UpdateInfoImpl) then,
  ) = __$$UpdateInfoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String name,
    String? description,
    String? phone,
    String? email,
    AddressModel? address,
    String? cuisineType,
  });

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$UpdateInfoImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UpdateInfoImpl>
    implements _$$UpdateInfoImplCopyWith<$Res> {
  __$$UpdateInfoImplCopyWithImpl(
    _$UpdateInfoImpl _value,
    $Res Function(_$UpdateInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? address = freezed,
    Object? cuisineType = freezed,
  }) {
    return _then(
      _$UpdateInfoImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        phone:
            freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                    as String?,
        email:
            freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String?,
        address:
            freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                    as AddressModel?,
        cuisineType:
            freezed == cuisineType
                ? _value.cuisineType
                : cuisineType // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value));
    });
  }
}

/// @nodoc

class _$UpdateInfoImpl implements UpdateInfo {
  const _$UpdateInfoImpl({
    required this.name,
    this.description,
    this.phone,
    this.email,
    this.address,
    this.cuisineType,
  });

  @override
  final String name;
  @override
  final String? description;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final AddressModel? address;
  @override
  final String? cuisineType;

  @override
  String toString() {
    return 'OnboardingWizardEvent.updateInfo(name: $name, description: $description, phone: $phone, email: $email, address: $address, cuisineType: $cuisineType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.cuisineType, cuisineType) ||
                other.cuisineType == cuisineType));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    description,
    phone,
    email,
    address,
    cuisineType,
  );

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateInfoImplCopyWith<_$UpdateInfoImpl> get copyWith =>
      __$$UpdateInfoImplCopyWithImpl<_$UpdateInfoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return updateInfo(name, description, phone, email, address, cuisineType);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return updateInfo?.call(
      name,
      description,
      phone,
      email,
      address,
      cuisineType,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (updateInfo != null) {
      return updateInfo(name, description, phone, email, address, cuisineType);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return updateInfo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return updateInfo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (updateInfo != null) {
      return updateInfo(this);
    }
    return orElse();
  }
}

abstract class UpdateInfo implements OnboardingWizardEvent {
  const factory UpdateInfo({
    required final String name,
    final String? description,
    final String? phone,
    final String? email,
    final AddressModel? address,
    final String? cuisineType,
  }) = _$UpdateInfoImpl;

  String get name;
  String? get description;
  String? get phone;
  String? get email;
  AddressModel? get address;
  String? get cuisineType;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateInfoImplCopyWith<_$UpdateInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateHoursImplCopyWith<$Res> {
  factory _$$UpdateHoursImplCopyWith(
    _$UpdateHoursImpl value,
    $Res Function(_$UpdateHoursImpl) then,
  ) = __$$UpdateHoursImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<OpeningHoursModel> hours});
}

/// @nodoc
class __$$UpdateHoursImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UpdateHoursImpl>
    implements _$$UpdateHoursImplCopyWith<$Res> {
  __$$UpdateHoursImplCopyWithImpl(
    _$UpdateHoursImpl _value,
    $Res Function(_$UpdateHoursImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? hours = null}) {
    return _then(
      _$UpdateHoursImpl(
        null == hours
            ? _value._hours
            : hours // ignore: cast_nullable_to_non_nullable
                as List<OpeningHoursModel>,
      ),
    );
  }
}

/// @nodoc

class _$UpdateHoursImpl implements UpdateHours {
  const _$UpdateHoursImpl(final List<OpeningHoursModel> hours) : _hours = hours;

  final List<OpeningHoursModel> _hours;
  @override
  List<OpeningHoursModel> get hours {
    if (_hours is EqualUnmodifiableListView) return _hours;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hours);
  }

  @override
  String toString() {
    return 'OnboardingWizardEvent.updateHours(hours: $hours)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateHoursImpl &&
            const DeepCollectionEquality().equals(other._hours, _hours));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_hours));

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateHoursImplCopyWith<_$UpdateHoursImpl> get copyWith =>
      __$$UpdateHoursImplCopyWithImpl<_$UpdateHoursImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return updateHours(hours);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return updateHours?.call(hours);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (updateHours != null) {
      return updateHours(hours);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return updateHours(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return updateHours?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (updateHours != null) {
      return updateHours(this);
    }
    return orElse();
  }
}

abstract class UpdateHours implements OnboardingWizardEvent {
  const factory UpdateHours(final List<OpeningHoursModel> hours) =
      _$UpdateHoursImpl;

  List<OpeningHoursModel> get hours;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateHoursImplCopyWith<_$UpdateHoursImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadTablesImplCopyWith<$Res> {
  factory _$$LoadTablesImplCopyWith(
    _$LoadTablesImpl value,
    $Res Function(_$LoadTablesImpl) then,
  ) = __$$LoadTablesImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadTablesImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$LoadTablesImpl>
    implements _$$LoadTablesImplCopyWith<$Res> {
  __$$LoadTablesImplCopyWithImpl(
    _$LoadTablesImpl _value,
    $Res Function(_$LoadTablesImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadTablesImpl implements LoadTables {
  const _$LoadTablesImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.loadTables()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadTablesImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return loadTables();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return loadTables?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (loadTables != null) {
      return loadTables();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return loadTables(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return loadTables?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (loadTables != null) {
      return loadTables(this);
    }
    return orElse();
  }
}

abstract class LoadTables implements OnboardingWizardEvent {
  const factory LoadTables() = _$LoadTablesImpl;
}

/// @nodoc
abstract class _$$AddTableImplCopyWith<$Res> {
  factory _$$AddTableImplCopyWith(
    _$AddTableImpl value,
    $Res Function(_$AddTableImpl) then,
  ) = __$$AddTableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String label, int capacity});
}

/// @nodoc
class __$$AddTableImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$AddTableImpl>
    implements _$$AddTableImplCopyWith<$Res> {
  __$$AddTableImplCopyWithImpl(
    _$AddTableImpl _value,
    $Res Function(_$AddTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? label = null, Object? capacity = null}) {
    return _then(
      _$AddTableImpl(
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        capacity:
            null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$AddTableImpl implements AddTable {
  const _$AddTableImpl({required this.label, required this.capacity});

  @override
  final String label;
  @override
  final int capacity;

  @override
  String toString() {
    return 'OnboardingWizardEvent.addTable(label: $label, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddTableImpl &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, label, capacity);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddTableImplCopyWith<_$AddTableImpl> get copyWith =>
      __$$AddTableImplCopyWithImpl<_$AddTableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return addTable(label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return addTable?.call(label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (addTable != null) {
      return addTable(label, capacity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return addTable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return addTable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (addTable != null) {
      return addTable(this);
    }
    return orElse();
  }
}

abstract class AddTable implements OnboardingWizardEvent {
  const factory AddTable({
    required final String label,
    required final int capacity,
  }) = _$AddTableImpl;

  String get label;
  int get capacity;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddTableImplCopyWith<_$AddTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateTableImplCopyWith<$Res> {
  factory _$$UpdateTableImplCopyWith(
    _$UpdateTableImpl value,
    $Res Function(_$UpdateTableImpl) then,
  ) = __$$UpdateTableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String label, int capacity});
}

/// @nodoc
class __$$UpdateTableImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UpdateTableImpl>
    implements _$$UpdateTableImplCopyWith<$Res> {
  __$$UpdateTableImplCopyWithImpl(
    _$UpdateTableImpl _value,
    $Res Function(_$UpdateTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? label = null,
    Object? capacity = null,
  }) {
    return _then(
      _$UpdateTableImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        label:
            null == label
                ? _value.label
                : label // ignore: cast_nullable_to_non_nullable
                    as String,
        capacity:
            null == capacity
                ? _value.capacity
                : capacity // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$UpdateTableImpl implements UpdateTable {
  const _$UpdateTableImpl({
    required this.id,
    required this.label,
    required this.capacity,
  });

  @override
  final String id;
  @override
  final String label;
  @override
  final int capacity;

  @override
  String toString() {
    return 'OnboardingWizardEvent.updateTable(id: $id, label: $label, capacity: $capacity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateTableImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, label, capacity);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateTableImplCopyWith<_$UpdateTableImpl> get copyWith =>
      __$$UpdateTableImplCopyWithImpl<_$UpdateTableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return updateTable(id, label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return updateTable?.call(id, label, capacity);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (updateTable != null) {
      return updateTable(id, label, capacity);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return updateTable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return updateTable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (updateTable != null) {
      return updateTable(this);
    }
    return orElse();
  }
}

abstract class UpdateTable implements OnboardingWizardEvent {
  const factory UpdateTable({
    required final String id,
    required final String label,
    required final int capacity,
  }) = _$UpdateTableImpl;

  String get id;
  String get label;
  int get capacity;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateTableImplCopyWith<_$UpdateTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteTableImplCopyWith<$Res> {
  factory _$$DeleteTableImplCopyWith(
    _$DeleteTableImpl value,
    $Res Function(_$DeleteTableImpl) then,
  ) = __$$DeleteTableImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteTableImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$DeleteTableImpl>
    implements _$$DeleteTableImplCopyWith<$Res> {
  __$$DeleteTableImplCopyWithImpl(
    _$DeleteTableImpl _value,
    $Res Function(_$DeleteTableImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteTableImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteTableImpl implements DeleteTable {
  const _$DeleteTableImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'OnboardingWizardEvent.deleteTable(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteTableImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteTableImplCopyWith<_$DeleteTableImpl> get copyWith =>
      __$$DeleteTableImplCopyWithImpl<_$DeleteTableImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return deleteTable(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return deleteTable?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (deleteTable != null) {
      return deleteTable(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return deleteTable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return deleteTable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (deleteTable != null) {
      return deleteTable(this);
    }
    return orElse();
  }
}

abstract class DeleteTable implements OnboardingWizardEvent {
  const factory DeleteTable(final String id) = _$DeleteTableImpl;

  String get id;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteTableImplCopyWith<_$DeleteTableImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadMenuImplCopyWith<$Res> {
  factory _$$LoadMenuImplCopyWith(
    _$LoadMenuImpl value,
    $Res Function(_$LoadMenuImpl) then,
  ) = __$$LoadMenuImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadMenuImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$LoadMenuImpl>
    implements _$$LoadMenuImplCopyWith<$Res> {
  __$$LoadMenuImplCopyWithImpl(
    _$LoadMenuImpl _value,
    $Res Function(_$LoadMenuImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadMenuImpl implements LoadMenu {
  const _$LoadMenuImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.loadMenu()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadMenuImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return loadMenu();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return loadMenu?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (loadMenu != null) {
      return loadMenu();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return loadMenu(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return loadMenu?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (loadMenu != null) {
      return loadMenu(this);
    }
    return orElse();
  }
}

abstract class LoadMenu implements OnboardingWizardEvent {
  const factory LoadMenu() = _$LoadMenuImpl;
}

/// @nodoc
abstract class _$$CreateCategoryImplCopyWith<$Res> {
  factory _$$CreateCategoryImplCopyWith(
    _$CreateCategoryImpl value,
    $Res Function(_$CreateCategoryImpl) then,
  ) = __$$CreateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name});
}

/// @nodoc
class __$$CreateCategoryImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$CreateCategoryImpl>
    implements _$$CreateCategoryImplCopyWith<$Res> {
  __$$CreateCategoryImplCopyWithImpl(
    _$CreateCategoryImpl _value,
    $Res Function(_$CreateCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? name = null}) {
    return _then(
      _$CreateCategoryImpl(
        null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$CreateCategoryImpl implements CreateCategory {
  const _$CreateCategoryImpl(this.name);

  @override
  final String name;

  @override
  String toString() {
    return 'OnboardingWizardEvent.createCategory(name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateCategoryImpl &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateCategoryImplCopyWith<_$CreateCategoryImpl> get copyWith =>
      __$$CreateCategoryImplCopyWithImpl<_$CreateCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return createCategory(name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return createCategory?.call(name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (createCategory != null) {
      return createCategory(name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return createCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return createCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (createCategory != null) {
      return createCategory(this);
    }
    return orElse();
  }
}

abstract class CreateCategory implements OnboardingWizardEvent {
  const factory CreateCategory(final String name) = _$CreateCategoryImpl;

  String get name;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateCategoryImplCopyWith<_$CreateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateCategoryImplCopyWith<$Res> {
  factory _$$UpdateCategoryImplCopyWith(
    _$UpdateCategoryImpl value,
    $Res Function(_$UpdateCategoryImpl) then,
  ) = __$$UpdateCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String name});
}

/// @nodoc
class __$$UpdateCategoryImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UpdateCategoryImpl>
    implements _$$UpdateCategoryImplCopyWith<$Res> {
  __$$UpdateCategoryImplCopyWithImpl(
    _$UpdateCategoryImpl _value,
    $Res Function(_$UpdateCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$UpdateCategoryImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$UpdateCategoryImpl implements UpdateCategory {
  const _$UpdateCategoryImpl({required this.id, required this.name});

  @override
  final String id;
  @override
  final String name;

  @override
  String toString() {
    return 'OnboardingWizardEvent.updateCategory(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      __$$UpdateCategoryImplCopyWithImpl<_$UpdateCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return updateCategory(id, name);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return updateCategory?.call(id, name);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(id, name);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return updateCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return updateCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (updateCategory != null) {
      return updateCategory(this);
    }
    return orElse();
  }
}

abstract class UpdateCategory implements OnboardingWizardEvent {
  const factory UpdateCategory({
    required final String id,
    required final String name,
  }) = _$UpdateCategoryImpl;

  String get id;
  String get name;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateCategoryImplCopyWith<_$UpdateCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteCategoryImplCopyWith<$Res> {
  factory _$$DeleteCategoryImplCopyWith(
    _$DeleteCategoryImpl value,
    $Res Function(_$DeleteCategoryImpl) then,
  ) = __$$DeleteCategoryImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteCategoryImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$DeleteCategoryImpl>
    implements _$$DeleteCategoryImplCopyWith<$Res> {
  __$$DeleteCategoryImplCopyWithImpl(
    _$DeleteCategoryImpl _value,
    $Res Function(_$DeleteCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteCategoryImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteCategoryImpl implements DeleteCategory {
  const _$DeleteCategoryImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'OnboardingWizardEvent.deleteCategory(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteCategoryImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      __$$DeleteCategoryImplCopyWithImpl<_$DeleteCategoryImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return deleteCategory(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return deleteCategory?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return deleteCategory(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return deleteCategory?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (deleteCategory != null) {
      return deleteCategory(this);
    }
    return orElse();
  }
}

abstract class DeleteCategory implements OnboardingWizardEvent {
  const factory DeleteCategory(final String id) = _$DeleteCategoryImpl;

  String get id;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteCategoryImplCopyWith<_$DeleteCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreateItemImplCopyWith<$Res> {
  factory _$$CreateItemImplCopyWith(
    _$CreateItemImpl value,
    $Res Function(_$CreateItemImpl) then,
  ) = __$$CreateItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String categoryId,
    String name,
    String? description,
    int priceMinor,
  });
}

/// @nodoc
class __$$CreateItemImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$CreateItemImpl>
    implements _$$CreateItemImplCopyWith<$Res> {
  __$$CreateItemImplCopyWithImpl(
    _$CreateItemImpl _value,
    $Res Function(_$CreateItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
  }) {
    return _then(
      _$CreateItemImpl(
        categoryId:
            null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        priceMinor:
            null == priceMinor
                ? _value.priceMinor
                : priceMinor // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$CreateItemImpl implements CreateItem {
  const _$CreateItemImpl({
    required this.categoryId,
    required this.name,
    this.description,
    required this.priceMinor,
  });

  @override
  final String categoryId;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int priceMinor;

  @override
  String toString() {
    return 'OnboardingWizardEvent.createItem(categoryId: $categoryId, name: $name, description: $description, priceMinor: $priceMinor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateItemImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceMinor, priceMinor) ||
                other.priceMinor == priceMinor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, categoryId, name, description, priceMinor);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateItemImplCopyWith<_$CreateItemImpl> get copyWith =>
      __$$CreateItemImplCopyWithImpl<_$CreateItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return createItem(categoryId, name, description, priceMinor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return createItem?.call(categoryId, name, description, priceMinor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (createItem != null) {
      return createItem(categoryId, name, description, priceMinor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return createItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return createItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (createItem != null) {
      return createItem(this);
    }
    return orElse();
  }
}

abstract class CreateItem implements OnboardingWizardEvent {
  const factory CreateItem({
    required final String categoryId,
    required final String name,
    final String? description,
    required final int priceMinor,
  }) = _$CreateItemImpl;

  String get categoryId;
  String get name;
  String? get description;
  int get priceMinor;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateItemImplCopyWith<_$CreateItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateItemImplCopyWith<$Res> {
  factory _$$UpdateItemImplCopyWith(
    _$UpdateItemImpl value,
    $Res Function(_$UpdateItemImpl) then,
  ) = __$$UpdateItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String name, String? description, int priceMinor});
}

/// @nodoc
class __$$UpdateItemImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UpdateItemImpl>
    implements _$$UpdateItemImplCopyWith<$Res> {
  __$$UpdateItemImplCopyWithImpl(
    _$UpdateItemImpl _value,
    $Res Function(_$UpdateItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? priceMinor = null,
  }) {
    return _then(
      _$UpdateItemImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        description:
            freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                    as String?,
        priceMinor:
            null == priceMinor
                ? _value.priceMinor
                : priceMinor // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc

class _$UpdateItemImpl implements UpdateItem {
  const _$UpdateItemImpl({
    required this.id,
    required this.name,
    this.description,
    required this.priceMinor,
  });

  @override
  final String id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final int priceMinor;

  @override
  String toString() {
    return 'OnboardingWizardEvent.updateItem(id: $id, name: $name, description: $description, priceMinor: $priceMinor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.priceMinor, priceMinor) ||
                other.priceMinor == priceMinor));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, priceMinor);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateItemImplCopyWith<_$UpdateItemImpl> get copyWith =>
      __$$UpdateItemImplCopyWithImpl<_$UpdateItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return updateItem(id, name, description, priceMinor);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return updateItem?.call(id, name, description, priceMinor);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (updateItem != null) {
      return updateItem(id, name, description, priceMinor);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return updateItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return updateItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (updateItem != null) {
      return updateItem(this);
    }
    return orElse();
  }
}

abstract class UpdateItem implements OnboardingWizardEvent {
  const factory UpdateItem({
    required final String id,
    required final String name,
    final String? description,
    required final int priceMinor,
  }) = _$UpdateItemImpl;

  String get id;
  String get name;
  String? get description;
  int get priceMinor;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UpdateItemImplCopyWith<_$UpdateItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$DeleteItemImplCopyWith<$Res> {
  factory _$$DeleteItemImplCopyWith(
    _$DeleteItemImpl value,
    $Res Function(_$DeleteItemImpl) then,
  ) = __$$DeleteItemImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$$DeleteItemImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$DeleteItemImpl>
    implements _$$DeleteItemImplCopyWith<$Res> {
  __$$DeleteItemImplCopyWithImpl(
    _$DeleteItemImpl _value,
    $Res Function(_$DeleteItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null}) {
    return _then(
      _$DeleteItemImpl(
        null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$DeleteItemImpl implements DeleteItem {
  const _$DeleteItemImpl(this.id);

  @override
  final String id;

  @override
  String toString() {
    return 'OnboardingWizardEvent.deleteItem(id: $id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteItemImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteItemImplCopyWith<_$DeleteItemImpl> get copyWith =>
      __$$DeleteItemImplCopyWithImpl<_$DeleteItemImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return deleteItem(id);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return deleteItem?.call(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (deleteItem != null) {
      return deleteItem(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return deleteItem(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return deleteItem?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (deleteItem != null) {
      return deleteItem(this);
    }
    return orElse();
  }
}

abstract class DeleteItem implements OnboardingWizardEvent {
  const factory DeleteItem(final String id) = _$DeleteItemImpl;

  String get id;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteItemImplCopyWith<_$DeleteItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CreatePanoramaSessionImplCopyWith<$Res> {
  factory _$$CreatePanoramaSessionImplCopyWith(
    _$CreatePanoramaSessionImpl value,
    $Res Function(_$CreatePanoramaSessionImpl) then,
  ) = __$$CreatePanoramaSessionImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CreatePanoramaSessionImplCopyWithImpl<$Res>
    extends
        _$OnboardingWizardEventCopyWithImpl<$Res, _$CreatePanoramaSessionImpl>
    implements _$$CreatePanoramaSessionImplCopyWith<$Res> {
  __$$CreatePanoramaSessionImplCopyWithImpl(
    _$CreatePanoramaSessionImpl _value,
    $Res Function(_$CreatePanoramaSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CreatePanoramaSessionImpl implements CreatePanoramaSession {
  const _$CreatePanoramaSessionImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.createPanoramaSession()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatePanoramaSessionImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return createPanoramaSession();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return createPanoramaSession?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (createPanoramaSession != null) {
      return createPanoramaSession();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return createPanoramaSession(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return createPanoramaSession?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (createPanoramaSession != null) {
      return createPanoramaSession(this);
    }
    return orElse();
  }
}

abstract class CreatePanoramaSession implements OnboardingWizardEvent {
  const factory CreatePanoramaSession() = _$CreatePanoramaSessionImpl;
}

/// @nodoc
abstract class _$$UploadPhotoImplCopyWith<$Res> {
  factory _$$UploadPhotoImplCopyWith(
    _$UploadPhotoImpl value,
    $Res Function(_$UploadPhotoImpl) then,
  ) = __$$UploadPhotoImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String sessionId,
    int angleIndex,
    double actualAngle,
    double? actualPitch,
    Uint8List fileBytes,
    String filename,
  });
}

/// @nodoc
class __$$UploadPhotoImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$UploadPhotoImpl>
    implements _$$UploadPhotoImplCopyWith<$Res> {
  __$$UploadPhotoImplCopyWithImpl(
    _$UploadPhotoImpl _value,
    $Res Function(_$UploadPhotoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sessionId = null,
    Object? angleIndex = null,
    Object? actualAngle = null,
    Object? actualPitch = freezed,
    Object? fileBytes = null,
    Object? filename = null,
  }) {
    return _then(
      _$UploadPhotoImpl(
        sessionId:
            null == sessionId
                ? _value.sessionId
                : sessionId // ignore: cast_nullable_to_non_nullable
                    as String,
        angleIndex:
            null == angleIndex
                ? _value.angleIndex
                : angleIndex // ignore: cast_nullable_to_non_nullable
                    as int,
        actualAngle:
            null == actualAngle
                ? _value.actualAngle
                : actualAngle // ignore: cast_nullable_to_non_nullable
                    as double,
        actualPitch:
            freezed == actualPitch
                ? _value.actualPitch
                : actualPitch // ignore: cast_nullable_to_non_nullable
                    as double?,
        fileBytes:
            null == fileBytes
                ? _value.fileBytes
                : fileBytes // ignore: cast_nullable_to_non_nullable
                    as Uint8List,
        filename:
            null == filename
                ? _value.filename
                : filename // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc

class _$UploadPhotoImpl implements UploadPhoto {
  const _$UploadPhotoImpl({
    required this.sessionId,
    required this.angleIndex,
    required this.actualAngle,
    this.actualPitch,
    required this.fileBytes,
    required this.filename,
  });

  @override
  final String sessionId;
  @override
  final int angleIndex;
  @override
  final double actualAngle;
  @override
  final double? actualPitch;
  @override
  final Uint8List fileBytes;
  @override
  final String filename;

  @override
  String toString() {
    return 'OnboardingWizardEvent.uploadPhoto(sessionId: $sessionId, angleIndex: $angleIndex, actualAngle: $actualAngle, actualPitch: $actualPitch, fileBytes: $fileBytes, filename: $filename)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadPhotoImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId) &&
            (identical(other.angleIndex, angleIndex) ||
                other.angleIndex == angleIndex) &&
            (identical(other.actualAngle, actualAngle) ||
                other.actualAngle == actualAngle) &&
            (identical(other.actualPitch, actualPitch) ||
                other.actualPitch == actualPitch) &&
            const DeepCollectionEquality().equals(other.fileBytes, fileBytes) &&
            (identical(other.filename, filename) ||
                other.filename == filename));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    sessionId,
    angleIndex,
    actualAngle,
    actualPitch,
    const DeepCollectionEquality().hash(fileBytes),
    filename,
  );

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadPhotoImplCopyWith<_$UploadPhotoImpl> get copyWith =>
      __$$UploadPhotoImplCopyWithImpl<_$UploadPhotoImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return uploadPhoto(
      sessionId,
      angleIndex,
      actualAngle,
      actualPitch,
      fileBytes,
      filename,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return uploadPhoto?.call(
      sessionId,
      angleIndex,
      actualAngle,
      actualPitch,
      fileBytes,
      filename,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (uploadPhoto != null) {
      return uploadPhoto(
        sessionId,
        angleIndex,
        actualAngle,
        actualPitch,
        fileBytes,
        filename,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return uploadPhoto(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return uploadPhoto?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (uploadPhoto != null) {
      return uploadPhoto(this);
    }
    return orElse();
  }
}

abstract class UploadPhoto implements OnboardingWizardEvent {
  const factory UploadPhoto({
    required final String sessionId,
    required final int angleIndex,
    required final double actualAngle,
    final double? actualPitch,
    required final Uint8List fileBytes,
    required final String filename,
  }) = _$UploadPhotoImpl;

  String get sessionId;
  int get angleIndex;
  double get actualAngle;
  double? get actualPitch;
  Uint8List get fileBytes;
  String get filename;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadPhotoImplCopyWith<_$UploadPhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FinalizePanoramaImplCopyWith<$Res> {
  factory _$$FinalizePanoramaImplCopyWith(
    _$FinalizePanoramaImpl value,
    $Res Function(_$FinalizePanoramaImpl) then,
  ) = __$$FinalizePanoramaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$FinalizePanoramaImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$FinalizePanoramaImpl>
    implements _$$FinalizePanoramaImplCopyWith<$Res> {
  __$$FinalizePanoramaImplCopyWithImpl(
    _$FinalizePanoramaImpl _value,
    $Res Function(_$FinalizePanoramaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sessionId = null}) {
    return _then(
      _$FinalizePanoramaImpl(
        null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$FinalizePanoramaImpl implements FinalizePanorama {
  const _$FinalizePanoramaImpl(this.sessionId);

  @override
  final String sessionId;

  @override
  String toString() {
    return 'OnboardingWizardEvent.finalizePanorama(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FinalizePanoramaImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FinalizePanoramaImplCopyWith<_$FinalizePanoramaImpl> get copyWith =>
      __$$FinalizePanoramaImplCopyWithImpl<_$FinalizePanoramaImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return finalizePanorama(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return finalizePanorama?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (finalizePanorama != null) {
      return finalizePanorama(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return finalizePanorama(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return finalizePanorama?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (finalizePanorama != null) {
      return finalizePanorama(this);
    }
    return orElse();
  }
}

abstract class FinalizePanorama implements OnboardingWizardEvent {
  const factory FinalizePanorama(final String sessionId) =
      _$FinalizePanoramaImpl;

  String get sessionId;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FinalizePanoramaImplCopyWith<_$FinalizePanoramaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ActivatePanoramaImplCopyWith<$Res> {
  factory _$$ActivatePanoramaImplCopyWith(
    _$ActivatePanoramaImpl value,
    $Res Function(_$ActivatePanoramaImpl) then,
  ) = __$$ActivatePanoramaImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$ActivatePanoramaImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$ActivatePanoramaImpl>
    implements _$$ActivatePanoramaImplCopyWith<$Res> {
  __$$ActivatePanoramaImplCopyWithImpl(
    _$ActivatePanoramaImpl _value,
    $Res Function(_$ActivatePanoramaImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sessionId = null}) {
    return _then(
      _$ActivatePanoramaImpl(
        null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$ActivatePanoramaImpl implements ActivatePanorama {
  const _$ActivatePanoramaImpl(this.sessionId);

  @override
  final String sessionId;

  @override
  String toString() {
    return 'OnboardingWizardEvent.activatePanorama(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivatePanoramaImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivatePanoramaImplCopyWith<_$ActivatePanoramaImpl> get copyWith =>
      __$$ActivatePanoramaImplCopyWithImpl<_$ActivatePanoramaImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return activatePanorama(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return activatePanorama?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (activatePanorama != null) {
      return activatePanorama(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return activatePanorama(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return activatePanorama?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (activatePanorama != null) {
      return activatePanorama(this);
    }
    return orElse();
  }
}

abstract class ActivatePanorama implements OnboardingWizardEvent {
  const factory ActivatePanorama(final String sessionId) =
      _$ActivatePanoramaImpl;

  String get sessionId;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivatePanoramaImplCopyWith<_$ActivatePanoramaImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoadPanoramaSessionsImplCopyWith<$Res> {
  factory _$$LoadPanoramaSessionsImplCopyWith(
    _$LoadPanoramaSessionsImpl value,
    $Res Function(_$LoadPanoramaSessionsImpl) then,
  ) = __$$LoadPanoramaSessionsImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadPanoramaSessionsImplCopyWithImpl<$Res>
    extends
        _$OnboardingWizardEventCopyWithImpl<$Res, _$LoadPanoramaSessionsImpl>
    implements _$$LoadPanoramaSessionsImplCopyWith<$Res> {
  __$$LoadPanoramaSessionsImplCopyWithImpl(
    _$LoadPanoramaSessionsImpl _value,
    $Res Function(_$LoadPanoramaSessionsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadPanoramaSessionsImpl implements LoadPanoramaSessions {
  const _$LoadPanoramaSessionsImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.loadPanoramaSessions()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadPanoramaSessionsImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return loadPanoramaSessions();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return loadPanoramaSessions?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (loadPanoramaSessions != null) {
      return loadPanoramaSessions();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return loadPanoramaSessions(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return loadPanoramaSessions?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (loadPanoramaSessions != null) {
      return loadPanoramaSessions(this);
    }
    return orElse();
  }
}

abstract class LoadPanoramaSessions implements OnboardingWizardEvent {
  const factory LoadPanoramaSessions() = _$LoadPanoramaSessionsImpl;
}

/// @nodoc
abstract class _$$PollPanoramaStatusImplCopyWith<$Res> {
  factory _$$PollPanoramaStatusImplCopyWith(
    _$PollPanoramaStatusImpl value,
    $Res Function(_$PollPanoramaStatusImpl) then,
  ) = __$$PollPanoramaStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String sessionId});
}

/// @nodoc
class __$$PollPanoramaStatusImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$PollPanoramaStatusImpl>
    implements _$$PollPanoramaStatusImplCopyWith<$Res> {
  __$$PollPanoramaStatusImplCopyWithImpl(
    _$PollPanoramaStatusImpl _value,
    $Res Function(_$PollPanoramaStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sessionId = null}) {
    return _then(
      _$PollPanoramaStatusImpl(
        null == sessionId
            ? _value.sessionId
            : sessionId // ignore: cast_nullable_to_non_nullable
                as String,
      ),
    );
  }
}

/// @nodoc

class _$PollPanoramaStatusImpl implements PollPanoramaStatus {
  const _$PollPanoramaStatusImpl(this.sessionId);

  @override
  final String sessionId;

  @override
  String toString() {
    return 'OnboardingWizardEvent.pollPanoramaStatus(sessionId: $sessionId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PollPanoramaStatusImpl &&
            (identical(other.sessionId, sessionId) ||
                other.sessionId == sessionId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, sessionId);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PollPanoramaStatusImplCopyWith<_$PollPanoramaStatusImpl> get copyWith =>
      __$$PollPanoramaStatusImplCopyWithImpl<_$PollPanoramaStatusImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return pollPanoramaStatus(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return pollPanoramaStatus?.call(sessionId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (pollPanoramaStatus != null) {
      return pollPanoramaStatus(sessionId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return pollPanoramaStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return pollPanoramaStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (pollPanoramaStatus != null) {
      return pollPanoramaStatus(this);
    }
    return orElse();
  }
}

abstract class PollPanoramaStatus implements OnboardingWizardEvent {
  const factory PollPanoramaStatus(final String sessionId) =
      _$PollPanoramaStatusImpl;

  String get sessionId;

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PollPanoramaStatusImplCopyWith<_$PollPanoramaStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PublishImplCopyWith<$Res> {
  factory _$$PublishImplCopyWith(
    _$PublishImpl value,
    $Res Function(_$PublishImpl) then,
  ) = __$$PublishImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PublishImplCopyWithImpl<$Res>
    extends _$OnboardingWizardEventCopyWithImpl<$Res, _$PublishImpl>
    implements _$$PublishImplCopyWith<$Res> {
  __$$PublishImplCopyWithImpl(
    _$PublishImpl _value,
    $Res Function(_$PublishImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OnboardingWizardEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PublishImpl implements Publish {
  const _$PublishImpl();

  @override
  String toString() {
    return 'OnboardingWizardEvent.publish()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PublishImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadOnboarding,
    required TResult Function(int step) goToStep,
    required TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )
    updateInfo,
    required TResult Function(List<OpeningHoursModel> hours) updateHours,
    required TResult Function() loadTables,
    required TResult Function(String label, int capacity) addTable,
    required TResult Function(String id, String label, int capacity)
    updateTable,
    required TResult Function(String id) deleteTable,
    required TResult Function() loadMenu,
    required TResult Function(String name) createCategory,
    required TResult Function(String id, String name) updateCategory,
    required TResult Function(String id) deleteCategory,
    required TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )
    createItem,
    required TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )
    updateItem,
    required TResult Function(String id) deleteItem,
    required TResult Function() createPanoramaSession,
    required TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )
    uploadPhoto,
    required TResult Function(String sessionId) finalizePanorama,
    required TResult Function(String sessionId) activatePanorama,
    required TResult Function() loadPanoramaSessions,
    required TResult Function(String sessionId) pollPanoramaStatus,
    required TResult Function() publish,
  }) {
    return publish();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadOnboarding,
    TResult? Function(int step)? goToStep,
    TResult? Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult? Function(List<OpeningHoursModel> hours)? updateHours,
    TResult? Function()? loadTables,
    TResult? Function(String label, int capacity)? addTable,
    TResult? Function(String id, String label, int capacity)? updateTable,
    TResult? Function(String id)? deleteTable,
    TResult? Function()? loadMenu,
    TResult? Function(String name)? createCategory,
    TResult? Function(String id, String name)? updateCategory,
    TResult? Function(String id)? deleteCategory,
    TResult? Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult? Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult? Function(String id)? deleteItem,
    TResult? Function()? createPanoramaSession,
    TResult? Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult? Function(String sessionId)? finalizePanorama,
    TResult? Function(String sessionId)? activatePanorama,
    TResult? Function()? loadPanoramaSessions,
    TResult? Function(String sessionId)? pollPanoramaStatus,
    TResult? Function()? publish,
  }) {
    return publish?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadOnboarding,
    TResult Function(int step)? goToStep,
    TResult Function(
      String name,
      String? description,
      String? phone,
      String? email,
      AddressModel? address,
      String? cuisineType,
    )?
    updateInfo,
    TResult Function(List<OpeningHoursModel> hours)? updateHours,
    TResult Function()? loadTables,
    TResult Function(String label, int capacity)? addTable,
    TResult Function(String id, String label, int capacity)? updateTable,
    TResult Function(String id)? deleteTable,
    TResult Function()? loadMenu,
    TResult Function(String name)? createCategory,
    TResult Function(String id, String name)? updateCategory,
    TResult Function(String id)? deleteCategory,
    TResult Function(
      String categoryId,
      String name,
      String? description,
      int priceMinor,
    )?
    createItem,
    TResult Function(
      String id,
      String name,
      String? description,
      int priceMinor,
    )?
    updateItem,
    TResult Function(String id)? deleteItem,
    TResult Function()? createPanoramaSession,
    TResult Function(
      String sessionId,
      int angleIndex,
      double actualAngle,
      double? actualPitch,
      Uint8List fileBytes,
      String filename,
    )?
    uploadPhoto,
    TResult Function(String sessionId)? finalizePanorama,
    TResult Function(String sessionId)? activatePanorama,
    TResult Function()? loadPanoramaSessions,
    TResult Function(String sessionId)? pollPanoramaStatus,
    TResult Function()? publish,
    required TResult orElse(),
  }) {
    if (publish != null) {
      return publish();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadOnboarding value) loadOnboarding,
    required TResult Function(GoToStep value) goToStep,
    required TResult Function(UpdateInfo value) updateInfo,
    required TResult Function(UpdateHours value) updateHours,
    required TResult Function(LoadTables value) loadTables,
    required TResult Function(AddTable value) addTable,
    required TResult Function(UpdateTable value) updateTable,
    required TResult Function(DeleteTable value) deleteTable,
    required TResult Function(LoadMenu value) loadMenu,
    required TResult Function(CreateCategory value) createCategory,
    required TResult Function(UpdateCategory value) updateCategory,
    required TResult Function(DeleteCategory value) deleteCategory,
    required TResult Function(CreateItem value) createItem,
    required TResult Function(UpdateItem value) updateItem,
    required TResult Function(DeleteItem value) deleteItem,
    required TResult Function(CreatePanoramaSession value)
    createPanoramaSession,
    required TResult Function(UploadPhoto value) uploadPhoto,
    required TResult Function(FinalizePanorama value) finalizePanorama,
    required TResult Function(ActivatePanorama value) activatePanorama,
    required TResult Function(LoadPanoramaSessions value) loadPanoramaSessions,
    required TResult Function(PollPanoramaStatus value) pollPanoramaStatus,
    required TResult Function(Publish value) publish,
  }) {
    return publish(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadOnboarding value)? loadOnboarding,
    TResult? Function(GoToStep value)? goToStep,
    TResult? Function(UpdateInfo value)? updateInfo,
    TResult? Function(UpdateHours value)? updateHours,
    TResult? Function(LoadTables value)? loadTables,
    TResult? Function(AddTable value)? addTable,
    TResult? Function(UpdateTable value)? updateTable,
    TResult? Function(DeleteTable value)? deleteTable,
    TResult? Function(LoadMenu value)? loadMenu,
    TResult? Function(CreateCategory value)? createCategory,
    TResult? Function(UpdateCategory value)? updateCategory,
    TResult? Function(DeleteCategory value)? deleteCategory,
    TResult? Function(CreateItem value)? createItem,
    TResult? Function(UpdateItem value)? updateItem,
    TResult? Function(DeleteItem value)? deleteItem,
    TResult? Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult? Function(UploadPhoto value)? uploadPhoto,
    TResult? Function(FinalizePanorama value)? finalizePanorama,
    TResult? Function(ActivatePanorama value)? activatePanorama,
    TResult? Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult? Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult? Function(Publish value)? publish,
  }) {
    return publish?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadOnboarding value)? loadOnboarding,
    TResult Function(GoToStep value)? goToStep,
    TResult Function(UpdateInfo value)? updateInfo,
    TResult Function(UpdateHours value)? updateHours,
    TResult Function(LoadTables value)? loadTables,
    TResult Function(AddTable value)? addTable,
    TResult Function(UpdateTable value)? updateTable,
    TResult Function(DeleteTable value)? deleteTable,
    TResult Function(LoadMenu value)? loadMenu,
    TResult Function(CreateCategory value)? createCategory,
    TResult Function(UpdateCategory value)? updateCategory,
    TResult Function(DeleteCategory value)? deleteCategory,
    TResult Function(CreateItem value)? createItem,
    TResult Function(UpdateItem value)? updateItem,
    TResult Function(DeleteItem value)? deleteItem,
    TResult Function(CreatePanoramaSession value)? createPanoramaSession,
    TResult Function(UploadPhoto value)? uploadPhoto,
    TResult Function(FinalizePanorama value)? finalizePanorama,
    TResult Function(ActivatePanorama value)? activatePanorama,
    TResult Function(LoadPanoramaSessions value)? loadPanoramaSessions,
    TResult Function(PollPanoramaStatus value)? pollPanoramaStatus,
    TResult Function(Publish value)? publish,
    required TResult orElse(),
  }) {
    if (publish != null) {
      return publish(this);
    }
    return orElse();
  }
}

abstract class Publish implements OnboardingWizardEvent {
  const factory Publish() = _$PublishImpl;
}
