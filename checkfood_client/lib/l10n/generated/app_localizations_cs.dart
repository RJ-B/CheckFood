// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class SCs extends S {
  SCs([String locale = 'cs']) : super(locale);

  @override
  String get appTitle => 'CheckFood';

  @override
  String get splashTagline => 'Reservations & Orders. Simplified.';

  @override
  String get splashCheck => 'Check';

  @override
  String get splashFood => 'Food';

  @override
  String get onboardingTitle1 => 'Objevte restaurace';

  @override
  String get onboardingDesc1 => 'Najděte ideální místo pro každou příležitost';

  @override
  String get onboardingTitle2 => 'Snadné rezervace';

  @override
  String get onboardingDesc2 => 'Rezervujte stoly okamžitě, kdykoliv';

  @override
  String get onboardingTitle3 => 'Objednejte si jídlo';

  @override
  String get onboardingDesc3 => 'Rozvoz, výdej nebo konzumace na místě';

  @override
  String get onboardingGetStarted => 'Začít';

  @override
  String get onboardingNext => 'Další';

  @override
  String get login => 'Přihlásit se';

  @override
  String get loginTitle => 'PŘIHLÁSIT SE';

  @override
  String get register => 'Registrace';

  @override
  String get logout => 'Odhlásit se';

  @override
  String get logoutTitle => 'Odhlášení';

  @override
  String get logoutConfirm => 'Opravdu se chcete odhlásit ze svého účtu?';

  @override
  String get forgotPassword => 'Zapomněli jste heslo?';

  @override
  String get forgotPasswordTitle => 'Obnova hesla';

  @override
  String get forgotPasswordSubtitle => 'Zadejte svůj e-mail a my vám pošleme odkaz pro obnovu hesla.';

  @override
  String get forgotPasswordSend => 'Odeslat odkaz';

  @override
  String forgotPasswordSent(String email) {
    return 'Odkaz pro obnovu hesla byl odeslán na $email. Zkontrolujte svou e-mailovou schránku.';
  }

  @override
  String get forgotPasswordCheckSpam => 'Nenašel/la jste e-mail? Zkontrolujte složku spam.';

  @override
  String get resetPasswordTitle => 'Nové heslo';

  @override
  String get resetPasswordSubtitle => 'Zadejte své nové heslo.';

  @override
  String get newPasswordLabel => 'Nové heslo';

  @override
  String get confirmNewPasswordLabel => 'Potvrzení hesla';

  @override
  String get resetPasswordButton => 'Nastavit nové heslo';

  @override
  String get resetPasswordSuccess => 'Heslo bylo úspěšně změněno! Nyní se můžete přihlásit.';

  @override
  String get passwordsDoNotMatch => 'Hesla se neshodují.';

  @override
  String get passwordTooShort => 'Heslo musí mít alespoň 8 znaků.';

  @override
  String get errorForgotPassword => 'Nepodařilo se odeslat odkaz. Zkuste to později.';

  @override
  String get errorResetPassword => 'Nepodařilo se nastavit nové heslo.';

  @override
  String continueWith(String label) {
    return 'Pokračovat s $label';
  }

  @override
  String get resolveActivation => 'VYŘEŠIT AKTIVACI ÚČTU';

  @override
  String get email => 'E-mail';

  @override
  String get password => 'Heslo';

  @override
  String get newPassword => 'Nové heslo';

  @override
  String get firstName => 'Jméno';

  @override
  String get lastName => 'Příjmení';

  @override
  String get username => 'Uživatelské jméno';

  @override
  String get phone => 'Telefon';

  @override
  String get emailVerificationTitle => 'Ověření e-mailu';

  @override
  String get sendVerificationCode => 'Odeslat ověřovací kód';

  @override
  String get verificationCode => 'Ověřovací kód';

  @override
  String get confirmCode => 'Potvrdit kód';

  @override
  String get emailVerified => 'E-mail byl úspěšně ověřen!';

  @override
  String get verifyIdentity => 'Ověřit identitu (BankID)';

  @override
  String get changePassword => 'Změna hesla';

  @override
  String get changePasswordSuccess => 'Heslo bylo úspěšně změněno.';

  @override
  String get passwordManagedByProvider => 'Heslo spravuje externí poskytovatel';

  @override
  String loginVia(String provider) {
    return 'Přihlášení přes $provider';
  }

  @override
  String get profile => 'Můj Profil';

  @override
  String get personalData => 'Osobní údaje';

  @override
  String get personalDataSubtitle => 'Jméno, příjmení a kontaktní údaje';

  @override
  String get myReservations => 'Moje rezervace';

  @override
  String get myReservationsSubtitle => 'Historie a nadcházející rezervace';

  @override
  String get reservationsModuleSoon => 'Modul Rezervace bude brzy dostupný.';

  @override
  String get profileUpdated => 'Údaje byly úspěšně aktualizovány';

  @override
  String get sectionMyAccount => 'Můj Účet';

  @override
  String get sectionSecurity => 'Zabezpečení';

  @override
  String get sectionApp => 'Aplikace';

  @override
  String get deviceManagement => 'Správa zařízení';

  @override
  String get activeDevices => 'Aktivní zařízení';

  @override
  String activeDevicesCount(int count) {
    return '$count aktivních zařízení';
  }

  @override
  String get noOtherDevices => 'Žádná další aktivní zařízení.';

  @override
  String get logoutOthers => 'Odhlásit ostatní';

  @override
  String get loggedOutFromDevices => 'Byl jste odhlášen ze všech ostatních zařízení.';

  @override
  String get pushNotifications => 'Push notifikace';

  @override
  String get enabled => 'Zapnuto';

  @override
  String get disabled => 'Vypnuto';

  @override
  String get help => 'Nápověda';

  @override
  String get contactSupport => 'Kontaktovat podporu';

  @override
  String get language => 'Jazyk';

  @override
  String get languageSubtitle => 'Čeština / English';

  @override
  String get czech => 'Čeština';

  @override
  String get english => 'English';

  @override
  String get explore => 'Explore';

  @override
  String get favorites => 'Oblíbené';

  @override
  String get orders => 'Objednávky';

  @override
  String get ordersTitle => 'Orders';

  @override
  String get menu => 'Menu';

  @override
  String get history => 'Historie';

  @override
  String get upcoming => 'Nadcházející';

  @override
  String get settings => 'Nastavení';

  @override
  String get searchRestaurants => 'Hledat restaurace...';

  @override
  String get locationPermissionTitle => 'Povolení polohy';

  @override
  String get allowInSystem => 'Povolit v systému';

  @override
  String get cannotGetLocation => 'Nelze zjistit polohu. Zkontrolujte oprávnění.';

  @override
  String get reserveTable => 'Rezervovat stůl';

  @override
  String get tableReservation => 'Rezervace stolu';

  @override
  String get date => 'Datum';

  @override
  String get time => 'Čas';

  @override
  String get guests => 'Počet hostů';

  @override
  String get note => 'Poznámka';

  @override
  String get reservationCreated => 'Rezervace vytvořena! Čeká na potvrzení.';

  @override
  String get reservationEdited => 'Rezervace upravena.';

  @override
  String get reservationCancelled => 'Rezervace zrušena.';

  @override
  String get cancelReservation => 'Zrušit rezervaci';

  @override
  String get cancelReservationConfirm => 'Opravdu chcete zrušit tuto rezervaci?';

  @override
  String get slotUnavailable => 'Termín už není volný. Vyberte jiný čas.';

  @override
  String get noReservationsForDay => 'Žádné rezervace pro tento den.';

  @override
  String get edit => 'Upravit';

  @override
  String get cancel => 'Zrušit';

  @override
  String get confirm => 'Potvrdit';

  @override
  String get reject => 'Odmítnout';

  @override
  String get checkIn => 'Check-in';

  @override
  String get yes => 'Ano';

  @override
  String get yesCancelIt => 'Ano, zrušit';

  @override
  String get no => 'Ne';

  @override
  String get order => 'Objednat';

  @override
  String get sendOrder => 'Odeslat objednávku';

  @override
  String get orderSent => 'Objednávka odeslána!';

  @override
  String get emptyCart => 'Vyprázdnit';

  @override
  String cartItems(int count) {
    return '$count pol.';
  }

  @override
  String get noItems => 'Menu je prázdné.';

  @override
  String get noItemsInCategory => 'V této kategorii nejsou žádné položky';

  @override
  String get addToCart => 'Přidat do košíku';

  @override
  String get tableEditor => 'Editor stolu';

  @override
  String get tableName => 'Název stolu';

  @override
  String get capacity => 'Kapacita';

  @override
  String capacityOf(int count) {
    return 'Kapacita: $count';
  }

  @override
  String tableSeats(String label, int capacity) {
    return '$label ($capacity míst)';
  }

  @override
  String get addTable => 'Přidat stůl';

  @override
  String get tablePositionsSaved => 'Pozice stolu uloženy!';

  @override
  String get tablesSaved => 'Stoly uloženy!';

  @override
  String get noTablesYet => 'Zatím žádné stoly. Přidejte alespoň jeden.';

  @override
  String get myRestaurant => 'My Restaurant';

  @override
  String get restaurantName => 'Název restaurace';

  @override
  String get city => 'Město';

  @override
  String get address => 'Adresa';

  @override
  String get contactEmail => 'Kontaktní e-mail';

  @override
  String get description => 'Popis';

  @override
  String get information => 'Informace';

  @override
  String get openingHours => 'Otevírací hodiny';

  @override
  String get open => 'Otevřeno';

  @override
  String get closed => 'Zavřeno';

  @override
  String get saveHours => 'Uložit hodiny';

  @override
  String get saveInfo => 'Uložit informace';

  @override
  String get saveChanges => 'Uložit změny';

  @override
  String get save => 'Uložit';

  @override
  String get publishRestaurant => 'Publikovat restauraci';

  @override
  String get restaurantPublished => 'Restaurace byla publikována!';

  @override
  String get restaurantAssigned => 'Restaurace byla úspěšně přiřazena!';

  @override
  String get searchAres => 'Vyhledat v ARES';

  @override
  String get enterManually => 'Zadat ručně';

  @override
  String get companyId => 'IČO firmy';

  @override
  String get ownerRegistration => 'Registrace majitele';

  @override
  String get assignRestaurant => 'Přiřazení restaurace';

  @override
  String get claimRestaurant => 'Přiřazení restaurace';

  @override
  String get addEmployee => 'Přidat zaměstnance';

  @override
  String get removeEmployee => 'Odebrat zaměstnance';

  @override
  String removeEmployeeConfirm(String name) {
    return 'Opravdu chcete odebrat $name?';
  }

  @override
  String get manager => 'Manager';

  @override
  String get staff => 'Staff';

  @override
  String get owner => 'Owner';

  @override
  String get newCategory => 'Nová kategorie';

  @override
  String get newItem => 'Nová položka';

  @override
  String categoryCount(int count) {
    return 'Kategorie ($count)';
  }

  @override
  String tableCount(int count) {
    return 'Stoly ($count)';
  }

  @override
  String get noCategoriesYet => 'Zatím žádné kategorie. Přidejte alespoň jednu.';

  @override
  String get priceLabel => 'Cena (Kč)';

  @override
  String get panorama => 'Panorama';

  @override
  String get panoramaOptional => 'Panorama (volitelné)';

  @override
  String get newPanorama => 'Nové panorama';

  @override
  String get activePanorama => 'Aktivní panorama';

  @override
  String get panoramaActivated => 'Panorama aktivováno!';

  @override
  String get panoramaActive => 'Panorama je aktivní';

  @override
  String get panoramaActiveDesc => 'Panorama je nastaveno a zobrazuje se zákazníkům.';

  @override
  String get panoramaHelp => 'Panoramatický snímek restaurace pomůže zákazníkům si místo prohlédnout.';

  @override
  String get noPanoramaYet => 'Zatím žádné panorama. Klikněte na tlačítko výše.';

  @override
  String get stitchingFailed => 'Stitching selhal. Zkuste to znovu.';

  @override
  String photoUploadFailed(String error) {
    return 'Nahrání fotky selhalo: $error';
  }

  @override
  String get arPhotoSphere => 'AR Photo Sphere';

  @override
  String get settingsSummary => 'Souhrn nastavení';

  @override
  String get finish => 'Dokončit';

  @override
  String get next => 'Další';

  @override
  String get back => 'Zpět';

  @override
  String get close => 'Zavřít';

  @override
  String get delete => 'Smazat';

  @override
  String get add => 'Přidat';

  @override
  String get activate => 'Aktivovat';

  @override
  String get done => 'Hotovo';

  @override
  String get change => 'Změnit';

  @override
  String get creating => 'Vytvářím...';

  @override
  String get saving => 'Ukládám...';

  @override
  String get retry => 'Zkusit znovu';

  @override
  String get loadAgain => 'Načíst znovu';

  @override
  String get clearFilter => 'Zrušit filtr';

  @override
  String get error => 'Chyba';

  @override
  String errorGeneric(String message) {
    return 'Chyba: $message';
  }

  @override
  String get routeNotFound => 'Chyba: cesta nenalezena';

  @override
  String savingError(String error) {
    return 'Chyba při ukládání: $error';
  }

  @override
  String get accountActivated => 'Váš účet byl úspěšně aktivován! Nyní se můžete přihlásit.';

  @override
  String get activationError => 'Chyba při aktivaci účtu.';

  @override
  String get loginSubtitle => 'Přihlaste se ke svému účtu';

  @override
  String get or => 'NEBO';

  @override
  String get noAccountYet => 'Ještě nemáte účet?';

  @override
  String get signUp => 'Zaregistrujte se';

  @override
  String get registerAsOwner => 'Chci přidat svou restauraci';

  @override
  String get registerAsOwnerSubtitle => 'Vytvoříme vám zkušební restauraci — doladíte ji po přihlášení';

  @override
  String get enterEmail => 'Zadejte e-mail';

  @override
  String get enterValidEmail => 'Zadejte platný formát e-mailu';

  @override
  String get enterPassword => 'Zadejte heslo';

  @override
  String get emailHint => 'vase@adresa.cz';

  @override
  String get registerTitle => 'Registrace';

  @override
  String get createAccount => 'Vytvořte si účet';

  @override
  String get registerSubtitle => 'Zadejte své údaje pro zahájení cesty s CheckFood';

  @override
  String get registerSuccess => 'Registrace proběhla úspěšně. Zkontrolujte svůj e-mail.';

  @override
  String get alreadyHaveAccount => 'Již máte účet?';

  @override
  String get loginAction => 'Přihlaste se';

  @override
  String get checkEmail => 'Zkontrolujte si e-mail';

  @override
  String verificationEmailSent(String email) {
    return 'Na adresu $email jsme odeslali potvrzovací odkaz.';
  }

  @override
  String get backToLogin => 'Zpět na přihlášení';

  @override
  String get emailNotReceived => 'Nedostal jste e-mail nebo odkaz vypršel?';

  @override
  String get resend => 'Odeslat znovu';

  @override
  String get resendCode => 'ZNOVU ODESLAT';

  @override
  String get oldPassword => 'Staré heslo';

  @override
  String get enterOldPassword => 'Zadejte staré heslo';

  @override
  String get confirmPassword => 'Potvrzení hesla';

  @override
  String get changePasswordButton => 'Změnit heslo';

  @override
  String get basicInfo => 'Základní informace';

  @override
  String get basicInfoSubtitle => 'Zde můžete upravit své jméno a příjmení.';

  @override
  String get enterFirstName => 'Prosím zadejte jméno';

  @override
  String get enterLastName => 'Prosím zadejte příjmení';

  @override
  String get cart => 'Košík';

  @override
  String get orderNote => 'Poznámka k objednávce...';

  @override
  String get total => 'Celkem:';

  @override
  String get myOrders => 'Moje objednávky';

  @override
  String get tapTableHint => 'Klepněte na stůl pro zobrazení volných termínů';

  @override
  String get sceneLoadFailed => 'Nepodařilo se načíst scénu.';

  @override
  String get ownerRegisterTitle => 'Registrace majitele';

  @override
  String get ownerRegisterHeading => 'Registrace majitele restaurace';

  @override
  String get ownerRegisterSubtitle => 'Vytvořte si účet pro správu vaší restaurace';

  @override
  String get emailRequired => 'E-mail je povinný';

  @override
  String get enterValidEmailShort => 'Zadejte platný e-mail';

  @override
  String get role => 'Role';

  @override
  String get locationPermissionDesc => 'Abychom vám mohli ukázat nejbližší restaurace v okolí a zajistit navigaci, potřebujeme přístup k vaší poloze.';

  @override
  String get errorProfileLoad => 'Chyba při načítání uživatelského profilu.';

  @override
  String get errorUnexpected => 'Neočekávaná chyba serveru.';

  @override
  String get errorRegisterFailed => 'Registrace selhala.';

  @override
  String get errorVerificationFailed => 'Verifikace selhala.';

  @override
  String get errorGoogleLogin => 'Google přihlášení selhalo.';

  @override
  String get errorAppleLogin => 'Apple přihlášení selhalo.';

  @override
  String get deviceManagementTitle => 'Správa zařízení';

  @override
  String get noActiveDevices => 'Žádná aktivní zařízení.';

  @override
  String get thisDevice => 'Toto zařízení';

  @override
  String lastActivity(String date) {
    return 'Poslední přihlášení: $date';
  }

  @override
  String get logoutDevice => 'Odhlásit zařízení';

  @override
  String get deleteDevice => 'Smazat zařízení';

  @override
  String get deviceActive => 'Aktivní';

  @override
  String get deviceInactive => 'Neaktivní';

  @override
  String get logoutAll => 'Odhlásit všechna';

  @override
  String get deleteAll => 'Smazat všechna';

  @override
  String get logoutAllDevices => 'Odhlásit všechna zařízení';

  @override
  String get deleteAllDevices => 'Smazat všechna zařízení';

  @override
  String get logoutDeviceDialogTitle => 'Odhlásit zařízení?';

  @override
  String get logoutDeviceDialogContent => 'Zařízení bude odhlášeno, ale zůstane uloženo v seznamu.';

  @override
  String get deleteDeviceDialogTitle => 'Smazat zařízení?';

  @override
  String get deleteDeviceDialogContent => 'Zařízení bude odhlášeno a trvale odstraněno ze seznamu.';

  @override
  String get logoutAllDevicesDialogTitle => 'Odhlásit všechna zařízení?';

  @override
  String get logoutAllDevicesDialogContent => 'Všechna zařízení kromě tohoto budou odhlášena, ale zůstanou uložena v seznamu.';

  @override
  String get deleteAllDevicesDialogTitle => 'Smazat všechna zařízení?';

  @override
  String get deleteAllDevicesDialogContent => 'Všechna zařízení kromě tohoto budou odhlášena a trvale odstraněna ze seznamu.';

  @override
  String get firstNameRequired => 'Jméno nesmí být prázdné';

  @override
  String get lastNameRequired => 'Příjmení nesmí být prázdné';

  @override
  String photoUploadError(String error) {
    return 'Nahrání fotky selhalo: $error';
  }

  @override
  String get userNoName => 'Uživatel bez jména';

  @override
  String get inactiveAccount => 'Neaktivní účet';

  @override
  String get aboutRestaurant => 'O restauraci';

  @override
  String get openingHoursLabel => 'Otevírací doba';

  @override
  String get dayMonday => 'Pondělí';

  @override
  String get dayTuesday => 'Úterý';

  @override
  String get dayWednesday => 'Středa';

  @override
  String get dayThursday => 'Čtvrtek';

  @override
  String get dayFriday => 'Pátek';

  @override
  String get daySaturday => 'Sobota';

  @override
  String get daySunday => 'Neděle';

  @override
  String get noUpcomingReservations => 'Žádné nadcházející rezervace';

  @override
  String get noReservationHistory => 'Žádná historie rezervací';

  @override
  String showAll(int count) {
    return 'Zobrazit vše ($count)';
  }

  @override
  String get restaurant => 'Restaurace';

  @override
  String get table => 'Stůl';

  @override
  String partySizeShort(int count) {
    return '$count os.';
  }

  @override
  String timeFrom(String time) {
    return 'od $time';
  }

  @override
  String get statusPending => 'Čeká na potvrzení';

  @override
  String get statusConfirmed => 'Potvrzeno';

  @override
  String get statusCancelled => 'Zrušeno';

  @override
  String get statusRejected => 'Zamítnuto';

  @override
  String get statusCompleted => 'Dokončeno';

  @override
  String get statusCheckedIn => 'Přítomen';

  @override
  String get statusReserved => 'Potvrzeno';

  @override
  String get editReservation => 'Upravit rezervaci';

  @override
  String get availableTimes => 'Dostupné časy';

  @override
  String get noSlotsForDay => 'Žádné volné termíny pro tento den.';

  @override
  String get partyCount => 'Počet osob';

  @override
  String get guestsLabel => 'Počet hostů:';

  @override
  String get freeTimes => 'Volné časy';

  @override
  String get confirmReservation => 'Potvrdit rezervaci';

  @override
  String get menuEmpty => 'Menu je prázdné.';

  @override
  String itemsShort(int count) {
    return '$count pol.';
  }

  @override
  String get selectRestaurant => 'Vyberte restauraci';

  @override
  String get reservationsTab => 'Rezervace';

  @override
  String get infoTab => 'Info';

  @override
  String get employeesTab => 'Zaměstnanci';

  @override
  String get settingsTab => 'Nastavení';

  @override
  String get restaurantInfo => 'Informace o restauraci';

  @override
  String get nameLabel => 'Název';

  @override
  String get nameRequired => 'Název je povinný';

  @override
  String get descriptionLabel => 'Popis';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get phoneRequired => 'Telefon je povinný';

  @override
  String get contactEmailLabel => 'Kontaktní e-mail';

  @override
  String get addressLabel => 'Adresa';

  @override
  String get streetLabel => 'Ulice';

  @override
  String get cityLabel => 'Město';

  @override
  String get postalCodeLabel => 'PSČ';

  @override
  String get countryLabel => 'Země';

  @override
  String get savingLabel => 'Ukládám...';

  @override
  String get noEmployeesYet => 'Žádní zaměstnanci.';

  @override
  String get removeEmployeeTitle => 'Odebrat zaměstnance';

  @override
  String removeEmployeeMessage(String name) {
    return 'Opravdu chcete odebrat $name?';
  }

  @override
  String get activePanoramaTitle => 'Aktivní panorama';

  @override
  String get activePanoramaDesc => 'Panorama je nastaveno a zobrazuje se zákazníkům.';

  @override
  String get creatingPanorama => 'Vytvářím...';

  @override
  String get newPanoramaButton => 'Nové panorama';

  @override
  String get noPanoramaYetLong => 'Zatím žádné panorama. Klikněte na tlačítko výše.';

  @override
  String sessionLabel(String id) {
    return 'Sezení $id...';
  }

  @override
  String photosProgress(int taken, int total) {
    return '$taken/$total fotek';
  }

  @override
  String get statusUploading => 'Nahrávání';

  @override
  String get statusProcessing => 'Zpracování...';

  @override
  String get statusCompletedShort => 'Dokončeno';

  @override
  String get statusFailed => 'Selhalo';

  @override
  String get panoramaActivatedSuccess => 'Panorama aktivováno!';

  @override
  String get tablePositionsSavedSuccess => 'Pozice stolu uloženy!';

  @override
  String get noReservationsForDayStaff => 'Žádné rezervace pro tento den.';

  @override
  String get statusWaiting => 'Čekající';

  @override
  String get complete => 'Dokončit';

  @override
  String get searchRestaurantTitle => 'Vyhledejte svou restauraci';

  @override
  String get searchRestaurantSubtitle => 'Zadejte IČO vaší firmy pro vyhledání v ARES';

  @override
  String get icoHint => 'např. 12345678';

  @override
  String get foundCompany => 'Nalezená firma';

  @override
  String get companyName => 'Název:';

  @override
  String get icoLabel => 'IČO:';

  @override
  String get directors => 'Jednatelé:';

  @override
  String get emailVerificationFallback => 'Ověření e-mailem';

  @override
  String get emailVerificationFallbackDesc => 'Identita nebyla potvrzena přes BankID. Můžete ověřit vlastnictví kódem zaslaným na kontaktní e-mail restaurace.';

  @override
  String emailLabel(String email) {
    return 'E-mail: $email';
  }

  @override
  String get verificationCodeHint => '123456';

  @override
  String get stepInfo => 'Informace';

  @override
  String get stepHours => 'Otevírací hodiny';

  @override
  String get stepTables => 'Stoly';

  @override
  String get stepMenu => 'Menu';

  @override
  String get stepPanorama => 'Panorama';

  @override
  String get stepSummary => 'Souhrn';

  @override
  String get restaurantNameRequired => 'Název restaurace *';

  @override
  String get requiredField => 'Povinné pole';

  @override
  String get cuisineType => 'Typ kuchyně';

  @override
  String get streetRequired => 'Ulice *';

  @override
  String get cityRequired => 'Město *';

  @override
  String get postalCode => 'PSČ';

  @override
  String get closedDay => 'Zavřeno';

  @override
  String tablesCount(int count) {
    return 'Stoly ($count)';
  }

  @override
  String get tableLabel => 'Označení';

  @override
  String categoriesCount(int count) {
    return 'Kategorie ($count)';
  }

  @override
  String get categoryName => 'Název';

  @override
  String get itemName => 'Název';

  @override
  String get itemDescription => 'Popis';

  @override
  String get panoramaOptionalTitle => 'Panorama (volitelné)';

  @override
  String get panoramaHelpText => 'Panoramatický snímek restaurace pomůže zákazníkům si místo prohlédnout.';

  @override
  String get existingSessions => 'Existující sezení:';

  @override
  String statusLabel(String status, int taken, int total) {
    return 'Stav: $status, Fotek: $taken/$total';
  }

  @override
  String get panoramaIsActive => 'Panorama je aktivní';

  @override
  String get summaryInfo => 'Informace o restauraci';

  @override
  String get summaryHours => 'Otevírací hodiny';

  @override
  String get summaryTables => 'Alespoň 1 stůl';

  @override
  String get summaryMenu => 'Alespoň 1 položka v menu';

  @override
  String get summaryPanorama => 'Panorama (volitelné)';

  @override
  String get publishedSuccess => 'Restaurace byla úspěšně publikována!';

  @override
  String get fillRequiredSteps => 'Vyplňte všechny povinné kroky před publikací.';

  @override
  String capturedPhotos(int count, int total) {
    return '$count/$total fotek';
  }

  @override
  String get finalize => 'Finalizovat';

  @override
  String minPhotosHint(int count) {
    return 'Min. $count fotek pro finalizaci';
  }

  @override
  String get newTable => 'Nový stůl';

  @override
  String get editTable => 'Upravit stůl';

  @override
  String get addTableTooltip => 'Přidat stůl';

  @override
  String get finishAddingTooltip => 'Ukončit přidávání';

  @override
  String get onboardingTitle4 => 'Sledujte vše';

  @override
  String get onboardingDesc4 => 'Aktualizace objednávek a rezervací v reálném čase';

  @override
  String get skip => 'Přeskočit';

  @override
  String get getStarted => 'Začít';

  @override
  String get popularNearYou => 'Populární poblíž';

  @override
  String get searchHint => 'Hledat restaurace, kuchyně...';

  @override
  String get restaurantDescription => 'Tato restaurace nabízí pečlivě sestavené menu z čerstvých surovin, přívětivou atmosféru a vynikající servis.';

  @override
  String get openingHoursInfo => 'Otevírací doba';

  @override
  String get openingHoursValue => '9:00 – 22:00';

  @override
  String get phoneInfo => 'Telefon';

  @override
  String get phoneValue => '+420 123 456 789';

  @override
  String get addressInfo => 'Adresa';

  @override
  String get addressValue => 'Hlavní ulice 12, Praha';

  @override
  String get reserveTableButton => 'Rezervovat stůl';

  @override
  String get noItemsCategory => 'V této kategorii nejsou žádné položky';

  @override
  String itemsCount(int count) {
    return '$count položek';
  }

  @override
  String get addToCartButton => 'Přidat do košíku';

  @override
  String get editorSaved => 'Stoly uloženy!';

  @override
  String editorSaveError(String error) {
    return 'Chyba při ukládání: $error';
  }

  @override
  String get statisticsTab => 'Statistiky';

  @override
  String get employeeCount => 'Počet zaměstnanců';

  @override
  String get restaurantStatus => 'Stav restaurace';

  @override
  String get active => 'Aktivní';

  @override
  String get inactive => 'Neaktivní';

  @override
  String get panoramaStatus => 'Panorama';

  @override
  String get panoramaAvailable => 'K dispozici';

  @override
  String get panoramaNotAvailable => 'Není k dispozici';

  @override
  String get moreStatsSoon => 'Další statistiky budou brzy k dispozici.';

  @override
  String get managePanorama => 'Spravovat panorama';

  @override
  String get panoramaSection => 'Panorama';

  @override
  String get noPanoramaInfo => 'Žádné aktivní panorama. Klepněte pro nastavení.';

  @override
  String get activePanoramaInfo => 'Aktivní panorama je nastaveno.';

  @override
  String get calendarHeader => 'Vyberte den';

  @override
  String get collapseCalendar => 'Skrýt kalendář';

  @override
  String get expandCalendar => 'Zobrazit kalendář';

  @override
  String get timelineView => 'Časová osa';

  @override
  String get listView => 'Seznam';

  @override
  String get noTablesConfigured => 'Žádné stoly nejsou nakonfigurovány';

  @override
  String get proposeChange => 'Navrhnout změnu';

  @override
  String get extendReservation => 'Prodloužit';

  @override
  String get pendingChangeInfo => 'Zákazník bude požádán o souhlas se změnou.';

  @override
  String get extendInfo => 'Zákazník nebude o prodloužení informován.';

  @override
  String get waitingForResponse => 'Čeká na odpověď zákazníka';

  @override
  String get restaurantProposesChange => 'Restaurace navrhuje změnu';

  @override
  String proposedNewTime(String time) {
    return 'Nový čas: $time';
  }

  @override
  String proposedNewTable(String table) {
    return 'Nový stůl: $table';
  }

  @override
  String get acceptChange => 'Přijmout';

  @override
  String get declineChange => 'Odmítnout';

  @override
  String get declineWarning => 'Odmítnutím bude rezervace zrušena.';

  @override
  String get changeAccepted => 'Změna byla přijata.';

  @override
  String get changeDeclined => 'Změna byla odmítnuta, rezervace zrušena.';

  @override
  String get newStartTime => 'Nový čas začátku';

  @override
  String get newEndTime => 'Nový čas konce';

  @override
  String get selectTime => 'Vyberte čas';

  @override
  String get selectTable => 'Vyberte stůl';

  @override
  String get checkInConfirmMessage => 'Opravdu chcete označit hosta jako přítomného?';

  @override
  String get completeConfirmMessage => 'Opravdu chcete ukončit tuto rezervaci?';

  @override
  String get payButton => 'Zaplatit';

  @override
  String get paymentPending => 'Čeká na platbu';

  @override
  String get paymentPaid => 'Zaplaceno';

  @override
  String get paymentFailed => 'Platba selhala';

  @override
  String get paymentProcessing => 'Zpracovává se...';

  @override
  String get paymentCancelled => 'Platba zrušena';

  @override
  String get paymentInitiating => 'Spouštím platbu...';

  @override
  String get paymentErrorRetry => 'Nepodařilo se spustit platbu. Zkuste to znovu.';
}
