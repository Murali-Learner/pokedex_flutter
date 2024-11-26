
# Pokedex App

Pokedex is a mobile app designed to help you explore Pokémon from the Pokémon universe. With Firebase integration and Google Authentication, you can create your Pokémon collection and maintain a personalized favorites list.

---

## Features

- **Explore Pokémon**: Browse through a comprehensive list of Pokémon fetched from the [PokéAPI](https://pokeapi.co/).
- **Detailed Pokémon Information**: View detailed stats, abilities, and types for each Pokémon.
- **Favorites List**: Mark your favorite Pokémon and maintain a curated list.
- **Google Authentication**: Securely log in using your Google account with Firebase Authentication.
- **Firebase Integration**: Favorites list is synced to your account using Firebase Firestore.

---

## Tech Stack

- **Flutter**: UI framework for building cross-platform apps.
- **Dart**: Programming language for Flutter.
- **PokéAPI**: Data source for Pokémon details.
- **Firebase**:
  - Firebase Authentication (Google Sign-In)
  - Firebase Firestore (Favorites list storage)

---

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/pokedex-app.git
   ```
2. Navigate to the project directory:
   ```bash
   cd pokedex-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase:
   - Create a Firebase project in [Firebase Console](https://console.firebase.google.com/).
   - Enable Google Authentication in the **Authentication** section.
   - Configure Firestore for storing favorite Pokémon data.
   - Download the `google-services.json` file for Android and/or `GoogleService-Info.plist` file for iOS, and place them in the respective directories (`android/app` and `ios/Runner`).

5. Run the app:
   ```bash
   flutter run
   ```

---

## How It Works

1. **Sign In**: Users log in with their Google account.
2. **Explore Pokémon**: Fetch Pokémon data from the PokéAPI to display a list of Pokémon.
3. **Favorites List**: When a Pokémon is marked as a favorite, it is saved in Firebase Firestore and synced to the user’s account.
4. **Persistent Data**: Logged-in users can access their favorites list across devices.

## Contributing

Feel free to contribute to the project by opening issues or submitting pull requests. Let's make this Pokedex app even better!

## Acknowledgements

- [PokéAPI](https://pokeapi.co/) for the Pokémon data.
- [Firebase](https://firebase.google.com/) for backend and authentication services.
- Flutter and Dart teams for the powerful cross-platform framework.

