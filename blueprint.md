# SoulSync: A Mental Wellness Companion

## Overview

SoulSync is a Flutter-based mobile and web application designed to be a personal companion for mental wellness. It allows users to track their moods, emotions, and daily influences, providing a space for self-reflection and, with the re-introduction of the AI feature, personalized advice.

## Implemented Features

### Core Functionality

*   **User Information:** The app starts by collecting the user's name for a personalized experience.
*   **Mood Tracking:** Users can log their mood on a scale of 1 to 10.
*   **Emotion Selection:** A comprehensive list of emotions allows users to identify and select what they are feeling.
*   **Influence Tracking:** Users can log various factors that may be influencing their mood.
*   **Physical Sensation Logging:** The app allows users to note any physical sensations they are experiencing.
*   **Wellbeing Actions:** Users can record any actions they have taken to support their wellbeing.
*   **End-of-Day Note:** A free-form text field allows for a final reflection at the end of the day.
*   **Log Summary:** A dedicated screen provides a complete summary of the user's daily log.
*   **Local Storage:** All logs are saved locally on the device using Hive for privacy and offline access.

### AI-Powered Advice

*   **Generative AI:** The app uses the `firebase_ai` package with the Gemini Pro model to generate supportive advice based on the user's log.
*   **Dedicated Screen:** A new screen, `advice_screen.dart`, displays the AI-generated advice.
*   **User Prompt:** A detailed prompt is constructed from the user's log data to provide context for the AI model.

### Technical Implementation

*   **Framework:** Flutter
*   **Routing:** `go_router` is used for declarative navigation.
*   **Data Persistence:** `hive` and `hive_flutter` are used for local data storage.
*   **Styling:** `google_fonts` is used for custom typography, and the app features a custom theme with a light color scheme.
*   **Firebase Integration:** The app is configured with Firebase and now utilizes the `firebase_ai` package for generative AI features.

## Design

*   **Theme:** The app uses a light and calming color scheme with amber as the primary seed color.
*   **Typography:** `Nunito Sans` is used for body text, and `Pacifico` is used for the app title, creating a friendly and approachable feel.
*   **UI Components:** The app utilizes Material Design components, including custom-styled buttons and chips.

## Development Steps Taken

1.  **Project Setup:** Initialized a new Flutter project.
2.  **Dependency Management:** Added `google_fonts`, `go_router`, `hive`, `hive_flutter`, and `firebase_core` to `pubspec.yaml`.
3.  **Core Screens:** Created the initial set of screens for the mood logging flow.
4.  **Routing:** Configured `go_router` for navigation.
5.  **Data Modeling:** Created the `ClientLog` model.
6.  **Local Storage:** Implemented Hive for data persistence.
7.  **Styling:** Implemented a custom theme.
8.  **Firebase Initialization:** Configured the app for Firebase.
9.  **AI Feature Removal (Troubleshooting):** Temporarily removed the AI feature to resolve build issues.
10. **Successful Build:** Successfully built the web application after the temporary removal.
11. **Re-implement AI-Powered Advice:**
    *   Added the `firebase_ai` package back to `pubspec.yaml`.
    *   Re-created the `advice_screen.dart` file to display AI-generated advice.
    *   Added the "Get AI Advice" button back to the `mood_summary_screen.dart`.
    *   Re-instated the `/advice` route in the `go_router` configuration in `main.dart`.
