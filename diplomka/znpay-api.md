# Moone Payment API (ZnPay) — Kompletní dokumentace

**Base URL:** `https://api.znpay.tech`  
**Autentizace:** Bearer JWT (`Authorization: Bearer {token}`)  
**Zdroj:** [Swagger UI](https://api.znpay.tech/swagger/index.html)

---

## Obsah

1. [Autentizace](#1-autentizace)
2. [Merchants](#2-merchants)
3. [Pay Points](#3-pay-points)
4. [Transakce](#4-transakce)
5. [Transakce — externí identifikátory](#5-transakce--externí-identifikátory)
6. [Schémata](#6-schémata)
7. [Enumerace](#7-enumerace)
8. [Chybové odpovědi](#8-chybové-odpovědi)

---

## 1. Autentizace

### POST `/payment/api/auth/sign-in`

Přihlášení uživatele. Vrací JWT token pro autorizaci dalších požadavků.

**Request Body** — `PublicSignInCommand`:

| Pole       | Typ      | Povinné | Popis                          |
|------------|----------|---------|--------------------------------|
| `login`    | `string` | ano     | Přihlašovací jméno (určuje Identity Provider) |
| `password` | `string` | ano     | Heslo uživatele                |

**Odpovědi:**

| Kód | Typ                 | Popis                    |
|-----|---------------------|--------------------------|
| 200 | `SignInResult`       | Úspěšné přihlášení       |
| 403 | `ApiProblemDetails`  | Přístup zamítnut          |
| 404 | `ApiProblemDetails`  | Uživatel nenalezen        |

**Schéma odpovědi** — `SignInResult`:

| Pole             | Typ           | Popis                          |
|------------------|---------------|--------------------------------|
| `token`          | `string`      | JWT autentizační token         |
| `userStatus`     | `UserStatus`  | Aktuální stav uživatele        |
| `partyPublicID`  | `guid`        | Veřejný identifikátor strany   |
| `login`          | `string`      | Přihlašovací jméno             |
| `firstName`      | `string`      | Křestní jméno                  |
| `lastName`       | `string`      | Příjmení                       |

---

## 2. Merchants

### GET `/payment/api/merchants/external/{merchantID}/detail`

Získání detailních informací o obchodníkovi podle jeho externího identifikátoru.

**Path parametry:**

| Parametr     | Typ      | Povinné | Popis                     |
|--------------|----------|---------|---------------------------|
| `merchantID` | `string` | ano     | Externí identifikátor obchodníka |

**Odpovědi:**

| Kód | Typ                        | Popis                     |
|-----|----------------------------|---------------------------|
| 200 | `MerchantPublicDetailDto`  | Detail obchodníka         |
| 404 | `ApiProblemDetails`        | Obchodník nenalezen       |

**Schéma odpovědi** — `MerchantPublicDetailDto`:

| Pole                   | Typ               | Popis                          |
|------------------------|--------------------|--------------------------------|
| `publicID`             | `guid`            | Veřejný identifikátor          |
| `externalID`           | `string`          | Externí identifikátor          |
| `status`               | `MerchantStatus`  | Aktuální stav obchodníka       |
| `identificationNumber` | `string`          | IČO                            |
| `taxNumber`            | `string`          | DIČ                            |
| `iban`                 | `string`          | IBAN bankovního účtu           |

---

## 3. Pay Points

Pay point představuje platební místo (virtuální, NFC terminál nebo fyzický terminál).

### POST `/payment/api/pay-points`

Vytvoření nového pay pointu.

**Request Body** — `CreatePayPointRequest`:

| Pole                  | Typ              | Povinné | Popis                          |
|-----------------------|------------------|---------|--------------------------------|
| `name`                | `string`         | ne      | Název pay pointu               |
| `description`         | `string`         | ne      | Popis pay pointu               |
| `externalID`          | `string`         | ne      | Externí identifikátor          |
| `nfcCardNo`           | `string`         | ne      | Číslo NFC karty                |
| `type`                | `PayPointType`   | ano     | Typ: `Virtual`, `NFC`, `Terminal` |
| `productID`           | `int32`          | ne      | ID přiřazeného produktu        |
| `facilityPublicID`    | `guid`           | ne      | ID přiřazené provozovny        |
| `bankAccountPublicID` | `guid`           | ne      | ID přiřazeného bankovního účtu |
| `employeePublicIDs`   | `guid[]`         | ne      | ID přiřazených zaměstnanců     |

**Odpovědi:**

| Kód | Typ                 | Popis                    |
|-----|---------------------|--------------------------|
| 200 | `PayPointDto`       | Vytvořený pay point      |
| 403 | `ApiProblemDetails`  | Přístup zamítnut         |

---

### GET `/payment/api/pay-points`

Seznam všech pay pointů s podporou stránkování.

**Query parametry:**

| Parametr | Typ     | Povinné | Popis             |
|----------|---------|---------|--------------------|
| `offset` | `int32` | ne      | Posun stránkování  |
| `limit`  | `int32` | ne      | Počet záznamů      |

**Odpovědi:**

| Kód | Typ                       | Popis                    |
|-----|---------------------------|--------------------------|
| 200 | `EntityListOfPayPointDto` | Stránkovaný seznam       |
| 404 | `ApiProblemDetails`       | Nenalezeno               |

**Schéma odpovědi** — `EntityListOfPayPointDto`:

| Pole         | Typ             | Popis                    |
|--------------|-----------------|--------------------------|
| `offset`     | `int32`         | Aktuální posun           |
| `limit`      | `int32`         | Počet záznamů na stránku |
| `totalCount` | `int32`         | Celkový počet záznamů    |
| `items`      | `PayPointDto[]` | Seznam pay pointů        |

---

### GET `/payment/api/pay-points/{publicID}`

Získání detailu konkrétního pay pointu.

**Path parametry:**

| Parametr   | Typ    | Povinné | Popis                          |
|------------|--------|---------|--------------------------------|
| `publicID` | `guid` | ano     | Veřejný identifikátor pay pointu |

**Odpovědi:**

| Kód | Typ                 | Popis                    |
|-----|---------------------|--------------------------|
| 200 | `PayPointDto`       | Detail pay pointu        |
| 404 | `ApiProblemDetails`  | Pay point nenalezen      |

---

### PUT `/payment/api/pay-points/{publicID}`

Aktualizace existujícího pay pointu.

**Path parametry:**

| Parametr   | Typ      | Povinné | Popis                          |
|------------|----------|---------|--------------------------------|
| `publicID` | `string` | ano     | Veřejný identifikátor pay pointu |

**Request Body** — `UpdatePayPointRequest`:

| Pole                  | Typ              | Povinné | Popis                          |
|-----------------------|------------------|---------|--------------------------------|
| `publicID`            | `guid`           | ano     | Veřejný identifikátor          |
| `name`                | `string`         | ne      | Název pay pointu               |
| `description`         | `string`         | ne      | Popis pay pointu               |
| `nfcCardNo`           | `string`         | ne      | Číslo NFC karty                |
| `type`                | `PayPointType`   | ano     | Typ pay pointu                 |
| `facilityPublicID`    | `guid`           | ne      | ID přiřazené provozovny        |
| `bankAccountPublicID` | `guid`           | ne      | ID přiřazeného bankovního účtu |
| `employeePublicIDs`   | `guid[]`         | ne      | ID přiřazených zaměstnanců     |

**Odpovědi:**

| Kód | Typ                 | Popis                    |
|-----|---------------------|--------------------------|
| 200 | `PayPointDto`       | Aktualizovaný pay point  |
| 403 | `ApiProblemDetails`  | Přístup zamítnut         |

---

### GET `/external/{externalID}`

Získání pay pointu podle externího identifikátoru.

**Path parametry:**

| Parametr     | Typ      | Povinné | Popis                |
|--------------|----------|---------|----------------------|
| `externalID` | `string` | ano     | Externí identifikátor |

**Odpovědi:**

| Kód | Typ                 | Popis                    |
|-----|---------------------|--------------------------|
| 200 | `PayPointDto`       | Detail pay pointu        |
| 404 | `ApiProblemDetails`  | Pay point nenalezen      |

---

### Schéma — `PayPointDto`

| Pole                  | Typ              | Popis                          |
|-----------------------|------------------|--------------------------------|
| `publicID`            | `guid`           | Veřejný identifikátor          |
| `name`                | `string`         | Název pay pointu               |
| `description`         | `string`         | Popis pay pointu               |
| `partyPublicID`       | `guid`           | ID přiřazené strany            |
| `nfcCardNo`           | `string`         | Číslo NFC karty                |
| `type`                | `PayPointType`   | Typ: `Virtual`, `NFC`, `Terminal` |
| `externalID`          | `string`         | Externí identifikátor          |
| `productID`           | `int32`          | ID přiřazeného produktu        |
| `facilityPublicID`    | `guid`           | ID přiřazené provozovny        |
| `bankAccountPublicID` | `guid`           | ID přiřazeného bankovního účtu |
| `employeePublicIDs`   | `guid[]`         | ID přiřazených zaměstnanců     |

---

## 4. Transakce

Transakce využívají interní identifikátory systému (publicID).

### POST `/payment/api/transactions/initiate`

Iniciace nové transakce.

**Request Body** — `TransactionInitiateRequest`:

| Pole               | Typ                    | Povinné | Popis                                    |
|--------------------|------------------------|---------|------------------------------------------|
| `payPointPublicID` | `guid`                 | ne      | Veřejný identifikátor pay pointu         |
| `callbackUrl`      | `string`               | ne      | URL pro notifikace o změně stavu transakce |
| `amount`           | `decimal`              | ano     | Částka transakce                          |
| `currencyCode`     | `Iso4217CurrencyCode`  | ano     | Kód měny dle ISO 4217 (aktuálně jen `CZK`) |

**Odpovědi:**

| Kód | Typ                            | Popis                    |
|-----|--------------------------------|--------------------------|
| 200 | `InitiateTransactionResponse`  | Iniciovaná transakce     |
| 400 | `ApiProblemDetails`            | Neplatný požadavek       |
| 404 | `ApiProblemDetails`            | Nenalezeno               |

**Schéma odpovědi** — `InitiateTransactionResponse`:

| Pole          | Typ                    | Popis            |
|---------------|------------------------|------------------|
| `transaction` | `PublicTransactionDto` | Detail transakce |

**Schéma** — `PublicTransactionDto`:

| Pole               | Typ                    | Popis                                  |
|--------------------|------------------------|----------------------------------------|
| `publicID`         | `string`               | Veřejný identifikátor transakce        |
| `amount`           | `decimal`              | Částka transakce                        |
| `currencyCode`     | `Iso4217CurrencyCode`  | Kód měny                               |
| `payPointPublicID` | `guid`                 | ID přiřazeného pay pointu              |
| `redirectUrl`      | `string`               | URL pro přesměrování uživatele k platbě |

---

### GET `/payment/api/transactions/{publicID}/status`

Získání aktuálního stavu transakce.

**Path parametry:**

| Parametr   | Typ      | Povinné | Popis                             |
|------------|----------|---------|-----------------------------------|
| `publicID` | `string` | ano     | Veřejný identifikátor transakce   |

**Odpovědi:**

| Kód | Typ                          | Popis                    |
|-----|------------------------------|--------------------------|
| 200 | `TransactionStatusResponse`  | Stav transakce           |
| 404 | `ApiProblemDetails`          | Transakce nenalezena     |
| 403 | `ApiProblemDetails`          | Přístup zamítnut         |

**Schéma odpovědi** — `TransactionStatusResponse`:

| Pole               | Typ                    | Popis                          |
|--------------------|------------------------|--------------------------------|
| `publicID`         | `string`               | Veřejný identifikátor transakce |
| `payPointPublicID` | `guid`                 | ID přiřazeného pay pointu      |
| `amount`           | `decimal`              | Částka transakce                |
| `currencyCode`     | `Iso4217CurrencyCode`  | Kód měny                       |
| `status`           | `TransactionStatus`    | Aktuální stav transakce        |

---

### PUT `/payment/api/transactions/{publicID}/cancel`

Zrušení transakce.

**Path parametry:**

| Parametr   | Typ      | Povinné | Popis                             |
|------------|----------|---------|-----------------------------------|
| `publicID` | `string` | ano     | Veřejný identifikátor transakce   |

**Odpovědi:**

| Kód | Typ                          | Popis                    |
|-----|------------------------------|--------------------------|
| 200 | `TransactionCancelResponse`  | Potvrzení zrušení        |
| 403 | `ApiProblemDetails`          | Přístup zamítnut         |
| 404 | `ApiProblemDetails`          | Transakce nenalezena     |

**Schéma odpovědi** — `TransactionCancelResponse`:

Shodné s `TransactionStatusResponse`.

---

## 5. Transakce — externí identifikátory

Varianta transakčních endpointů pro systémy používající vlastní (externí) identifikátory.

### POST `/payment/api/transactions/external/initiate`

Iniciace transakce s externími identifikátory.

**Request Body** — `TransactionInitiateRequestExternal`:

| Pole                     | Typ                    | Povinné | Popis                                          |
|--------------------------|------------------------|---------|-------------------------------------------------|
| `externalTransactionID`  | `guid`                 | ano     | Vlastní unikátní identifikátor transakce        |
| `externalMerchantID`     | `string`               | ne      | Externí ID obchodníka (pro impersonaci)         |
| `externalPayPointID`     | `string`               | ano     | Externí identifikátor pay pointu                |
| `amount`                 | `decimal`              | ano     | Částka transakce                                 |
| `currencyCode`           | `Iso4217CurrencyCode`  | ano     | Kód měny dle ISO 4217                           |

**Odpovědi:**

| Kód | Typ                                    | Popis                    |
|-----|----------------------------------------|--------------------------|
| 200 | `InitiateTransactionResponseExternal`  | Iniciovaná transakce     |
| 400 | `ApiProblemDetails`                    | Neplatný požadavek       |
| 404 | `ApiProblemDetails`                    | Nenalezeno               |

**Schéma odpovědi** — `InitiateTransactionResponseExternal`:

| Pole          | Typ                            | Popis            |
|---------------|--------------------------------|------------------|
| `transaction` | `PublicTransactionDtoExternal` | Detail transakce |

**Schéma** — `PublicTransactionDtoExternal`:

| Pole                     | Typ                    | Popis                          |
|--------------------------|------------------------|--------------------------------|
| `externalTransactionID`  | `guid`                 | Externí identifikátor transakce |
| `amount`                 | `decimal`              | Částka transakce                |
| `currencyCode`           | `Iso4217CurrencyCode`  | Kód měny                       |
| `externalPayPointID`     | `string`               | Externí ID pay pointu          |

---

### GET `/payment/api/transactions/external/{externalID}/status`

Získání stavu transakce podle externího identifikátoru.

**Path parametry:**

| Parametr     | Typ    | Povinné | Popis                             |
|--------------|--------|---------|-----------------------------------|
| `externalID` | `guid` | ano     | Externí identifikátor transakce   |

**Odpovědi:**

| Kód | Typ                                  | Popis                    |
|-----|--------------------------------------|--------------------------|
| 200 | `TransactionStatusResponseExternal`  | Stav transakce           |
| 404 | `ApiProblemDetails`                  | Transakce nenalezena     |
| 403 | `ApiProblemDetails`                  | Přístup zamítnut         |

**Schéma odpovědi** — `TransactionStatusResponseExternal`:

| Pole                 | Typ                    | Popis                          |
|----------------------|------------------------|--------------------------------|
| `externalID`         | `guid`                 | Externí identifikátor transakce |
| `externalPayPointID` | `string`               | Externí ID pay pointu          |
| `amount`             | `decimal`              | Částka transakce                |
| `currencyCode`       | `Iso4217CurrencyCode`  | Kód měny                       |
| `status`             | `TransactionStatus`    | Aktuální stav transakce        |

---

### PUT `/payment/api/transactions/external/{externalID}/cancel`

Zrušení transakce podle externího identifikátoru.

**Path parametry:**

| Parametr     | Typ    | Povinné | Popis                             |
|--------------|--------|---------|-----------------------------------|
| `externalID` | `guid` | ano     | Externí identifikátor transakce   |

**Odpovědi:**

| Kód | Typ                                  | Popis                    |
|-----|--------------------------------------|--------------------------|
| 200 | `TransactionCancelResponseExternal`  | Potvrzení zrušení        |
| 403 | `ApiProblemDetails`                  | Přístup zamítnut         |
| 404 | `ApiProblemDetails`                  | Transakce nenalezena     |

**Schéma odpovědi** — `TransactionCancelResponseExternal`:

| Pole                 | Typ                    | Popis                          |
|----------------------|------------------------|--------------------------------|
| `externalID`         | `guid`                 | Externí identifikátor transakce |
| `externalPayPointID` | `string`               | Externí ID pay pointu          |
| `amount`             | `decimal`              | Částka transakce                |
| `currencyCode`       | `Iso4217CurrencyCode`  | Kód měny                       |
| `status`             | `TransactionStatus`    | Aktuální stav transakce        |

---

## 6. Schémata

### PublicSignInCommand

| Pole       | Typ      | Nullable | Popis                          |
|------------|----------|----------|--------------------------------|
| `login`    | `string` | ne       | Přihlašovací jméno             |
| `password` | `string` | ne       | Heslo uživatele                |

### SignInResult

| Pole             | Typ           | Nullable | Popis                          |
|------------------|---------------|----------|--------------------------------|
| `token`          | `string`      | ano      | JWT autentizační token         |
| `userStatus`     | `UserStatus`  | ne       | Stav uživatele                 |
| `partyPublicID`  | `guid`        | ne       | Veřejný ID strany              |
| `login`          | `string`      | ano      | Přihlašovací jméno             |
| `firstName`      | `string`      | ano      | Křestní jméno                  |
| `lastName`       | `string`      | ano      | Příjmení                       |

### MerchantPublicDetailDto

| Pole                   | Typ               | Nullable | Popis                          |
|------------------------|--------------------|----------|--------------------------------|
| `publicID`             | `guid`            | ne       | Veřejný identifikátor          |
| `externalID`           | `string`          | ne       | Externí identifikátor          |
| `status`               | `MerchantStatus`  | ne       | Stav obchodníka                |
| `identificationNumber` | `string`          | ano      | IČO                            |
| `taxNumber`            | `string`          | ano      | DIČ                            |
| `iban`                 | `string`          | ano      | IBAN                           |

### PayPointDto

| Pole                  | Typ              | Nullable | Popis                          |
|-----------------------|------------------|----------|--------------------------------|
| `publicID`            | `guid`           | ne       | Veřejný identifikátor          |
| `name`                | `string`         | ano      | Název                          |
| `description`         | `string`         | ano      | Popis                          |
| `partyPublicID`       | `guid`           | ne       | ID strany                      |
| `nfcCardNo`           | `string`         | ano      | Číslo NFC karty                |
| `type`                | `PayPointType`   | ne       | Typ pay pointu                 |
| `externalID`          | `string`         | ano      | Externí identifikátor          |
| `productID`           | `int32`          | ano      | ID produktu                    |
| `facilityPublicID`    | `guid`           | ano      | ID provozovny                  |
| `bankAccountPublicID` | `guid`           | ano      | ID bankovního účtu             |
| `employeePublicIDs`   | `guid[]`         | ano      | ID zaměstnanců                 |

### CreatePayPointRequest

| Pole                  | Typ              | Nullable | Popis                          |
|-----------------------|------------------|----------|--------------------------------|
| `name`                | `string`         | ano      | Název                          |
| `description`         | `string`         | ano      | Popis                          |
| `externalID`          | `string`         | ano      | Externí identifikátor          |
| `nfcCardNo`           | `string`         | ano      | Číslo NFC karty                |
| `type`                | `PayPointType`   | **ne**   | Typ pay pointu                 |
| `productID`           | `int32`          | ano      | ID produktu                    |
| `facilityPublicID`    | `guid`           | ano      | ID provozovny                  |
| `bankAccountPublicID` | `guid`           | ano      | ID bankovního účtu             |
| `employeePublicIDs`   | `guid[]`         | ano      | ID zaměstnanců                 |

### UpdatePayPointRequest

| Pole                  | Typ              | Nullable | Popis                          |
|-----------------------|------------------|----------|--------------------------------|
| `publicID`            | `guid`           | **ne**   | Veřejný identifikátor          |
| `name`                | `string`         | ano      | Název                          |
| `description`         | `string`         | ano      | Popis                          |
| `nfcCardNo`           | `string`         | ano      | Číslo NFC karty                |
| `type`                | `PayPointType`   | **ne**   | Typ pay pointu                 |
| `facilityPublicID`    | `guid`           | ano      | ID provozovny                  |
| `bankAccountPublicID` | `guid`           | ano      | ID bankovního účtu             |
| `employeePublicIDs`   | `guid[]`         | ano      | ID zaměstnanců                 |

### EntityListOfPayPointDto

| Pole         | Typ             | Nullable | Popis                    |
|--------------|-----------------|----------|--------------------------|
| `offset`     | `int32`         | ne       | Posun stránkování        |
| `limit`      | `int32`         | ne       | Počet na stránku         |
| `totalCount` | `int32`         | ne       | Celkový počet            |
| `items`      | `PayPointDto[]` | ano      | Seznam pay pointů        |

### PublicTransactionDto

| Pole               | Typ                    | Nullable | Popis                                  |
|--------------------|------------------------|----------|----------------------------------------|
| `publicID`         | `string`               | ne       | Veřejný identifikátor transakce        |
| `amount`           | `decimal`              | ne       | Částka                                  |
| `currencyCode`     | `Iso4217CurrencyCode`  | ne       | Kód měny                               |
| `payPointPublicID` | `guid`                 | ano      | ID pay pointu                          |
| `redirectUrl`      | `string`               | ano      | URL pro přesměrování k platbě          |

### TransactionInitiateRequest

| Pole               | Typ                    | Nullable | Popis                                    |
|--------------------|------------------------|----------|------------------------------------------|
| `payPointPublicID` | `guid`                 | ano      | ID pay pointu                            |
| `callbackUrl`      | `string`               | ano      | URL pro notifikace o stavu               |
| `amount`           | `decimal`              | **ne**   | Částka transakce                          |
| `currencyCode`     | `Iso4217CurrencyCode`  | **ne**   | Kód měny                                 |

### InitiateTransactionResponse

| Pole          | Typ                    | Nullable | Popis            |
|---------------|------------------------|----------|------------------|
| `transaction` | `PublicTransactionDto` | ano      | Detail transakce |

### TransactionStatusResponse

| Pole               | Typ                    | Nullable | Popis                          |
|--------------------|------------------------|----------|--------------------------------|
| `publicID`         | `string`               | ne       | Veřejný identifikátor          |
| `payPointPublicID` | `guid`                 | ano      | ID pay pointu                  |
| `amount`           | `decimal`              | ne       | Částka                          |
| `currencyCode`     | `Iso4217CurrencyCode`  | ne       | Kód měny                       |
| `status`           | `TransactionStatus`    | ne       | Stav transakce                 |

### TransactionCancelResponse

Shodné s `TransactionStatusResponse`.

### PublicTransactionDtoExternal

| Pole                     | Typ                    | Nullable | Popis                          |
|--------------------------|------------------------|----------|--------------------------------|
| `externalTransactionID`  | `guid`                 | ne       | Externí ID transakce           |
| `amount`                 | `decimal`              | ne       | Částka                          |
| `currencyCode`           | `Iso4217CurrencyCode`  | ne       | Kód měny                       |
| `externalPayPointID`     | `string`               | ne       | Externí ID pay pointu          |

### TransactionInitiateRequestExternal

| Pole                     | Typ                    | Nullable | Popis                                    |
|--------------------------|------------------------|----------|------------------------------------------|
| `externalTransactionID`  | `guid`                 | **ne**   | Vlastní unikátní ID transakce            |
| `externalMerchantID`     | `string`               | ano      | Externí ID obchodníka (impersonace)      |
| `externalPayPointID`     | `string`               | **ne**   | Externí ID pay pointu                    |
| `amount`                 | `decimal`              | **ne**   | Částka transakce                          |
| `currencyCode`           | `Iso4217CurrencyCode`  | **ne**   | Kód měny                                 |

### InitiateTransactionResponseExternal

| Pole          | Typ                            | Nullable | Popis            |
|---------------|--------------------------------|----------|------------------|
| `transaction` | `PublicTransactionDtoExternal` | ano      | Detail transakce |

### TransactionStatusResponseExternal

| Pole                 | Typ                    | Nullable | Popis                          |
|----------------------|------------------------|----------|--------------------------------|
| `externalID`         | `guid`                 | ne       | Externí ID transakce           |
| `externalPayPointID` | `string`               | ne       | Externí ID pay pointu          |
| `amount`             | `decimal`              | ne       | Částka                          |
| `currencyCode`       | `Iso4217CurrencyCode`  | ne       | Kód měny                       |
| `status`             | `TransactionStatus`    | ne       | Stav transakce                 |

### TransactionCancelResponseExternal

| Pole                 | Typ                    | Nullable | Popis                          |
|----------------------|------------------------|----------|--------------------------------|
| `externalID`         | `guid`                 | ano      | Externí ID transakce           |
| `externalPayPointID` | `string`               | ne       | Externí ID pay pointu          |
| `amount`             | `decimal`              | ne       | Částka                          |
| `currencyCode`       | `Iso4217CurrencyCode`  | ne       | Kód měny                       |
| `status`             | `TransactionStatus`    | ne       | Stav transakce                 |

---

## 7. Enumerace

### UserStatus

| Hodnota                         | Popis                                    |
|---------------------------------|------------------------------------------|
| `Unknown`                       | Neznámý stav                             |
| `InvitedWaitingForConfirmation` | Pozván, čeká na potvrzení                |
| `Active`                        | Aktivní uživatel                         |
| `WaitingForEmailConfirmation`   | Čeká na potvrzení e-mailu                |
| `Deactivated`                   | Deaktivovaný účet                        |
| `BlockedFinances`               | Blokován z finančních důvodů             |
| `Anonymous`                     | Anonymní uživatel                        |
| `Onboarding`                    | V procesu registrace                     |
| `EmailConfirmed`                | E-mail potvrzen                          |
| `RoleSelection`                 | Výběr role                               |

### MerchantStatus

| Hodnota                         | Popis                                    |
|---------------------------------|------------------------------------------|
| `InDraft`                       | Rozpracovaný                             |
| `InvitedWaitingForConfirmation` | Pozván, čeká na potvrzení                |
| `Onboarding`                    | V procesu registrace                     |
| `WaitingForPaymentTerminal`     | Čeká na platební terminál                |
| `Active`                        | Aktivní obchodník                        |
| `BlockedFinancialServices`      | Blokované finanční služby                |

### PayPointType

| Hodnota    | Popis                    |
|------------|--------------------------|
| `Virtual`  | Virtuální platební místo |
| `NFC`      | NFC terminál             |
| `Terminal` | Fyzický terminál         |

### TransactionStatus

| Hodnota               | Popis                                    |
|-----------------------|------------------------------------------|
| `Created`             | Transakce vytvořena                      |
| `Initiated`           | Transakce zahájena                       |
| `Processing`          | Probíhá zpracování                       |
| `Success`             | Úspěšně dokončena                        |
| `Fail`                | Selhala                                  |
| `Cancelled`           | Zrušena                                  |
| `InvestigationNeeded` | Vyžaduje prošetření                      |

### Iso4217CurrencyCode

| Hodnota | Popis        |
|---------|--------------|
| `CZK`   | Česká koruna |

### ErrorCode

| Hodnota                        | Popis                                    |
|--------------------------------|------------------------------------------|
| `Unspecified`                  | Nespecifikovaná chyba                    |
| `OutOfRange`                   | Hodnota mimo povolený rozsah             |
| `NotFound`                     | Zdroj nenalezen                          |
| `Invalid`                      | Neplatná hodnota                         |
| `Forbidden`                    | Přístup zamítnut                         |
| `TooManyRequests`              | Příliš mnoho požadavků                   |
| `Conflict`                     | Konflikt (duplicita)                     |
| `NullOrEmpty`                  | Prázdná nebo null hodnota                |
| `Unauthorized`                 | Neautorizovaný přístup                   |
| `ExternalProviderNotAvailable` | Externí poskytovatel nedostupný          |
| `InternalError`                | Interní chyba serveru                    |
| `ExternalServiceError`         | Chyba externího serveru                  |

---

## 8. Chybové odpovědi

Všechny chybové odpovědi používají schéma `ApiProblemDetails` (rozšíření RFC 7807 ProblemDetails).

### ProblemDetails (základ)

| Pole         | Typ      | Popis                              |
|--------------|----------|------------------------------------|
| `type`       | `string` | URI identifikující typ chyby       |
| `title`      | `string` | Stručný název chyby                |
| `status`     | `int32`  | HTTP stavový kód                   |
| `detail`     | `string` | Podrobný popis chyby               |
| `instance`   | `string` | URI konkrétní instance chyby       |
| `extensions` | `object` | Další vlastní vlastnosti            |

### ApiProblemDetails (rozšíření)

Dědí z `ProblemDetails` a přidává:

| Pole     | Typ                              | Popis                                  |
|----------|----------------------------------|----------------------------------------|
| `errors` | `object<string, ErrorDetail[]>`  | Mapa: název pole → seznam chyb         |

### ErrorDetail

| Pole      | Typ         | Popis                    |
|-----------|-------------|--------------------------|
| `code`    | `ErrorCode` | Klasifikační kód chyby   |
| `message` | `string`    | Lidsky čitelná zpráva    |

**Příklad chybové odpovědi:**

```json
{
  "type": "https://tools.ietf.org/html/rfc7231#section-6.5.1",
  "title": "Bad Request",
  "status": 400,
  "detail": null,
  "instance": "/payment/api/transactions/initiate",
  "errors": {
    "amount": [
      {
        "code": "OutOfRange",
        "message": "Amount must be greater than 0."
      }
    ],
    "currencyCode": [
      {
        "code": "Invalid",
        "message": "Unsupported currency code."
      }
    ]
  }
}
```
