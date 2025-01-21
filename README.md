## 🛡️ Trust Bite - iOS and Android application

![Desktop](https://github.com/user-attachments/assets/44ed0553-c01c-4b9c-8fd9-8c191b1ff42f)

Trust Bite is an innovative mobile application built with Flutter, focusing on dietary safety and allergen management. Designed to revolutionize how users manage their food choices, Trust Bite provides a seamless and user-friendly experience powered by Firebase for authentication and push notifications. 🌱📱

### 🌟 Features

- **Authentication**
  - Login, register, verify email, reset password, log out, and delete account.
  - Secure authentication using Firebase Auth.
- **Allergen Management**
  - Scan products for allergens and get instant alerts.
  - Monitor allergens in scanned products for proactive dietary management.
- **Expiration Date Tracker**
  - Keep track of food expiration dates to minimize waste and stay organized.
- **Product Details**
  - View in-depth product information, including nutritional values and allergen warnings.
- **Recalled Products Alerts**
  - Stay informed about product recalls for added safety.
- **Search Recipes**
  - Discover recipes tailored to your dietary preferences and restrictions.
- **Profile Management**
  - Manage personal details such as name, email, password, and profile image.
- **Push Notifications**
  - Stay updated with real-time alerts for allergens, recalls, and important reminders.

### 🛠️ Architecture & State Management

##### Architecture:

The app follows Clean Architecture principles and integrates with Flutter Riverpod. The data layer manages data retrieval and storage, interfacing with databases and remote servers while maintaining a loose coupling with the domain layer for better organization and maintainability. The domain layer encompasses the business logic and core functionalities, acting as a bridge between the data layer and the presentation layer. Finally, the presentation layer is focused on user interface and interaction, utilizing widgets and other UI components to create an engaging and responsive user experience.

##### State Management

Managed with Riverpod.

### 🚀 Getting Started

- Clone the repository.
- Navigate to the project directory.
- Run `flutter pub get` to install dependencies.
- Connect with your Firebase project.
- Choose the desired build environment with `flavorizr`.
- Run `flutter run` to start the application.
