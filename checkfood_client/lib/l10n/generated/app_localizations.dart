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
  /// **'Registrovat se jako majitel restaurace'**
  String get registerAsOwner;

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
