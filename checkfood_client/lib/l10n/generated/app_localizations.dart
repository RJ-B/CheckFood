import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of S
/// returned by `S.of(context)`.
///
/// Applications need to include `S.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: S.localizationsDelegates,
///   supportedLocales: S.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the S.supportedLocales
/// property.
abstract class S {
  S(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S)!;
  }

  static const LocalizationsDelegate<S> delegate = _SDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In cs, this message translates to:
  /// **'CheckFood'**
  String get appTitle;

  /// No description provided for @splashTagline.
  ///
  /// In cs, this message translates to:
  /// **'Reservations & Orders. Simplified.'**
  String get splashTagline;

  /// No description provided for @splashCheck.
  ///
  /// In cs, this message translates to:
  /// **'Check'**
  String get splashCheck;

  /// No description provided for @splashFood.
  ///
  /// In cs, this message translates to:
  /// **'Food'**
  String get splashFood;

  /// No description provided for @onboardingTitle1.
  ///
  /// In cs, this message translates to:
  /// **'Objevte restaurace'**
  String get onboardingTitle1;

  /// No description provided for @onboardingDesc1.
  ///
  /// In cs, this message translates to:
  /// **'Najděte ideální místo pro každou příležitost'**
  String get onboardingDesc1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In cs, this message translates to:
  /// **'Snadné rezervace'**
  String get onboardingTitle2;

  /// No description provided for @onboardingDesc2.
  ///
  /// In cs, this message translates to:
  /// **'Rezervujte stoly okamžitě, kdykoliv'**
  String get onboardingDesc2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In cs, this message translates to:
  /// **'Objednejte si jídlo'**
  String get onboardingTitle3;

  /// No description provided for @onboardingDesc3.
  ///
  /// In cs, this message translates to:
  /// **'Rozvoz, výdej nebo konzumace na místě'**
  String get onboardingDesc3;

  /// No description provided for @onboardingGetStarted.
  ///
  /// In cs, this message translates to:
  /// **'Začít'**
  String get onboardingGetStarted;

  /// No description provided for @onboardingNext.
  ///
  /// In cs, this message translates to:
  /// **'Další'**
  String get onboardingNext;

  /// No description provided for @login.
  ///
  /// In cs, this message translates to:
  /// **'Přihlásit se'**
  String get login;

  /// No description provided for @loginTitle.
  ///
  /// In cs, this message translates to:
  /// **'PŘIHLÁSIT SE'**
  String get loginTitle;

  /// No description provided for @register.
  ///
  /// In cs, this message translates to:
  /// **'Registrace'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit se'**
  String get logout;

  /// No description provided for @logoutTitle.
  ///
  /// In cs, this message translates to:
  /// **'Odhlášení'**
  String get logoutTitle;

  /// No description provided for @logoutConfirm.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu se chcete odhlásit ze svého účtu?'**
  String get logoutConfirm;

  /// No description provided for @forgotPassword.
  ///
  /// In cs, this message translates to:
  /// **'Zapomněli jste heslo?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In cs, this message translates to:
  /// **'Obnova hesla'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte svůj e-mail a my vám pošleme odkaz pro obnovu hesla.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @forgotPasswordSend.
  ///
  /// In cs, this message translates to:
  /// **'Odeslat odkaz'**
  String get forgotPasswordSend;

  /// No description provided for @forgotPasswordSent.
  ///
  /// In cs, this message translates to:
  /// **'Odkaz pro obnovu hesla byl odeslán na {email}. Zkontrolujte svou e-mailovou schránku.'**
  String forgotPasswordSent(String email);

  /// No description provided for @forgotPasswordCheckSpam.
  ///
  /// In cs, this message translates to:
  /// **'Nenašel/la jste e-mail? Zkontrolujte složku spam.'**
  String get forgotPasswordCheckSpam;

  /// No description provided for @resetPasswordTitle.
  ///
  /// In cs, this message translates to:
  /// **'Nové heslo'**
  String get resetPasswordTitle;

  /// No description provided for @resetPasswordSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte své nové heslo.'**
  String get resetPasswordSubtitle;

  /// No description provided for @newPasswordLabel.
  ///
  /// In cs, this message translates to:
  /// **'Nové heslo'**
  String get newPasswordLabel;

  /// No description provided for @confirmNewPasswordLabel.
  ///
  /// In cs, this message translates to:
  /// **'Potvrzení hesla'**
  String get confirmNewPasswordLabel;

  /// No description provided for @resetPasswordButton.
  ///
  /// In cs, this message translates to:
  /// **'Nastavit nové heslo'**
  String get resetPasswordButton;

  /// No description provided for @resetPasswordSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Heslo bylo úspěšně změněno! Nyní se můžete přihlásit.'**
  String get resetPasswordSuccess;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In cs, this message translates to:
  /// **'Hesla se neshodují.'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordTooShort.
  ///
  /// In cs, this message translates to:
  /// **'Heslo musí mít alespoň 8 znaků.'**
  String get passwordTooShort;

  /// No description provided for @errorForgotPassword.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se odeslat odkaz. Zkuste to později.'**
  String get errorForgotPassword;

  /// No description provided for @errorResetPassword.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se nastavit nové heslo.'**
  String get errorResetPassword;

  /// No description provided for @continueWith.
  ///
  /// In cs, this message translates to:
  /// **'Pokračovat s {label}'**
  String continueWith(String label);

  /// No description provided for @resolveActivation.
  ///
  /// In cs, this message translates to:
  /// **'VYŘEŠIT AKTIVACI ÚČTU'**
  String get resolveActivation;

  /// No description provided for @email.
  ///
  /// In cs, this message translates to:
  /// **'E-mail'**
  String get email;

  /// No description provided for @password.
  ///
  /// In cs, this message translates to:
  /// **'Heslo'**
  String get password;

  /// No description provided for @newPassword.
  ///
  /// In cs, this message translates to:
  /// **'Nové heslo'**
  String get newPassword;

  /// No description provided for @firstName.
  ///
  /// In cs, this message translates to:
  /// **'Jméno'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In cs, this message translates to:
  /// **'Příjmení'**
  String get lastName;

  /// No description provided for @username.
  ///
  /// In cs, this message translates to:
  /// **'Uživatelské jméno'**
  String get username;

  /// No description provided for @phone.
  ///
  /// In cs, this message translates to:
  /// **'Telefon'**
  String get phone;

  /// No description provided for @emailVerificationTitle.
  ///
  /// In cs, this message translates to:
  /// **'Ověření e-mailu'**
  String get emailVerificationTitle;

  /// No description provided for @sendVerificationCode.
  ///
  /// In cs, this message translates to:
  /// **'Odeslat ověřovací kód'**
  String get sendVerificationCode;

  /// No description provided for @verificationCode.
  ///
  /// In cs, this message translates to:
  /// **'Ověřovací kód'**
  String get verificationCode;

  /// No description provided for @confirmCode.
  ///
  /// In cs, this message translates to:
  /// **'Potvrdit kód'**
  String get confirmCode;

  /// No description provided for @emailVerified.
  ///
  /// In cs, this message translates to:
  /// **'E-mail byl úspěšně ověřen!'**
  String get emailVerified;

  /// No description provided for @verifyIdentity.
  ///
  /// In cs, this message translates to:
  /// **'Ověřit identitu (BankID)'**
  String get verifyIdentity;

  /// No description provided for @changePassword.
  ///
  /// In cs, this message translates to:
  /// **'Změna hesla'**
  String get changePassword;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Heslo bylo úspěšně změněno.'**
  String get changePasswordSuccess;

  /// No description provided for @passwordManagedByProvider.
  ///
  /// In cs, this message translates to:
  /// **'Heslo spravuje externí poskytovatel'**
  String get passwordManagedByProvider;

  /// No description provided for @loginVia.
  ///
  /// In cs, this message translates to:
  /// **'Přihlášení přes {provider}'**
  String loginVia(String provider);

  /// No description provided for @profile.
  ///
  /// In cs, this message translates to:
  /// **'Můj Profil'**
  String get profile;

  /// No description provided for @personalData.
  ///
  /// In cs, this message translates to:
  /// **'Osobní údaje'**
  String get personalData;

  /// No description provided for @personalDataSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Jméno, příjmení a kontaktní údaje'**
  String get personalDataSubtitle;

  /// No description provided for @myReservations.
  ///
  /// In cs, this message translates to:
  /// **'Moje rezervace'**
  String get myReservations;

  /// No description provided for @myReservationsSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Historie a nadcházející rezervace'**
  String get myReservationsSubtitle;

  /// No description provided for @reservationsModuleSoon.
  ///
  /// In cs, this message translates to:
  /// **'Modul Rezervace bude brzy dostupný.'**
  String get reservationsModuleSoon;

  /// No description provided for @profileUpdated.
  ///
  /// In cs, this message translates to:
  /// **'Údaje byly úspěšně aktualizovány'**
  String get profileUpdated;

  /// No description provided for @sectionMyAccount.
  ///
  /// In cs, this message translates to:
  /// **'Můj Účet'**
  String get sectionMyAccount;

  /// No description provided for @sectionSecurity.
  ///
  /// In cs, this message translates to:
  /// **'Zabezpečení'**
  String get sectionSecurity;

  /// No description provided for @sectionApp.
  ///
  /// In cs, this message translates to:
  /// **'Aplikace'**
  String get sectionApp;

  /// No description provided for @deviceManagement.
  ///
  /// In cs, this message translates to:
  /// **'Správa zařízení'**
  String get deviceManagement;

  /// No description provided for @activeDevices.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní zařízení'**
  String get activeDevices;

  /// No description provided for @activeDevicesCount.
  ///
  /// In cs, this message translates to:
  /// **'{count} aktivních zařízení'**
  String activeDevicesCount(int count);

  /// No description provided for @noOtherDevices.
  ///
  /// In cs, this message translates to:
  /// **'Žádná další aktivní zařízení.'**
  String get noOtherDevices;

  /// No description provided for @logoutOthers.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit ostatní'**
  String get logoutOthers;

  /// No description provided for @loggedOutFromDevices.
  ///
  /// In cs, this message translates to:
  /// **'Byl jste odhlášen ze všech ostatních zařízení.'**
  String get loggedOutFromDevices;

  /// No description provided for @pushNotifications.
  ///
  /// In cs, this message translates to:
  /// **'Push notifikace'**
  String get pushNotifications;

  /// No description provided for @enabled.
  ///
  /// In cs, this message translates to:
  /// **'Zapnuto'**
  String get enabled;

  /// No description provided for @disabled.
  ///
  /// In cs, this message translates to:
  /// **'Vypnuto'**
  String get disabled;

  /// No description provided for @help.
  ///
  /// In cs, this message translates to:
  /// **'Nápověda'**
  String get help;

  /// No description provided for @contactSupport.
  ///
  /// In cs, this message translates to:
  /// **'Kontaktovat podporu'**
  String get contactSupport;

  /// No description provided for @language.
  ///
  /// In cs, this message translates to:
  /// **'Jazyk'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Čeština / English'**
  String get languageSubtitle;

  /// No description provided for @czech.
  ///
  /// In cs, this message translates to:
  /// **'Čeština'**
  String get czech;

  /// No description provided for @english.
  ///
  /// In cs, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @explore.
  ///
  /// In cs, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @favorites.
  ///
  /// In cs, this message translates to:
  /// **'Oblíbené'**
  String get favorites;

  /// No description provided for @orders.
  ///
  /// In cs, this message translates to:
  /// **'Objednávky'**
  String get orders;

  /// No description provided for @ordersTitle.
  ///
  /// In cs, this message translates to:
  /// **'Orders'**
  String get ordersTitle;

  /// No description provided for @menu.
  ///
  /// In cs, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @history.
  ///
  /// In cs, this message translates to:
  /// **'Historie'**
  String get history;

  /// No description provided for @upcoming.
  ///
  /// In cs, this message translates to:
  /// **'Nadcházející'**
  String get upcoming;

  /// No description provided for @settings.
  ///
  /// In cs, this message translates to:
  /// **'Nastavení'**
  String get settings;

  /// No description provided for @searchRestaurants.
  ///
  /// In cs, this message translates to:
  /// **'Hledat restaurace...'**
  String get searchRestaurants;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In cs, this message translates to:
  /// **'Povolení polohy'**
  String get locationPermissionTitle;

  /// No description provided for @allowInSystem.
  ///
  /// In cs, this message translates to:
  /// **'Povolit v systému'**
  String get allowInSystem;

  /// No description provided for @cannotGetLocation.
  ///
  /// In cs, this message translates to:
  /// **'Nelze zjistit polohu. Zkontrolujte oprávnění.'**
  String get cannotGetLocation;

  /// No description provided for @reserveTable.
  ///
  /// In cs, this message translates to:
  /// **'Rezervovat stůl'**
  String get reserveTable;

  /// No description provided for @tableReservation.
  ///
  /// In cs, this message translates to:
  /// **'Rezervace stolu'**
  String get tableReservation;

  /// No description provided for @date.
  ///
  /// In cs, this message translates to:
  /// **'Datum'**
  String get date;

  /// No description provided for @time.
  ///
  /// In cs, this message translates to:
  /// **'Čas'**
  String get time;

  /// No description provided for @guests.
  ///
  /// In cs, this message translates to:
  /// **'Počet hostů'**
  String get guests;

  /// No description provided for @note.
  ///
  /// In cs, this message translates to:
  /// **'Poznámka'**
  String get note;

  /// No description provided for @reservationCreated.
  ///
  /// In cs, this message translates to:
  /// **'Rezervace vytvořena! Čeká na potvrzení.'**
  String get reservationCreated;

  /// No description provided for @reservationEdited.
  ///
  /// In cs, this message translates to:
  /// **'Rezervace upravena.'**
  String get reservationEdited;

  /// No description provided for @reservationCancelled.
  ///
  /// In cs, this message translates to:
  /// **'Rezervace zrušena.'**
  String get reservationCancelled;

  /// No description provided for @cancelReservation.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit rezervaci'**
  String get cancelReservation;

  /// No description provided for @cancelReservationConfirm.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chcete zrušit tuto rezervaci?'**
  String get cancelReservationConfirm;

  /// No description provided for @slotUnavailable.
  ///
  /// In cs, this message translates to:
  /// **'Termín už není volný. Vyberte jiný čas.'**
  String get slotUnavailable;

  /// No description provided for @noReservationsForDay.
  ///
  /// In cs, this message translates to:
  /// **'Žádné rezervace pro tento den.'**
  String get noReservationsForDay;

  /// No description provided for @edit.
  ///
  /// In cs, this message translates to:
  /// **'Upravit'**
  String get edit;

  /// No description provided for @cancel.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In cs, this message translates to:
  /// **'Potvrdit'**
  String get confirm;

  /// No description provided for @reject.
  ///
  /// In cs, this message translates to:
  /// **'Odmítnout'**
  String get reject;

  /// No description provided for @checkIn.
  ///
  /// In cs, this message translates to:
  /// **'Check-in'**
  String get checkIn;

  /// No description provided for @yes.
  ///
  /// In cs, this message translates to:
  /// **'Ano'**
  String get yes;

  /// No description provided for @yesCancelIt.
  ///
  /// In cs, this message translates to:
  /// **'Ano, zrušit'**
  String get yesCancelIt;

  /// No description provided for @no.
  ///
  /// In cs, this message translates to:
  /// **'Ne'**
  String get no;

  /// No description provided for @order.
  ///
  /// In cs, this message translates to:
  /// **'Objednat'**
  String get order;

  /// No description provided for @sendOrder.
  ///
  /// In cs, this message translates to:
  /// **'Odeslat objednávku'**
  String get sendOrder;

  /// No description provided for @orderSent.
  ///
  /// In cs, this message translates to:
  /// **'Objednávka odeslána!'**
  String get orderSent;

  /// No description provided for @emptyCart.
  ///
  /// In cs, this message translates to:
  /// **'Vyprázdnit'**
  String get emptyCart;

  /// No description provided for @cartItems.
  ///
  /// In cs, this message translates to:
  /// **'{count} pol.'**
  String cartItems(int count);

  /// No description provided for @noItems.
  ///
  /// In cs, this message translates to:
  /// **'Menu je prázdné.'**
  String get noItems;

  /// No description provided for @noItemsInCategory.
  ///
  /// In cs, this message translates to:
  /// **'V této kategorii nejsou žádné položky'**
  String get noItemsInCategory;

  /// No description provided for @addToCart.
  ///
  /// In cs, this message translates to:
  /// **'Přidat do košíku'**
  String get addToCart;

  /// No description provided for @tableEditor.
  ///
  /// In cs, this message translates to:
  /// **'Editor stolu'**
  String get tableEditor;

  /// No description provided for @tableName.
  ///
  /// In cs, this message translates to:
  /// **'Název stolu'**
  String get tableName;

  /// No description provided for @capacity.
  ///
  /// In cs, this message translates to:
  /// **'Kapacita'**
  String get capacity;

  /// No description provided for @capacityOf.
  ///
  /// In cs, this message translates to:
  /// **'Kapacita: {count}'**
  String capacityOf(int count);

  /// No description provided for @tableSeats.
  ///
  /// In cs, this message translates to:
  /// **'{label} ({capacity} míst)'**
  String tableSeats(String label, int capacity);

  /// No description provided for @addTable.
  ///
  /// In cs, this message translates to:
  /// **'Přidat stůl'**
  String get addTable;

  /// No description provided for @tablePositionsSaved.
  ///
  /// In cs, this message translates to:
  /// **'Pozice stolu uloženy!'**
  String get tablePositionsSaved;

  /// No description provided for @tablesSaved.
  ///
  /// In cs, this message translates to:
  /// **'Stoly uloženy!'**
  String get tablesSaved;

  /// No description provided for @noTablesYet.
  ///
  /// In cs, this message translates to:
  /// **'Zatím žádné stoly. Přidejte alespoň jeden.'**
  String get noTablesYet;

  /// No description provided for @myRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'My Restaurant'**
  String get myRestaurant;

  /// No description provided for @restaurantName.
  ///
  /// In cs, this message translates to:
  /// **'Název restaurace'**
  String get restaurantName;

  /// No description provided for @city.
  ///
  /// In cs, this message translates to:
  /// **'Město'**
  String get city;

  /// No description provided for @address.
  ///
  /// In cs, this message translates to:
  /// **'Adresa'**
  String get address;

  /// No description provided for @contactEmail.
  ///
  /// In cs, this message translates to:
  /// **'Kontaktní e-mail'**
  String get contactEmail;

  /// No description provided for @description.
  ///
  /// In cs, this message translates to:
  /// **'Popis'**
  String get description;

  /// No description provided for @information.
  ///
  /// In cs, this message translates to:
  /// **'Informace'**
  String get information;

  /// No description provided for @openingHours.
  ///
  /// In cs, this message translates to:
  /// **'Otevírací hodiny'**
  String get openingHours;

  /// No description provided for @open.
  ///
  /// In cs, this message translates to:
  /// **'Otevřeno'**
  String get open;

  /// No description provided for @closed.
  ///
  /// In cs, this message translates to:
  /// **'Zavřeno'**
  String get closed;

  /// No description provided for @saveHours.
  ///
  /// In cs, this message translates to:
  /// **'Uložit hodiny'**
  String get saveHours;

  /// No description provided for @saveInfo.
  ///
  /// In cs, this message translates to:
  /// **'Uložit informace'**
  String get saveInfo;

  /// No description provided for @saveChanges.
  ///
  /// In cs, this message translates to:
  /// **'Uložit změny'**
  String get saveChanges;

  /// No description provided for @save.
  ///
  /// In cs, this message translates to:
  /// **'Uložit'**
  String get save;

  /// No description provided for @publishRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'Publikovat restauraci'**
  String get publishRestaurant;

  /// No description provided for @restaurantPublished.
  ///
  /// In cs, this message translates to:
  /// **'Restaurace byla publikována!'**
  String get restaurantPublished;

  /// No description provided for @restaurantAssigned.
  ///
  /// In cs, this message translates to:
  /// **'Restaurace byla úspěšně přiřazena!'**
  String get restaurantAssigned;

  /// No description provided for @searchAres.
  ///
  /// In cs, this message translates to:
  /// **'Vyhledat v ARES'**
  String get searchAres;

  /// No description provided for @enterManually.
  ///
  /// In cs, this message translates to:
  /// **'Zadat ručně'**
  String get enterManually;

  /// No description provided for @companyId.
  ///
  /// In cs, this message translates to:
  /// **'IČO firmy'**
  String get companyId;

  /// No description provided for @ownerRegistration.
  ///
  /// In cs, this message translates to:
  /// **'Registrace majitele'**
  String get ownerRegistration;

  /// No description provided for @assignRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'Přiřazení restaurace'**
  String get assignRestaurant;

  /// No description provided for @claimRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'Přiřazení restaurace'**
  String get claimRestaurant;

  /// No description provided for @addEmployee.
  ///
  /// In cs, this message translates to:
  /// **'Přidat zaměstnance'**
  String get addEmployee;

  /// No description provided for @removeEmployee.
  ///
  /// In cs, this message translates to:
  /// **'Odebrat zaměstnance'**
  String get removeEmployee;

  /// No description provided for @removeEmployeeConfirm.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chcete odebrat {name}?'**
  String removeEmployeeConfirm(String name);

  /// No description provided for @manager.
  ///
  /// In cs, this message translates to:
  /// **'Manager'**
  String get manager;

  /// No description provided for @staff.
  ///
  /// In cs, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @owner.
  ///
  /// In cs, this message translates to:
  /// **'Owner'**
  String get owner;

  /// No description provided for @newCategory.
  ///
  /// In cs, this message translates to:
  /// **'Nová kategorie'**
  String get newCategory;

  /// No description provided for @newItem.
  ///
  /// In cs, this message translates to:
  /// **'Nová položka'**
  String get newItem;

  /// No description provided for @categoryCount.
  ///
  /// In cs, this message translates to:
  /// **'Kategorie ({count})'**
  String categoryCount(int count);

  /// No description provided for @tableCount.
  ///
  /// In cs, this message translates to:
  /// **'Stoly ({count})'**
  String tableCount(int count);

  /// No description provided for @noCategoriesYet.
  ///
  /// In cs, this message translates to:
  /// **'Zatím žádné kategorie. Přidejte alespoň jednu.'**
  String get noCategoriesYet;

  /// No description provided for @priceLabel.
  ///
  /// In cs, this message translates to:
  /// **'Cena (Kč)'**
  String get priceLabel;

  /// No description provided for @panorama.
  ///
  /// In cs, this message translates to:
  /// **'Panorama'**
  String get panorama;

  /// No description provided for @panoramaOptional.
  ///
  /// In cs, this message translates to:
  /// **'Panorama (volitelné)'**
  String get panoramaOptional;

  /// No description provided for @newPanorama.
  ///
  /// In cs, this message translates to:
  /// **'Nové panorama'**
  String get newPanorama;

  /// No description provided for @activePanorama.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní panorama'**
  String get activePanorama;

  /// No description provided for @panoramaActivated.
  ///
  /// In cs, this message translates to:
  /// **'Panorama aktivováno!'**
  String get panoramaActivated;

  /// No description provided for @panoramaActive.
  ///
  /// In cs, this message translates to:
  /// **'Panorama je aktivní'**
  String get panoramaActive;

  /// No description provided for @panoramaActiveDesc.
  ///
  /// In cs, this message translates to:
  /// **'Panorama je nastaveno a zobrazuje se zákazníkům.'**
  String get panoramaActiveDesc;

  /// No description provided for @panoramaHelp.
  ///
  /// In cs, this message translates to:
  /// **'Panoramatický snímek restaurace pomůže zákazníkům si místo prohlédnout.'**
  String get panoramaHelp;

  /// No description provided for @noPanoramaYet.
  ///
  /// In cs, this message translates to:
  /// **'Zatím žádné panorama. Klikněte na tlačítko výše.'**
  String get noPanoramaYet;

  /// No description provided for @stitchingFailed.
  ///
  /// In cs, this message translates to:
  /// **'Stitching selhal. Zkuste to znovu.'**
  String get stitchingFailed;

  /// No description provided for @photoUploadFailed.
  ///
  /// In cs, this message translates to:
  /// **'Nahrání fotky selhalo: {error}'**
  String photoUploadFailed(String error);

  /// No description provided for @arPhotoSphere.
  ///
  /// In cs, this message translates to:
  /// **'AR Photo Sphere'**
  String get arPhotoSphere;

  /// No description provided for @settingsSummary.
  ///
  /// In cs, this message translates to:
  /// **'Souhrn nastavení'**
  String get settingsSummary;

  /// No description provided for @finish.
  ///
  /// In cs, this message translates to:
  /// **'Dokončit'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In cs, this message translates to:
  /// **'Další'**
  String get next;

  /// No description provided for @back.
  ///
  /// In cs, this message translates to:
  /// **'Zpět'**
  String get back;

  /// No description provided for @close.
  ///
  /// In cs, this message translates to:
  /// **'Zavřít'**
  String get close;

  /// No description provided for @delete.
  ///
  /// In cs, this message translates to:
  /// **'Smazat'**
  String get delete;

  /// No description provided for @add.
  ///
  /// In cs, this message translates to:
  /// **'Přidat'**
  String get add;

  /// No description provided for @activate.
  ///
  /// In cs, this message translates to:
  /// **'Aktivovat'**
  String get activate;

  /// No description provided for @done.
  ///
  /// In cs, this message translates to:
  /// **'Hotovo'**
  String get done;

  /// No description provided for @change.
  ///
  /// In cs, this message translates to:
  /// **'Změnit'**
  String get change;

  /// No description provided for @creating.
  ///
  /// In cs, this message translates to:
  /// **'Vytvářím...'**
  String get creating;

  /// No description provided for @saving.
  ///
  /// In cs, this message translates to:
  /// **'Ukládám...'**
  String get saving;

  /// No description provided for @retry.
  ///
  /// In cs, this message translates to:
  /// **'Zkusit znovu'**
  String get retry;

  /// No description provided for @loadAgain.
  ///
  /// In cs, this message translates to:
  /// **'Načíst znovu'**
  String get loadAgain;

  /// No description provided for @clearFilter.
  ///
  /// In cs, this message translates to:
  /// **'Zrušit filtr'**
  String get clearFilter;

  /// No description provided for @error.
  ///
  /// In cs, this message translates to:
  /// **'Chyba'**
  String get error;

  /// No description provided for @errorGeneric.
  ///
  /// In cs, this message translates to:
  /// **'Chyba: {message}'**
  String errorGeneric(String message);

  /// No description provided for @routeNotFound.
  ///
  /// In cs, this message translates to:
  /// **'Chyba: cesta nenalezena'**
  String get routeNotFound;

  /// No description provided for @savingError.
  ///
  /// In cs, this message translates to:
  /// **'Chyba při ukládání: {error}'**
  String savingError(String error);

  /// No description provided for @accountActivated.
  ///
  /// In cs, this message translates to:
  /// **'Váš účet byl úspěšně aktivován! Nyní se můžete přihlásit.'**
  String get accountActivated;

  /// No description provided for @activationError.
  ///
  /// In cs, this message translates to:
  /// **'Chyba při aktivaci účtu.'**
  String get activationError;

  /// No description provided for @loginSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Přihlaste se ke svému účtu'**
  String get loginSubtitle;

  /// No description provided for @or.
  ///
  /// In cs, this message translates to:
  /// **'NEBO'**
  String get or;

  /// No description provided for @noAccountYet.
  ///
  /// In cs, this message translates to:
  /// **'Ještě nemáte účet?'**
  String get noAccountYet;

  /// No description provided for @signUp.
  ///
  /// In cs, this message translates to:
  /// **'Zaregistrujte se'**
  String get signUp;

  /// No description provided for @registerAsOwner.
  ///
  /// In cs, this message translates to:
  /// **'Chci přidat svou restauraci'**
  String get registerAsOwner;

  /// No description provided for @registerAsOwnerSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Vytvoříme vám zkušební restauraci — doladíte ji po přihlášení'**
  String get registerAsOwnerSubtitle;

  /// No description provided for @enterEmail.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte e-mail'**
  String get enterEmail;

  /// No description provided for @enterValidEmail.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte platný formát e-mailu'**
  String get enterValidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte heslo'**
  String get enterPassword;

  /// No description provided for @emailHint.
  ///
  /// In cs, this message translates to:
  /// **'vase@adresa.cz'**
  String get emailHint;

  /// No description provided for @registerTitle.
  ///
  /// In cs, this message translates to:
  /// **'Registrace'**
  String get registerTitle;

  /// No description provided for @createAccount.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořte si účet'**
  String get createAccount;

  /// No description provided for @registerSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte své údaje pro zahájení cesty s CheckFood'**
  String get registerSubtitle;

  /// No description provided for @registerSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Registrace proběhla úspěšně. Zkontrolujte svůj e-mail.'**
  String get registerSuccess;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In cs, this message translates to:
  /// **'Již máte účet?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginAction.
  ///
  /// In cs, this message translates to:
  /// **'Přihlaste se'**
  String get loginAction;

  /// No description provided for @checkEmail.
  ///
  /// In cs, this message translates to:
  /// **'Zkontrolujte si e-mail'**
  String get checkEmail;

  /// No description provided for @verificationEmailSent.
  ///
  /// In cs, this message translates to:
  /// **'Na adresu {email} jsme odeslali potvrzovací odkaz.'**
  String verificationEmailSent(String email);

  /// No description provided for @backToLogin.
  ///
  /// In cs, this message translates to:
  /// **'Zpět na přihlášení'**
  String get backToLogin;

  /// No description provided for @emailNotReceived.
  ///
  /// In cs, this message translates to:
  /// **'Nedostal jste e-mail nebo odkaz vypršel?'**
  String get emailNotReceived;

  /// No description provided for @resend.
  ///
  /// In cs, this message translates to:
  /// **'Odeslat znovu'**
  String get resend;

  /// No description provided for @resendCode.
  ///
  /// In cs, this message translates to:
  /// **'ZNOVU ODESLAT'**
  String get resendCode;

  /// No description provided for @oldPassword.
  ///
  /// In cs, this message translates to:
  /// **'Staré heslo'**
  String get oldPassword;

  /// No description provided for @enterOldPassword.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte staré heslo'**
  String get enterOldPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In cs, this message translates to:
  /// **'Potvrzení hesla'**
  String get confirmPassword;

  /// No description provided for @changePasswordButton.
  ///
  /// In cs, this message translates to:
  /// **'Změnit heslo'**
  String get changePasswordButton;

  /// No description provided for @basicInfo.
  ///
  /// In cs, this message translates to:
  /// **'Základní informace'**
  String get basicInfo;

  /// No description provided for @basicInfoSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zde můžete upravit své jméno a příjmení.'**
  String get basicInfoSubtitle;

  /// No description provided for @enterFirstName.
  ///
  /// In cs, this message translates to:
  /// **'Prosím zadejte jméno'**
  String get enterFirstName;

  /// No description provided for @enterLastName.
  ///
  /// In cs, this message translates to:
  /// **'Prosím zadejte příjmení'**
  String get enterLastName;

  /// No description provided for @cart.
  ///
  /// In cs, this message translates to:
  /// **'Košík'**
  String get cart;

  /// No description provided for @orderNote.
  ///
  /// In cs, this message translates to:
  /// **'Poznámka k objednávce...'**
  String get orderNote;

  /// No description provided for @total.
  ///
  /// In cs, this message translates to:
  /// **'Celkem:'**
  String get total;

  /// No description provided for @myOrders.
  ///
  /// In cs, this message translates to:
  /// **'Moje objednávky'**
  String get myOrders;

  /// No description provided for @tapTableHint.
  ///
  /// In cs, this message translates to:
  /// **'Klepněte na stůl pro zobrazení volných termínů'**
  String get tapTableHint;

  /// No description provided for @sceneLoadFailed.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se načíst scénu.'**
  String get sceneLoadFailed;

  /// No description provided for @ownerRegisterTitle.
  ///
  /// In cs, this message translates to:
  /// **'Registrace majitele'**
  String get ownerRegisterTitle;

  /// No description provided for @ownerRegisterHeading.
  ///
  /// In cs, this message translates to:
  /// **'Registrace majitele restaurace'**
  String get ownerRegisterHeading;

  /// No description provided for @ownerRegisterSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Vytvořte si účet pro správu vaší restaurace'**
  String get ownerRegisterSubtitle;

  /// No description provided for @emailRequired.
  ///
  /// In cs, this message translates to:
  /// **'E-mail je povinný'**
  String get emailRequired;

  /// No description provided for @enterValidEmailShort.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte platný e-mail'**
  String get enterValidEmailShort;

  /// No description provided for @role.
  ///
  /// In cs, this message translates to:
  /// **'Role'**
  String get role;

  /// No description provided for @locationPermissionDesc.
  ///
  /// In cs, this message translates to:
  /// **'Abychom vám mohli ukázat nejbližší restaurace v okolí a zajistit navigaci, potřebujeme přístup k vaší poloze.'**
  String get locationPermissionDesc;

  /// No description provided for @errorProfileLoad.
  ///
  /// In cs, this message translates to:
  /// **'Chyba při načítání uživatelského profilu.'**
  String get errorProfileLoad;

  /// No description provided for @errorUnexpected.
  ///
  /// In cs, this message translates to:
  /// **'Neočekávaná chyba serveru.'**
  String get errorUnexpected;

  /// No description provided for @errorRegisterFailed.
  ///
  /// In cs, this message translates to:
  /// **'Registrace selhala.'**
  String get errorRegisterFailed;

  /// No description provided for @errorVerificationFailed.
  ///
  /// In cs, this message translates to:
  /// **'Verifikace selhala.'**
  String get errorVerificationFailed;

  /// No description provided for @errorGoogleLogin.
  ///
  /// In cs, this message translates to:
  /// **'Google přihlášení selhalo.'**
  String get errorGoogleLogin;

  /// No description provided for @errorAppleLogin.
  ///
  /// In cs, this message translates to:
  /// **'Apple přihlášení selhalo.'**
  String get errorAppleLogin;

  /// No description provided for @deviceManagementTitle.
  ///
  /// In cs, this message translates to:
  /// **'Správa zařízení'**
  String get deviceManagementTitle;

  /// No description provided for @noActiveDevices.
  ///
  /// In cs, this message translates to:
  /// **'Žádná aktivní zařízení.'**
  String get noActiveDevices;

  /// No description provided for @thisDevice.
  ///
  /// In cs, this message translates to:
  /// **'Toto zařízení'**
  String get thisDevice;

  /// No description provided for @lastActivity.
  ///
  /// In cs, this message translates to:
  /// **'Poslední přihlášení: {date}'**
  String lastActivity(String date);

  /// No description provided for @logoutDevice.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit zařízení'**
  String get logoutDevice;

  /// No description provided for @deleteDevice.
  ///
  /// In cs, this message translates to:
  /// **'Smazat zařízení'**
  String get deleteDevice;

  /// No description provided for @deviceActive.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní'**
  String get deviceActive;

  /// No description provided for @deviceInactive.
  ///
  /// In cs, this message translates to:
  /// **'Neaktivní'**
  String get deviceInactive;

  /// No description provided for @logoutAll.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit všechna'**
  String get logoutAll;

  /// No description provided for @deleteAll.
  ///
  /// In cs, this message translates to:
  /// **'Smazat všechna'**
  String get deleteAll;

  /// No description provided for @logoutAllDevices.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit všechna zařízení'**
  String get logoutAllDevices;

  /// No description provided for @deleteAllDevices.
  ///
  /// In cs, this message translates to:
  /// **'Smazat všechna zařízení'**
  String get deleteAllDevices;

  /// No description provided for @logoutDeviceDialogTitle.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit zařízení?'**
  String get logoutDeviceDialogTitle;

  /// No description provided for @logoutDeviceDialogContent.
  ///
  /// In cs, this message translates to:
  /// **'Zařízení bude odhlášeno, ale zůstane uloženo v seznamu.'**
  String get logoutDeviceDialogContent;

  /// No description provided for @deleteDeviceDialogTitle.
  ///
  /// In cs, this message translates to:
  /// **'Smazat zařízení?'**
  String get deleteDeviceDialogTitle;

  /// No description provided for @deleteDeviceDialogContent.
  ///
  /// In cs, this message translates to:
  /// **'Zařízení bude odhlášeno a trvale odstraněno ze seznamu.'**
  String get deleteDeviceDialogContent;

  /// No description provided for @logoutAllDevicesDialogTitle.
  ///
  /// In cs, this message translates to:
  /// **'Odhlásit všechna zařízení?'**
  String get logoutAllDevicesDialogTitle;

  /// No description provided for @logoutAllDevicesDialogContent.
  ///
  /// In cs, this message translates to:
  /// **'Všechna zařízení kromě tohoto budou odhlášena, ale zůstanou uložena v seznamu.'**
  String get logoutAllDevicesDialogContent;

  /// No description provided for @deleteAllDevicesDialogTitle.
  ///
  /// In cs, this message translates to:
  /// **'Smazat všechna zařízení?'**
  String get deleteAllDevicesDialogTitle;

  /// No description provided for @deleteAllDevicesDialogContent.
  ///
  /// In cs, this message translates to:
  /// **'Všechna zařízení kromě tohoto budou odhlášena a trvale odstraněna ze seznamu.'**
  String get deleteAllDevicesDialogContent;

  /// No description provided for @firstNameRequired.
  ///
  /// In cs, this message translates to:
  /// **'Jméno nesmí být prázdné'**
  String get firstNameRequired;

  /// No description provided for @lastNameRequired.
  ///
  /// In cs, this message translates to:
  /// **'Příjmení nesmí být prázdné'**
  String get lastNameRequired;

  /// No description provided for @photoUploadError.
  ///
  /// In cs, this message translates to:
  /// **'Nahrání fotky selhalo: {error}'**
  String photoUploadError(String error);

  /// No description provided for @userNoName.
  ///
  /// In cs, this message translates to:
  /// **'Uživatel bez jména'**
  String get userNoName;

  /// No description provided for @inactiveAccount.
  ///
  /// In cs, this message translates to:
  /// **'Neaktivní účet'**
  String get inactiveAccount;

  /// No description provided for @aboutRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'O restauraci'**
  String get aboutRestaurant;

  /// No description provided for @openingHoursLabel.
  ///
  /// In cs, this message translates to:
  /// **'Otevírací doba'**
  String get openingHoursLabel;

  /// No description provided for @dayMonday.
  ///
  /// In cs, this message translates to:
  /// **'Pondělí'**
  String get dayMonday;

  /// No description provided for @dayTuesday.
  ///
  /// In cs, this message translates to:
  /// **'Úterý'**
  String get dayTuesday;

  /// No description provided for @dayWednesday.
  ///
  /// In cs, this message translates to:
  /// **'Středa'**
  String get dayWednesday;

  /// No description provided for @dayThursday.
  ///
  /// In cs, this message translates to:
  /// **'Čtvrtek'**
  String get dayThursday;

  /// No description provided for @dayFriday.
  ///
  /// In cs, this message translates to:
  /// **'Pátek'**
  String get dayFriday;

  /// No description provided for @daySaturday.
  ///
  /// In cs, this message translates to:
  /// **'Sobota'**
  String get daySaturday;

  /// No description provided for @daySunday.
  ///
  /// In cs, this message translates to:
  /// **'Neděle'**
  String get daySunday;

  /// No description provided for @noUpcomingReservations.
  ///
  /// In cs, this message translates to:
  /// **'Žádné nadcházející rezervace'**
  String get noUpcomingReservations;

  /// No description provided for @noReservationHistory.
  ///
  /// In cs, this message translates to:
  /// **'Žádná historie rezervací'**
  String get noReservationHistory;

  /// No description provided for @showAll.
  ///
  /// In cs, this message translates to:
  /// **'Zobrazit vše ({count})'**
  String showAll(int count);

  /// No description provided for @restaurant.
  ///
  /// In cs, this message translates to:
  /// **'Restaurace'**
  String get restaurant;

  /// No description provided for @table.
  ///
  /// In cs, this message translates to:
  /// **'Stůl'**
  String get table;

  /// No description provided for @partySizeShort.
  ///
  /// In cs, this message translates to:
  /// **'{count} os.'**
  String partySizeShort(int count);

  /// No description provided for @timeFrom.
  ///
  /// In cs, this message translates to:
  /// **'od {time}'**
  String timeFrom(String time);

  /// No description provided for @statusPending.
  ///
  /// In cs, this message translates to:
  /// **'Čeká na potvrzení'**
  String get statusPending;

  /// No description provided for @statusConfirmed.
  ///
  /// In cs, this message translates to:
  /// **'Potvrzeno'**
  String get statusConfirmed;

  /// No description provided for @statusCancelled.
  ///
  /// In cs, this message translates to:
  /// **'Zrušeno'**
  String get statusCancelled;

  /// No description provided for @statusRejected.
  ///
  /// In cs, this message translates to:
  /// **'Zamítnuto'**
  String get statusRejected;

  /// No description provided for @statusCompleted.
  ///
  /// In cs, this message translates to:
  /// **'Dokončeno'**
  String get statusCompleted;

  /// No description provided for @statusCheckedIn.
  ///
  /// In cs, this message translates to:
  /// **'Přítomen'**
  String get statusCheckedIn;

  /// No description provided for @statusReserved.
  ///
  /// In cs, this message translates to:
  /// **'Potvrzeno'**
  String get statusReserved;

  /// No description provided for @editReservation.
  ///
  /// In cs, this message translates to:
  /// **'Upravit rezervaci'**
  String get editReservation;

  /// No description provided for @availableTimes.
  ///
  /// In cs, this message translates to:
  /// **'Dostupné časy'**
  String get availableTimes;

  /// No description provided for @noSlotsForDay.
  ///
  /// In cs, this message translates to:
  /// **'Žádné volné termíny pro tento den.'**
  String get noSlotsForDay;

  /// No description provided for @partyCount.
  ///
  /// In cs, this message translates to:
  /// **'Počet osob'**
  String get partyCount;

  /// No description provided for @guestsLabel.
  ///
  /// In cs, this message translates to:
  /// **'Počet hostů:'**
  String get guestsLabel;

  /// No description provided for @freeTimes.
  ///
  /// In cs, this message translates to:
  /// **'Volné časy'**
  String get freeTimes;

  /// No description provided for @confirmReservation.
  ///
  /// In cs, this message translates to:
  /// **'Potvrdit rezervaci'**
  String get confirmReservation;

  /// No description provided for @menuEmpty.
  ///
  /// In cs, this message translates to:
  /// **'Menu je prázdné.'**
  String get menuEmpty;

  /// No description provided for @itemsShort.
  ///
  /// In cs, this message translates to:
  /// **'{count} pol.'**
  String itemsShort(int count);

  /// No description provided for @selectRestaurant.
  ///
  /// In cs, this message translates to:
  /// **'Vyberte restauraci'**
  String get selectRestaurant;

  /// No description provided for @reservationsTab.
  ///
  /// In cs, this message translates to:
  /// **'Rezervace'**
  String get reservationsTab;

  /// No description provided for @infoTab.
  ///
  /// In cs, this message translates to:
  /// **'Info'**
  String get infoTab;

  /// No description provided for @employeesTab.
  ///
  /// In cs, this message translates to:
  /// **'Zaměstnanci'**
  String get employeesTab;

  /// No description provided for @settingsTab.
  ///
  /// In cs, this message translates to:
  /// **'Nastavení'**
  String get settingsTab;

  /// No description provided for @restaurantInfo.
  ///
  /// In cs, this message translates to:
  /// **'Informace o restauraci'**
  String get restaurantInfo;

  /// No description provided for @nameLabel.
  ///
  /// In cs, this message translates to:
  /// **'Název'**
  String get nameLabel;

  /// No description provided for @nameRequired.
  ///
  /// In cs, this message translates to:
  /// **'Název je povinný'**
  String get nameRequired;

  /// No description provided for @descriptionLabel.
  ///
  /// In cs, this message translates to:
  /// **'Popis'**
  String get descriptionLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In cs, this message translates to:
  /// **'Telefon'**
  String get phoneLabel;

  /// No description provided for @phoneRequired.
  ///
  /// In cs, this message translates to:
  /// **'Telefon je povinný'**
  String get phoneRequired;

  /// No description provided for @contactEmailLabel.
  ///
  /// In cs, this message translates to:
  /// **'Kontaktní e-mail'**
  String get contactEmailLabel;

  /// No description provided for @addressLabel.
  ///
  /// In cs, this message translates to:
  /// **'Adresa'**
  String get addressLabel;

  /// No description provided for @streetLabel.
  ///
  /// In cs, this message translates to:
  /// **'Ulice'**
  String get streetLabel;

  /// No description provided for @cityLabel.
  ///
  /// In cs, this message translates to:
  /// **'Město'**
  String get cityLabel;

  /// No description provided for @postalCodeLabel.
  ///
  /// In cs, this message translates to:
  /// **'PSČ'**
  String get postalCodeLabel;

  /// No description provided for @countryLabel.
  ///
  /// In cs, this message translates to:
  /// **'Země'**
  String get countryLabel;

  /// No description provided for @savingLabel.
  ///
  /// In cs, this message translates to:
  /// **'Ukládám...'**
  String get savingLabel;

  /// No description provided for @noEmployeesYet.
  ///
  /// In cs, this message translates to:
  /// **'Žádní zaměstnanci.'**
  String get noEmployeesYet;

  /// No description provided for @removeEmployeeTitle.
  ///
  /// In cs, this message translates to:
  /// **'Odebrat zaměstnance'**
  String get removeEmployeeTitle;

  /// No description provided for @removeEmployeeMessage.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chcete odebrat {name}?'**
  String removeEmployeeMessage(String name);

  /// No description provided for @activePanoramaTitle.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní panorama'**
  String get activePanoramaTitle;

  /// No description provided for @activePanoramaDesc.
  ///
  /// In cs, this message translates to:
  /// **'Panorama je nastaveno a zobrazuje se zákazníkům.'**
  String get activePanoramaDesc;

  /// No description provided for @creatingPanorama.
  ///
  /// In cs, this message translates to:
  /// **'Vytvářím...'**
  String get creatingPanorama;

  /// No description provided for @newPanoramaButton.
  ///
  /// In cs, this message translates to:
  /// **'Nové panorama'**
  String get newPanoramaButton;

  /// No description provided for @noPanoramaYetLong.
  ///
  /// In cs, this message translates to:
  /// **'Zatím žádné panorama. Klikněte na tlačítko výše.'**
  String get noPanoramaYetLong;

  /// No description provided for @sessionLabel.
  ///
  /// In cs, this message translates to:
  /// **'Sezení {id}...'**
  String sessionLabel(String id);

  /// No description provided for @photosProgress.
  ///
  /// In cs, this message translates to:
  /// **'{taken}/{total} fotek'**
  String photosProgress(int taken, int total);

  /// No description provided for @statusUploading.
  ///
  /// In cs, this message translates to:
  /// **'Nahrávání'**
  String get statusUploading;

  /// No description provided for @statusProcessing.
  ///
  /// In cs, this message translates to:
  /// **'Zpracování...'**
  String get statusProcessing;

  /// No description provided for @statusCompletedShort.
  ///
  /// In cs, this message translates to:
  /// **'Dokončeno'**
  String get statusCompletedShort;

  /// No description provided for @statusFailed.
  ///
  /// In cs, this message translates to:
  /// **'Selhalo'**
  String get statusFailed;

  /// No description provided for @panoramaActivatedSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Panorama aktivováno!'**
  String get panoramaActivatedSuccess;

  /// No description provided for @tablePositionsSavedSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Pozice stolu uloženy!'**
  String get tablePositionsSavedSuccess;

  /// No description provided for @noReservationsForDayStaff.
  ///
  /// In cs, this message translates to:
  /// **'Žádné rezervace pro tento den.'**
  String get noReservationsForDayStaff;

  /// No description provided for @statusWaiting.
  ///
  /// In cs, this message translates to:
  /// **'Čekající'**
  String get statusWaiting;

  /// No description provided for @complete.
  ///
  /// In cs, this message translates to:
  /// **'Dokončit'**
  String get complete;

  /// No description provided for @searchRestaurantTitle.
  ///
  /// In cs, this message translates to:
  /// **'Vyhledejte svou restauraci'**
  String get searchRestaurantTitle;

  /// No description provided for @searchRestaurantSubtitle.
  ///
  /// In cs, this message translates to:
  /// **'Zadejte IČO vaší firmy pro vyhledání v ARES'**
  String get searchRestaurantSubtitle;

  /// No description provided for @icoHint.
  ///
  /// In cs, this message translates to:
  /// **'např. 12345678'**
  String get icoHint;

  /// No description provided for @foundCompany.
  ///
  /// In cs, this message translates to:
  /// **'Nalezená firma'**
  String get foundCompany;

  /// No description provided for @companyName.
  ///
  /// In cs, this message translates to:
  /// **'Název:'**
  String get companyName;

  /// No description provided for @icoLabel.
  ///
  /// In cs, this message translates to:
  /// **'IČO:'**
  String get icoLabel;

  /// No description provided for @directors.
  ///
  /// In cs, this message translates to:
  /// **'Jednatelé:'**
  String get directors;

  /// No description provided for @emailVerificationFallback.
  ///
  /// In cs, this message translates to:
  /// **'Ověření e-mailem'**
  String get emailVerificationFallback;

  /// No description provided for @emailVerificationFallbackDesc.
  ///
  /// In cs, this message translates to:
  /// **'Identita nebyla potvrzena přes BankID. Můžete ověřit vlastnictví kódem zaslaným na kontaktní e-mail restaurace.'**
  String get emailVerificationFallbackDesc;

  /// No description provided for @emailLabel.
  ///
  /// In cs, this message translates to:
  /// **'E-mail: {email}'**
  String emailLabel(String email);

  /// No description provided for @verificationCodeHint.
  ///
  /// In cs, this message translates to:
  /// **'123456'**
  String get verificationCodeHint;

  /// No description provided for @stepInfo.
  ///
  /// In cs, this message translates to:
  /// **'Informace'**
  String get stepInfo;

  /// No description provided for @stepHours.
  ///
  /// In cs, this message translates to:
  /// **'Otevírací hodiny'**
  String get stepHours;

  /// No description provided for @stepTables.
  ///
  /// In cs, this message translates to:
  /// **'Stoly'**
  String get stepTables;

  /// No description provided for @stepMenu.
  ///
  /// In cs, this message translates to:
  /// **'Menu'**
  String get stepMenu;

  /// No description provided for @stepPanorama.
  ///
  /// In cs, this message translates to:
  /// **'Panorama'**
  String get stepPanorama;

  /// No description provided for @stepSummary.
  ///
  /// In cs, this message translates to:
  /// **'Souhrn'**
  String get stepSummary;

  /// No description provided for @restaurantNameRequired.
  ///
  /// In cs, this message translates to:
  /// **'Název restaurace *'**
  String get restaurantNameRequired;

  /// No description provided for @requiredField.
  ///
  /// In cs, this message translates to:
  /// **'Povinné pole'**
  String get requiredField;

  /// No description provided for @cuisineType.
  ///
  /// In cs, this message translates to:
  /// **'Typ kuchyně'**
  String get cuisineType;

  /// No description provided for @streetRequired.
  ///
  /// In cs, this message translates to:
  /// **'Ulice *'**
  String get streetRequired;

  /// No description provided for @cityRequired.
  ///
  /// In cs, this message translates to:
  /// **'Město *'**
  String get cityRequired;

  /// No description provided for @postalCode.
  ///
  /// In cs, this message translates to:
  /// **'PSČ'**
  String get postalCode;

  /// No description provided for @closedDay.
  ///
  /// In cs, this message translates to:
  /// **'Zavřeno'**
  String get closedDay;

  /// No description provided for @tablesCount.
  ///
  /// In cs, this message translates to:
  /// **'Stoly ({count})'**
  String tablesCount(int count);

  /// No description provided for @tableLabel.
  ///
  /// In cs, this message translates to:
  /// **'Označení'**
  String get tableLabel;

  /// No description provided for @categoriesCount.
  ///
  /// In cs, this message translates to:
  /// **'Kategorie ({count})'**
  String categoriesCount(int count);

  /// No description provided for @categoryName.
  ///
  /// In cs, this message translates to:
  /// **'Název'**
  String get categoryName;

  /// No description provided for @itemName.
  ///
  /// In cs, this message translates to:
  /// **'Název'**
  String get itemName;

  /// No description provided for @itemDescription.
  ///
  /// In cs, this message translates to:
  /// **'Popis'**
  String get itemDescription;

  /// No description provided for @panoramaOptionalTitle.
  ///
  /// In cs, this message translates to:
  /// **'Panorama (volitelné)'**
  String get panoramaOptionalTitle;

  /// No description provided for @panoramaHelpText.
  ///
  /// In cs, this message translates to:
  /// **'Panoramatický snímek restaurace pomůže zákazníkům si místo prohlédnout.'**
  String get panoramaHelpText;

  /// No description provided for @existingSessions.
  ///
  /// In cs, this message translates to:
  /// **'Existující sezení:'**
  String get existingSessions;

  /// No description provided for @statusLabel.
  ///
  /// In cs, this message translates to:
  /// **'Stav: {status}, Fotek: {taken}/{total}'**
  String statusLabel(String status, int taken, int total);

  /// No description provided for @panoramaIsActive.
  ///
  /// In cs, this message translates to:
  /// **'Panorama je aktivní'**
  String get panoramaIsActive;

  /// No description provided for @summaryInfo.
  ///
  /// In cs, this message translates to:
  /// **'Informace o restauraci'**
  String get summaryInfo;

  /// No description provided for @summaryHours.
  ///
  /// In cs, this message translates to:
  /// **'Otevírací hodiny'**
  String get summaryHours;

  /// No description provided for @summaryTables.
  ///
  /// In cs, this message translates to:
  /// **'Alespoň 1 stůl'**
  String get summaryTables;

  /// No description provided for @summaryMenu.
  ///
  /// In cs, this message translates to:
  /// **'Alespoň 1 položka v menu'**
  String get summaryMenu;

  /// No description provided for @summaryPanorama.
  ///
  /// In cs, this message translates to:
  /// **'Panorama (volitelné)'**
  String get summaryPanorama;

  /// No description provided for @publishedSuccess.
  ///
  /// In cs, this message translates to:
  /// **'Restaurace byla úspěšně publikována!'**
  String get publishedSuccess;

  /// No description provided for @fillRequiredSteps.
  ///
  /// In cs, this message translates to:
  /// **'Vyplňte všechny povinné kroky před publikací.'**
  String get fillRequiredSteps;

  /// No description provided for @capturedPhotos.
  ///
  /// In cs, this message translates to:
  /// **'{count}/{total} fotek'**
  String capturedPhotos(int count, int total);

  /// No description provided for @finalize.
  ///
  /// In cs, this message translates to:
  /// **'Finalizovat'**
  String get finalize;

  /// No description provided for @minPhotosHint.
  ///
  /// In cs, this message translates to:
  /// **'Min. {count} fotek pro finalizaci'**
  String minPhotosHint(int count);

  /// No description provided for @newTable.
  ///
  /// In cs, this message translates to:
  /// **'Nový stůl'**
  String get newTable;

  /// No description provided for @editTable.
  ///
  /// In cs, this message translates to:
  /// **'Upravit stůl'**
  String get editTable;

  /// No description provided for @addTableTooltip.
  ///
  /// In cs, this message translates to:
  /// **'Přidat stůl'**
  String get addTableTooltip;

  /// No description provided for @finishAddingTooltip.
  ///
  /// In cs, this message translates to:
  /// **'Ukončit přidávání'**
  String get finishAddingTooltip;

  /// No description provided for @onboardingTitle4.
  ///
  /// In cs, this message translates to:
  /// **'Sledujte vše'**
  String get onboardingTitle4;

  /// No description provided for @onboardingDesc4.
  ///
  /// In cs, this message translates to:
  /// **'Aktualizace objednávek a rezervací v reálném čase'**
  String get onboardingDesc4;

  /// No description provided for @skip.
  ///
  /// In cs, this message translates to:
  /// **'Přeskočit'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In cs, this message translates to:
  /// **'Začít'**
  String get getStarted;

  /// No description provided for @popularNearYou.
  ///
  /// In cs, this message translates to:
  /// **'Populární poblíž'**
  String get popularNearYou;

  /// No description provided for @searchHint.
  ///
  /// In cs, this message translates to:
  /// **'Hledat restaurace, kuchyně...'**
  String get searchHint;

  /// No description provided for @restaurantDescription.
  ///
  /// In cs, this message translates to:
  /// **'Tato restaurace nabízí pečlivě sestavené menu z čerstvých surovin, přívětivou atmosféru a vynikající servis.'**
  String get restaurantDescription;

  /// No description provided for @openingHoursInfo.
  ///
  /// In cs, this message translates to:
  /// **'Otevírací doba'**
  String get openingHoursInfo;

  /// No description provided for @openingHoursValue.
  ///
  /// In cs, this message translates to:
  /// **'9:00 – 22:00'**
  String get openingHoursValue;

  /// No description provided for @phoneInfo.
  ///
  /// In cs, this message translates to:
  /// **'Telefon'**
  String get phoneInfo;

  /// No description provided for @phoneValue.
  ///
  /// In cs, this message translates to:
  /// **'+420 123 456 789'**
  String get phoneValue;

  /// No description provided for @addressInfo.
  ///
  /// In cs, this message translates to:
  /// **'Adresa'**
  String get addressInfo;

  /// No description provided for @addressValue.
  ///
  /// In cs, this message translates to:
  /// **'Hlavní ulice 12, Praha'**
  String get addressValue;

  /// No description provided for @reserveTableButton.
  ///
  /// In cs, this message translates to:
  /// **'Rezervovat stůl'**
  String get reserveTableButton;

  /// No description provided for @noItemsCategory.
  ///
  /// In cs, this message translates to:
  /// **'V této kategorii nejsou žádné položky'**
  String get noItemsCategory;

  /// No description provided for @itemsCount.
  ///
  /// In cs, this message translates to:
  /// **'{count} položek'**
  String itemsCount(int count);

  /// No description provided for @addToCartButton.
  ///
  /// In cs, this message translates to:
  /// **'Přidat do košíku'**
  String get addToCartButton;

  /// No description provided for @editorSaved.
  ///
  /// In cs, this message translates to:
  /// **'Stoly uloženy!'**
  String get editorSaved;

  /// No description provided for @editorSaveError.
  ///
  /// In cs, this message translates to:
  /// **'Chyba při ukládání: {error}'**
  String editorSaveError(String error);

  /// No description provided for @statisticsTab.
  ///
  /// In cs, this message translates to:
  /// **'Statistiky'**
  String get statisticsTab;

  /// No description provided for @employeeCount.
  ///
  /// In cs, this message translates to:
  /// **'Počet zaměstnanců'**
  String get employeeCount;

  /// No description provided for @restaurantStatus.
  ///
  /// In cs, this message translates to:
  /// **'Stav restaurace'**
  String get restaurantStatus;

  /// No description provided for @active.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In cs, this message translates to:
  /// **'Neaktivní'**
  String get inactive;

  /// No description provided for @panoramaStatus.
  ///
  /// In cs, this message translates to:
  /// **'Panorama'**
  String get panoramaStatus;

  /// No description provided for @panoramaAvailable.
  ///
  /// In cs, this message translates to:
  /// **'K dispozici'**
  String get panoramaAvailable;

  /// No description provided for @panoramaNotAvailable.
  ///
  /// In cs, this message translates to:
  /// **'Není k dispozici'**
  String get panoramaNotAvailable;

  /// No description provided for @moreStatsSoon.
  ///
  /// In cs, this message translates to:
  /// **'Další statistiky budou brzy k dispozici.'**
  String get moreStatsSoon;

  /// No description provided for @managePanorama.
  ///
  /// In cs, this message translates to:
  /// **'Spravovat panorama'**
  String get managePanorama;

  /// No description provided for @panoramaSection.
  ///
  /// In cs, this message translates to:
  /// **'Panorama'**
  String get panoramaSection;

  /// No description provided for @noPanoramaInfo.
  ///
  /// In cs, this message translates to:
  /// **'Žádné aktivní panorama. Klepněte pro nastavení.'**
  String get noPanoramaInfo;

  /// No description provided for @activePanoramaInfo.
  ///
  /// In cs, this message translates to:
  /// **'Aktivní panorama je nastaveno.'**
  String get activePanoramaInfo;

  /// No description provided for @calendarHeader.
  ///
  /// In cs, this message translates to:
  /// **'Vyberte den'**
  String get calendarHeader;

  /// No description provided for @collapseCalendar.
  ///
  /// In cs, this message translates to:
  /// **'Skrýt kalendář'**
  String get collapseCalendar;

  /// No description provided for @expandCalendar.
  ///
  /// In cs, this message translates to:
  /// **'Zobrazit kalendář'**
  String get expandCalendar;

  /// No description provided for @timelineView.
  ///
  /// In cs, this message translates to:
  /// **'Časová osa'**
  String get timelineView;

  /// No description provided for @listView.
  ///
  /// In cs, this message translates to:
  /// **'Seznam'**
  String get listView;

  /// No description provided for @noTablesConfigured.
  ///
  /// In cs, this message translates to:
  /// **'Žádné stoly nejsou nakonfigurovány'**
  String get noTablesConfigured;

  /// No description provided for @proposeChange.
  ///
  /// In cs, this message translates to:
  /// **'Navrhnout změnu'**
  String get proposeChange;

  /// No description provided for @extendReservation.
  ///
  /// In cs, this message translates to:
  /// **'Prodloužit'**
  String get extendReservation;

  /// No description provided for @pendingChangeInfo.
  ///
  /// In cs, this message translates to:
  /// **'Zákazník bude požádán o souhlas se změnou.'**
  String get pendingChangeInfo;

  /// No description provided for @extendInfo.
  ///
  /// In cs, this message translates to:
  /// **'Zákazník nebude o prodloužení informován.'**
  String get extendInfo;

  /// No description provided for @waitingForResponse.
  ///
  /// In cs, this message translates to:
  /// **'Čeká na odpověď zákazníka'**
  String get waitingForResponse;

  /// No description provided for @restaurantProposesChange.
  ///
  /// In cs, this message translates to:
  /// **'Restaurace navrhuje změnu'**
  String get restaurantProposesChange;

  /// No description provided for @proposedNewTime.
  ///
  /// In cs, this message translates to:
  /// **'Nový čas: {time}'**
  String proposedNewTime(String time);

  /// No description provided for @proposedNewTable.
  ///
  /// In cs, this message translates to:
  /// **'Nový stůl: {table}'**
  String proposedNewTable(String table);

  /// No description provided for @acceptChange.
  ///
  /// In cs, this message translates to:
  /// **'Přijmout'**
  String get acceptChange;

  /// No description provided for @declineChange.
  ///
  /// In cs, this message translates to:
  /// **'Odmítnout'**
  String get declineChange;

  /// No description provided for @declineWarning.
  ///
  /// In cs, this message translates to:
  /// **'Odmítnutím bude rezervace zrušena.'**
  String get declineWarning;

  /// No description provided for @changeAccepted.
  ///
  /// In cs, this message translates to:
  /// **'Změna byla přijata.'**
  String get changeAccepted;

  /// No description provided for @changeDeclined.
  ///
  /// In cs, this message translates to:
  /// **'Změna byla odmítnuta, rezervace zrušena.'**
  String get changeDeclined;

  /// No description provided for @newStartTime.
  ///
  /// In cs, this message translates to:
  /// **'Nový čas začátku'**
  String get newStartTime;

  /// No description provided for @newEndTime.
  ///
  /// In cs, this message translates to:
  /// **'Nový čas konce'**
  String get newEndTime;

  /// No description provided for @selectTime.
  ///
  /// In cs, this message translates to:
  /// **'Vyberte čas'**
  String get selectTime;

  /// No description provided for @selectTable.
  ///
  /// In cs, this message translates to:
  /// **'Vyberte stůl'**
  String get selectTable;

  /// No description provided for @checkInConfirmMessage.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chcete označit hosta jako přítomného?'**
  String get checkInConfirmMessage;

  /// No description provided for @completeConfirmMessage.
  ///
  /// In cs, this message translates to:
  /// **'Opravdu chcete ukončit tuto rezervaci?'**
  String get completeConfirmMessage;

  /// No description provided for @payButton.
  ///
  /// In cs, this message translates to:
  /// **'Zaplatit'**
  String get payButton;

  /// No description provided for @paymentPending.
  ///
  /// In cs, this message translates to:
  /// **'Čeká na platbu'**
  String get paymentPending;

  /// No description provided for @paymentPaid.
  ///
  /// In cs, this message translates to:
  /// **'Zaplaceno'**
  String get paymentPaid;

  /// No description provided for @paymentFailed.
  ///
  /// In cs, this message translates to:
  /// **'Platba selhala'**
  String get paymentFailed;

  /// No description provided for @paymentProcessing.
  ///
  /// In cs, this message translates to:
  /// **'Zpracovává se...'**
  String get paymentProcessing;

  /// No description provided for @paymentCancelled.
  ///
  /// In cs, this message translates to:
  /// **'Platba zrušena'**
  String get paymentCancelled;

  /// No description provided for @paymentInitiating.
  ///
  /// In cs, this message translates to:
  /// **'Spouštím platbu...'**
  String get paymentInitiating;

  /// No description provided for @paymentErrorRetry.
  ///
  /// In cs, this message translates to:
  /// **'Nepodařilo se spustit platbu. Zkuste to znovu.'**
  String get paymentErrorRetry;
}

class _SDelegate extends LocalizationsDelegate<S> {
  const _SDelegate();

  @override
  Future<S> load(Locale locale) {
    return SynchronousFuture<S>(lookupS(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['cs', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SDelegate old) => false;
}

S lookupS(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs': return SCs();
    case 'en': return SEn();
  }

  throw FlutterError(
    'S.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
