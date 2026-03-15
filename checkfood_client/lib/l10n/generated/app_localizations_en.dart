// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CheckFood';

  @override
  String get splashTagline => 'Reservations & Orders. Simplified.';

  @override
  String get splashCheck => 'Check';

  @override
  String get splashFood => 'Food';

  @override
  String get onboardingTitle1 => 'Discover Restaurants';

  @override
  String get onboardingDesc1 => 'Find the perfect spot for any occasion';

  @override
  String get onboardingTitle2 => 'Easy Reservations';

  @override
  String get onboardingDesc2 => 'Book tables instantly, anytime';

  @override
  String get onboardingTitle3 => 'Order Delicious Food';

  @override
  String get onboardingDesc3 => 'Delivery, takeaway, or dine-in';

  @override
  String get onboardingGetStarted => 'Get Started';

  @override
  String get onboardingNext => 'Next';

  @override
  String get login => 'Log in';

  @override
  String get loginTitle => 'LOG IN';

  @override
  String get register => 'Sign up';

  @override
  String get logout => 'Log out';

  @override
  String get logoutTitle => 'Log out';

  @override
  String get logoutConfirm => 'Are you sure you want to log out?';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String continueWith(String label) {
    return 'Continue with $label';
  }

  @override
  String get resolveActivation => 'RESOLVE ACCOUNT ACTIVATION';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get newPassword => 'New password';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get username => 'Username';

  @override
  String get phone => 'Phone';

  @override
  String get emailVerificationTitle => 'Email verification';

  @override
  String get sendVerificationCode => 'Send verification code';

  @override
  String get verificationCode => 'Verification code';

  @override
  String get confirmCode => 'Confirm code';

  @override
  String get emailVerified => 'Email has been successfully verified!';

  @override
  String get verifyIdentity => 'Verify identity (BankID)';

  @override
  String get changePassword => 'Change password';

  @override
  String get changePasswordSuccess => 'Password has been changed successfully.';

  @override
  String get passwordManagedByProvider => 'Password is managed by external provider';

  @override
  String loginVia(String provider) {
    return 'Logged in via $provider';
  }

  @override
  String get profile => 'My Profile';

  @override
  String get personalData => 'Personal data';

  @override
  String get personalDataSubtitle => 'Name, surname and contact details';

  @override
  String get myReservations => 'My reservations';

  @override
  String get myReservationsSubtitle => 'History and upcoming reservations';

  @override
  String get reservationsModuleSoon => 'Reservations module will be available soon.';

  @override
  String get profileUpdated => 'Profile has been updated successfully';

  @override
  String get sectionMyAccount => 'My Account';

  @override
  String get sectionSecurity => 'Security';

  @override
  String get sectionApp => 'Application';

  @override
  String get deviceManagement => 'Device management';

  @override
  String get activeDevices => 'Active devices';

  @override
  String activeDevicesCount(int count) {
    return '$count active devices';
  }

  @override
  String get noOtherDevices => 'No other active devices.';

  @override
  String get logoutOthers => 'Log out others';

  @override
  String get loggedOutFromDevices => 'You have been logged out from all other devices.';

  @override
  String get pushNotifications => 'Push notifications';

  @override
  String get enabled => 'Enabled';

  @override
  String get disabled => 'Disabled';

  @override
  String get help => 'Help';

  @override
  String get contactSupport => 'Contact support';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Čeština / English';

  @override
  String get czech => 'Čeština';

  @override
  String get english => 'English';

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Favorites';

  @override
  String get orders => 'Orders';

  @override
  String get ordersTitle => 'Orders';

  @override
  String get menu => 'Menu';

  @override
  String get history => 'History';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get settings => 'Settings';

  @override
  String get searchRestaurants => 'Search restaurants...';

  @override
  String get locationPermissionTitle => 'Location permission';

  @override
  String get allowInSystem => 'Allow in system settings';

  @override
  String get cannotGetLocation => 'Cannot determine location. Check permissions.';

  @override
  String get reserveTable => 'Reserve a table';

  @override
  String get tableReservation => 'Table reservation';

  @override
  String get date => 'Date';

  @override
  String get time => 'Time';

  @override
  String get guests => 'Number of guests';

  @override
  String get note => 'Note';

  @override
  String get reservationCreated => 'Reservation created! Waiting for confirmation.';

  @override
  String get reservationEdited => 'Reservation updated.';

  @override
  String get reservationCancelled => 'Reservation cancelled.';

  @override
  String get cancelReservation => 'Cancel reservation';

  @override
  String get cancelReservationConfirm => 'Are you sure you want to cancel this reservation?';

  @override
  String get slotUnavailable => 'This slot is no longer available. Please choose a different time.';

  @override
  String get noReservationsForDay => 'No reservations for this day.';

  @override
  String get edit => 'Edit';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get reject => 'Reject';

  @override
  String get checkIn => 'Check-in';

  @override
  String get yes => 'Yes';

  @override
  String get yesCancelIt => 'Yes, cancel it';

  @override
  String get no => 'No';

  @override
  String get order => 'Order';

  @override
  String get sendOrder => 'Send order';

  @override
  String get orderSent => 'Order sent!';

  @override
  String get emptyCart => 'Empty cart';

  @override
  String cartItems(int count) {
    return '$count items';
  }

  @override
  String get noItems => 'Menu is empty.';

  @override
  String get noItemsInCategory => 'No items in this category';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get tableEditor => 'Table editor';

  @override
  String get tableName => 'Table name';

  @override
  String get capacity => 'Capacity';

  @override
  String capacityOf(int count) {
    return 'Capacity: $count';
  }

  @override
  String tableSeats(String label, int capacity) {
    return '$label ($capacity seats)';
  }

  @override
  String get addTable => 'Add table';

  @override
  String get tablePositionsSaved => 'Table positions saved!';

  @override
  String get tablesSaved => 'Tables saved!';

  @override
  String get noTablesYet => 'No tables yet. Add at least one.';

  @override
  String get myRestaurant => 'My Restaurant';

  @override
  String get restaurantName => 'Restaurant name';

  @override
  String get city => 'City';

  @override
  String get address => 'Address';

  @override
  String get contactEmail => 'Contact email';

  @override
  String get description => 'Description';

  @override
  String get information => 'Information';

  @override
  String get openingHours => 'Opening hours';

  @override
  String get open => 'Open';

  @override
  String get closed => 'Closed';

  @override
  String get saveHours => 'Save hours';

  @override
  String get saveInfo => 'Save information';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get save => 'Save';

  @override
  String get publishRestaurant => 'Publish restaurant';

  @override
  String get restaurantPublished => 'Restaurant has been published!';

  @override
  String get restaurantAssigned => 'Restaurant has been successfully assigned!';

  @override
  String get searchAres => 'Search in ARES';

  @override
  String get enterManually => 'Enter manually';

  @override
  String get companyId => 'Company ID';

  @override
  String get ownerRegistration => 'Owner registration';

  @override
  String get assignRestaurant => 'Assign restaurant';

  @override
  String get claimRestaurant => 'Claim restaurant';

  @override
  String get addEmployee => 'Add employee';

  @override
  String get removeEmployee => 'Remove employee';

  @override
  String removeEmployeeConfirm(String name) {
    return 'Are you sure you want to remove $name?';
  }

  @override
  String get manager => 'Manager';

  @override
  String get staff => 'Staff';

  @override
  String get owner => 'Owner';

  @override
  String get newCategory => 'New category';

  @override
  String get newItem => 'New item';

  @override
  String categoryCount(int count) {
    return 'Categories ($count)';
  }

  @override
  String tableCount(int count) {
    return 'Tables ($count)';
  }

  @override
  String get noCategoriesYet => 'No categories yet. Add at least one.';

  @override
  String get priceLabel => 'Price (CZK)';

  @override
  String get panorama => 'Panorama';

  @override
  String get panoramaOptional => 'Panorama (optional)';

  @override
  String get newPanorama => 'New panorama';

  @override
  String get activePanorama => 'Active panorama';

  @override
  String get panoramaActivated => 'Panorama activated!';

  @override
  String get panoramaActive => 'Panorama is active';

  @override
  String get panoramaActiveDesc => 'Panorama is set up and displayed to customers.';

  @override
  String get panoramaHelp => 'A panoramic shot of the restaurant will help customers explore the venue.';

  @override
  String get noPanoramaYet => 'No panorama yet. Click the button above.';

  @override
  String get stitchingFailed => 'Stitching failed. Please try again.';

  @override
  String photoUploadFailed(String error) {
    return 'Photo upload failed: $error';
  }

  @override
  String get arPhotoSphere => 'AR Photo Sphere';

  @override
  String get settingsSummary => 'Settings summary';

  @override
  String get finish => 'Finish';

  @override
  String get next => 'Next';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get delete => 'Delete';

  @override
  String get add => 'Add';

  @override
  String get activate => 'Activate';

  @override
  String get done => 'Done';

  @override
  String get change => 'Change';

  @override
  String get creating => 'Creating...';

  @override
  String get saving => 'Saving...';

  @override
  String get retry => 'Try again';

  @override
  String get loadAgain => 'Load again';

  @override
  String get clearFilter => 'Clear filter';

  @override
  String get error => 'Error';

  @override
  String errorGeneric(String message) {
    return 'Error: $message';
  }

  @override
  String get routeNotFound => 'Error: route not found';

  @override
  String savingError(String error) {
    return 'Error saving: $error';
  }

  @override
  String get accountActivated => 'Your account has been activated! You can now log in.';

  @override
  String get activationError => 'Error during account activation.';

  @override
  String get loginSubtitle => 'Sign in to your account';

  @override
  String get or => 'OR';

  @override
  String get noAccountYet => 'Don\'t have an account yet?';

  @override
  String get signUp => 'Sign up';

  @override
  String get registerAsOwner => 'Register as a restaurant owner';

  @override
  String get enterEmail => 'Enter email';

  @override
  String get enterValidEmail => 'Enter a valid email format';

  @override
  String get enterPassword => 'Enter password';

  @override
  String get emailHint => 'your@email.com';

  @override
  String get registerTitle => 'Registration';

  @override
  String get createAccount => 'Create your account';

  @override
  String get registerSubtitle => 'Enter your details to start your journey with CheckFood';

  @override
  String get registerSuccess => 'Registration successful. Please check your email.';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get loginAction => 'Sign in';

  @override
  String get checkEmail => 'Check your email';

  @override
  String verificationEmailSent(String email) {
    return 'We sent a confirmation link to $email.';
  }

  @override
  String get backToLogin => 'Back to login';

  @override
  String get emailNotReceived => 'Didn\'t receive the email or the link expired?';

  @override
  String get resend => 'Resend';

  @override
  String get resendCode => 'RESEND';

  @override
  String get oldPassword => 'Old password';

  @override
  String get enterOldPassword => 'Enter old password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get changePasswordButton => 'Change password';

  @override
  String get basicInfo => 'Basic information';

  @override
  String get basicInfoSubtitle => 'Here you can edit your first and last name.';

  @override
  String get enterFirstName => 'Please enter first name';

  @override
  String get enterLastName => 'Please enter last name';

  @override
  String get cart => 'Cart';

  @override
  String get orderNote => 'Order note...';

  @override
  String get total => 'Total:';

  @override
  String get myOrders => 'My orders';

  @override
  String get tapTableHint => 'Tap a table to see available time slots';

  @override
  String get sceneLoadFailed => 'Failed to load scene.';

  @override
  String get ownerRegisterTitle => 'Owner registration';

  @override
  String get ownerRegisterHeading => 'Restaurant owner registration';

  @override
  String get ownerRegisterSubtitle => 'Create an account to manage your restaurant';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get enterValidEmailShort => 'Enter a valid email';

  @override
  String get role => 'Role';

  @override
  String get locationPermissionDesc => 'To show you nearby restaurants and provide navigation, we need access to your location.';
}
