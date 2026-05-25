# Sushi Garden Flutter App Implementation Plan

**Goal:** Build a Flutter/Dart Sushi Garden mobile app matching the Figma design `Error Nil. Apps`, node `1:6`.

**Architecture:** Create a new Flutter app with a feature-first `lib/features/*` structure, Riverpod for state, GoRouter for navigation, freezed/json_serializable for models, and local fake repositories first. The first milestone is pixel-faithful static screens from Figma, followed by cart/checkout/auth behavior and then persistence/API seams.

**Tech Stack:** Flutter 3.x, Dart, Riverpod, GoRouter, flutter_svg, cached_network_image, google_fonts using Sen, mocktail, golden_toolkit, flutter_test, integration_test.

---

## Figma Scope Checked

Source: `https://www.figma.com/design/wOK1MMzuJZF3pIOZhGHpY9/Error-Nil.-Apps?node-id=1-6`

Figma file metadata:
- File name: `Error Nil. Apps`
- Last modified: `2026-01-08T17:08:11Z`
- Access role: viewer
- Canvas node: `1:6`, named `App1`

Screens to implement:
- `1:3790` `Старт`, 430x932: splash logo on black background.
- `1:1306` `Главная`, 430x932: catalog grid, address header, categories, bottom nav.
- `1:3094` `Главная (1)`, 430x932: catalog with selected item quantity controls.
- `1:3172` `Главная (2)`, 430x932: product detail for `Хикари`, description, price, quantity controls.
- `1:3221` `Акции`, 430x932: promo categories `Постное меню`, `Сеты`.
- `1:3270` `Заказы`, 430x932: order tracking, courier, delivery time.
- `1:3355` `Корзина`, 430x1029: cart items, add-ons, total, checkout CTA.
- `1:3471` `Корзина (1)`, 430x932: checkout form, address, payment, totals.
- `1:3521` `Профиль`, 430x932: profile, cards, order history, logout.
- `1:3594` `Войти`, 430x932: login form.
- `1:3616` `Регистрация`, 430x932: registration form and terms checkbox.

Design tokens observed:
- Canvas size: 430 x 932, iPhone-style portrait.
- Typography: `Sen` is primary; Figma also contains a few `Inter` labels outside app frames.
- Background: near-black `#0F0F0F`; card/dark surfaces around `#29282C`; text white and muted grays.
- Primary style definitions include `#3334CC` and `#F5F5FF`, but the Sushi Garden frames mostly use the dark food-ordering palette.
- Grid: 5 columns, 60px columns, 20px gutters, 25px offset.
- Reusable icon component set includes shopping bag, receipt, location marker, phone, clipboard, cook, delivery, check circle, trash, plus, minus, credit card, logout, user.

## Assumptions

- Target repo path: `/Users/baha/Desktop/llm-ai-projects/sushi-garden-flutter`.
- Flutter is not currently installed on this machine; install Flutter before executing the implementation plan.
- First implementation uses local fake data and image assets exported from Figma, then can swap to Firebase/API later.
- Russian copy should match Figma exactly for the first release.
- Product images should be exported from Figma into `assets/images/products/`; no placeholder food images should ship.

## Project Structure

```text
/Users/baha/Desktop/llm-ai-projects/sushi-garden-flutter/
  pubspec.yaml
  analysis_options.yaml
  assets/
    images/
      logo/
      products/
      promos/
  lib/
    main.dart
    app/
      app.dart
      router.dart
      theme.dart
    core/
      formatters/money_formatter.dart
      widgets/bottom_nav.dart
      widgets/primary_button.dart
      widgets/quantity_stepper.dart
    data/
      fake_catalog.dart
      fake_orders.dart
    features/
      auth/
      cart/
      catalog/
      checkout/
      orders/
      profile/
      splash/
  test/
    core/
    features/
  integration_test/
```

## Task 1: Bootstrap Flutter Project

**Files:**
- Create: `/Users/baha/Desktop/llm-ai-projects/sushi-garden-flutter/pubspec.yaml`
- Create: `/Users/baha/Desktop/llm-ai-projects/sushi-garden-flutter/analysis_options.yaml`
- Create: `/Users/baha/Desktop/llm-ai-projects/sushi-garden-flutter/lib/main.dart`

**Step 1: Install Flutter**

Install Flutter SDK and confirm:

```bash
flutter --version
flutter doctor
```

Expected: Flutter command exists and doctor can run.

**Step 2: Create project**

```bash
cd /Users/baha/Desktop/llm-ai-projects
flutter create sushi-garden-flutter --platforms=ios,android
```

Expected: Flutter app scaffold exists.

**Step 3: Add dependencies**

Update `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cached_network_image: ^3.4.1
  flutter_riverpod: ^2.6.1
  flutter_svg: ^2.0.17
  go_router: ^14.8.1
  google_fonts: ^6.2.1
  intl: ^0.20.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  flutter_lints: ^5.0.0
  golden_toolkit: ^0.15.0
  mocktail: ^1.0.4
```

Run:

```bash
flutter pub get
flutter test
```

Expected: dependencies resolve and default tests pass.

## Task 2: Theme and Design Tokens

**Files:**
- Create: `lib/app/theme.dart`
- Test: `test/app/theme_test.dart`

**Step 1: Write failing tests**

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

void main() {
  test('SushiColors exposes Figma dark palette', () {
    expect(SushiColors.background, const Color(0xFF0F0F0F));
    expect(SushiColors.surface, const Color(0xFF29282C));
    expect(SushiColors.textPrimary, Colors.white);
    expect(SushiColors.textMuted, const Color(0xFF878787));
  });
}
```

**Step 2: Run failing test**

```bash
flutter test test/app/theme_test.dart
```

Expected: FAIL because `theme.dart` does not exist.

**Step 3: Implement tokens**

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class SushiColors {
  static const background = Color(0xFF0F0F0F);
  static const surface = Color(0xFF29282C);
  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFF878787);
  static const divider = Color(0xFF333333);
  static const field = Color(0xFFF5F5FF);
}

ThemeData buildSushiTheme() {
  final textTheme = GoogleFonts.senTextTheme();
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: SushiColors.background,
    colorScheme: const ColorScheme.dark(
      surface: SushiColors.surface,
      primary: SushiColors.textPrimary,
    ),
    textTheme: textTheme.apply(
      bodyColor: SushiColors.textPrimary,
      displayColor: SushiColors.textPrimary,
    ),
  );
}
```

**Step 4: Verify**

```bash
flutter test test/app/theme_test.dart
```

Expected: PASS.

## Task 3: Domain Models and Fake Data

**Files:**
- Create: `lib/features/catalog/catalog_models.dart`
- Create: `lib/data/fake_catalog.dart`
- Test: `test/features/catalog/catalog_models_test.dart`

**Step 1: Write tests**

Cover products visible in Figma:
- `Хикари`, `620 ₽`, `255 г`
- `Лос-Анджелес`, `707 ₽`, `285 г`
- `Осака маки`, `740 ₽`, `275 г`
- `Айдахо маки`, `810 ₽`, `285 г`

**Step 2: Implement**

Create immutable Dart classes:
- `Product`
- `ProductCategory`
- `Promo`
- `CartLine`
- `AddOn`
- `Order`
- `UserProfile`

Use plain Dart classes first; add generated models only if API persistence becomes real.

**Step 3: Verify**

```bash
flutter test test/features/catalog/catalog_models_test.dart
```

Expected: product catalog and price/weight assertions pass.

## Task 4: Navigation Shell

**Files:**
- Create: `lib/app/app.dart`
- Create: `lib/app/router.dart`
- Create: `lib/core/widgets/bottom_nav.dart`
- Test: `test/app/router_test.dart`

**Routes:**
- `/splash`
- `/catalog`
- `/catalog/product/:id`
- `/promos`
- `/orders`
- `/cart`
- `/checkout`
- `/profile`
- `/login`
- `/register`

**Step 1: Test route names and initial route**

Expected initial route: `/splash`, then app moves to `/catalog`.

**Step 2: Implement GoRouter**

Use named routes and a shared bottom navigation shell for:
- `Каталог`
- `Акции`
- `Заказы`
- `Корзина`
- `Профиль`

**Step 3: Verify**

```bash
flutter test test/app/router_test.dart
```

Expected: route table test passes.

## Task 5: Catalog Screen

**Files:**
- Create: `lib/features/catalog/catalog_screen.dart`
- Create: `lib/features/catalog/widgets/product_card.dart`
- Test: `test/features/catalog/catalog_screen_test.dart`

**Step 1: Test visible copy**

Assert screen contains:
- `Доставка по адресу:`
- `Воронеж, Мира 36`
- categories `Роллы`, `Суши`, `Горячие роллы`, `Салаты`, `WOK`
- product cards and ruble prices

**Step 2: Implement layout**

Use:
- 430px design reference but responsive width.
- 2-column product grid.
- product image aspect ratio near Figma card image.
- dark price pill with 12px radius.
- bottom navigation fixed.

**Step 3: Verify**

```bash
flutter test test/features/catalog/catalog_screen_test.dart
```

Expected: all copy and product card tests pass.

## Task 6: Product Detail and Cart State

**Files:**
- Create: `lib/features/catalog/product_detail_screen.dart`
- Create: `lib/features/cart/cart_controller.dart`
- Create: `lib/core/widgets/quantity_stepper.dart`
- Test: `test/features/cart/cart_controller_test.dart`
- Test: `test/features/catalog/product_detail_screen_test.dart`

**Acceptance Criteria:**
- Product detail shows `Описание`, full Hikari description, `620 ₽`.
- `+` adds quantity.
- `-` decrements and removes at zero.
- Cart state calculates item count, grams, and total.

**Verification:**

```bash
flutter test test/features/cart/cart_controller_test.dart
flutter test test/features/catalog/product_detail_screen_test.dart
```

## Task 7: Promos, Orders, and Profile

**Files:**
- Create: `lib/features/promos/promos_screen.dart`
- Create: `lib/features/orders/orders_screen.dart`
- Create: `lib/features/profile/profile_screen.dart`
- Test: `test/features/promos/promos_screen_test.dart`
- Test: `test/features/orders/orders_screen_test.dart`
- Test: `test/features/profile/profile_screen_test.dart`

**Acceptance Criteria:**
- Promos screen shows `Постное меню`, `Сеты`.
- Orders screen shows courier `Максим Винокур`, `Курьер будет в 22:10`.
- Profile screen shows `Александр Новиков`, `anovikov@gmail.com`, `888333777`, order history, `Выйти`.

**Verification:**

```bash
flutter test test/features/promos test/features/orders test/features/profile
```

## Task 8: Cart and Checkout

**Files:**
- Create: `lib/features/cart/cart_screen.dart`
- Create: `lib/features/checkout/checkout_screen.dart`
- Create: `lib/features/checkout/checkout_controller.dart`
- Test: `test/features/checkout/checkout_controller_test.dart`
- Test: `test/features/cart/cart_screen_test.dart`
- Test: `test/features/checkout/checkout_screen_test.dart`

**Acceptance Criteria:**
- Cart screen shows `3 позиции / 630 г`, add-ons `Васаби`, `Имбирь`, `Соевый соус`, total `1 820 ₽`.
- Checkout screen shows fields for name, phone, email, address details.
- Confirm button is disabled until required fields are valid.
- Totals show order sum, service fee, delivery, and final total.

**Verification:**

```bash
flutter test test/features/cart test/features/checkout
```

## Task 9: Auth Screens

**Files:**
- Create: `lib/features/auth/login_screen.dart`
- Create: `lib/features/auth/register_screen.dart`
- Create: `lib/features/auth/auth_controller.dart`
- Test: `test/features/auth/auth_controller_test.dart`
- Test: `test/features/auth/auth_screen_test.dart`

**Acceptance Criteria:**
- Login screen matches `Войти`: email, password, button, registration link.
- Registration screen matches `Регистрация`: name, email, password, terms checkbox.
- Login/register validation blocks invalid email and empty password.

**Verification:**

```bash
flutter test test/features/auth
```

## Task 10: Figma Asset Export and Golden Tests

**Files:**
- Create assets under `assets/images/`
- Create: `test/goldens/sushi_garden_goldens_test.dart`

**Step 1: Export assets**

Use Figma MCP after Codex restart, or Figma REST images endpoint, to export:
- logo from `Старт`
- product images from catalog cards
- promo imagery
- icon SVGs if not represented by Flutter icons

**Step 2: Register assets**

Add to `pubspec.yaml`:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/images/logo/
    - assets/images/products/
    - assets/images/promos/
```

**Step 3: Add golden tests**

Create golden tests for:
- catalog
- product detail
- cart
- checkout
- login/register

Run:

```bash
flutter test --update-goldens
flutter test
```

Expected: goldens generated once, then stable on repeat runs.

## Task 11: Integration Smoke Test

**Files:**
- Create: `integration_test/app_smoke_test.dart`

**Flow:**
1. App opens splash.
2. Navigate to catalog.
3. Open `Хикари`.
4. Add item to cart.
5. Go to cart.
6. Continue to checkout.
7. Fill required fields.
8. Confirm order.
9. Navigate to orders.

Run:

```bash
flutter test integration_test/app_smoke_test.dart
```

Expected: full local happy path passes.

## Execution Order

1. Install Flutter and create the project.
2. Add theme/design tokens.
3. Add models and fake data.
4. Add router and app shell.
5. Build catalog and product detail.
6. Build cart state and checkout validation.
7. Build promos, orders, profile, auth.
8. Export Figma assets and replace temporary local assets.
9. Add golden tests.
10. Add integration smoke test.
11. Run full verification:

```bash
flutter analyze
flutter test
flutter test integration_test/app_smoke_test.dart
```

## Completion Criteria

- All Figma screens listed above have matching Flutter screens.
- No placeholder product images remain.
- All user-visible Russian labels match Figma.
- Cart and checkout calculations are tested.
- Auth validation is tested.
- Golden tests cover primary screens.
- `flutter analyze`, `flutter test`, and the integration smoke test pass.
