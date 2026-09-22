# EduFlow — Smart Student Platform

A modern platform designed for IT students to manage their educational journey. EduFlow centralizes access to courses, video lectures, assignments, quizzes, and a daily schedule.

**Live Demo**: [https://eduflow-chi-nine.vercel.app](https://eduflow-chi-nine.vercel.app/)  
**GitHub Repository**: [https://github.com/3umrzidan23-tech/eduflow](https://github.com/3umrzidan23-tech/eduflow)

---

## ✨ Main Features
- **Authentication**: Secure login and registration using Firebase Authentication.
- **Dashboard**: Home screen displaying an overview of recent activities and ongoing courses.
- **Courses**: Browse and enroll in a curated list of core IT courses.
- **Course Details & Lectures**: View syllabus, track progress, and watch embedded educational YouTube videos directly inside the app.
- **Assignments**: Track upcoming tasks, deadlines, and submission statuses.
- **Schedule**: A dynamic weekly timetable distributing courses logically across the weekdays.
- **Quizzes**: Test your knowledge with interactive quizzes and view instant results.
- **Profile**: Manage student information and app settings.
- **🤖 AI Assistant**: 
  - The UI for the AI Chatbot and the Firebase Cloud Function integration (using Gemini API) are fully implemented in the codebase.
  - *Note:* The AI Assistant is currently not active in the production environment because deploying the necessary Cloud Function requires upgrading the Firebase project from the free Spark plan to the Blaze plan.

---

## 📸 Screenshots
*(Screenshots of the application will be added here shortly)*

---

## 🛠 Tech Stack
- **Framework:** [Flutter](https://flutter.dev/) (Cross-platform support: Mobile & Web)
- **Language:** Dart
- **State Management:** Bloc / Cubit
- **Routing:** GoRouter
- **Backend as a Service (BaaS):** Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Cloud Functions
- **Architecture:** Clean Architecture & MVVM
- **Video Integration:** Embedded YouTube video player.
- **Deployment:** Vercel

---

## 🏗 Architecture
EduFlow is built utilizing **Clean Architecture** and **MVVM** patterns to ensure scalability and maintainability:
- **Clean Architecture**: The codebase is divided into `domain`, `data`, and `presentation` layers. This ensures that business logic is isolated from UI and external data sources.
- **MVVM & Cubit/Bloc**: The Presentation layer uses Cubit to manage state efficiently. Cubits act as ViewModels, interacting with Domain UseCases/Repositories and emitting states that the UI reacts to.
- **Feature-First Structure**: Features (Auth, Courses, Schedule, Quizzes, etc.) are encapsulated in their own modules, making the project highly cohesive.

---

## 🔥 Firebase Services Used
- **Authentication**: Managing user sign-ups, logins, and secure sessions.
- **Cloud Firestore**: Storing structured data such as courses, assignments, schedules, and user profiles.
- **Cloud Functions**: A secure backend layer implemented to communicate with the Gemini API for the AI Assistant.

---

## ⚙️ Installation & Running Locally

To run the project locally on your machine:

1. **Clone the repository:**
   ```bash
   git clone https://github.com/3umrzidan23-tech/eduflow.git
   cd eduflow
   ```
2. **Install Dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the App:**
   - For Mobile (Android/iOS emulator):
     ```bash
     flutter run
     ```
   - For Web (Chrome):
     ```bash
     flutter run -d chrome
     ```

*(Note: The project requires a Firebase configuration to run with a backend. Ensure you configure your own Firebase project using `flutterfire configure` if you intend to modify or deploy your own instance).*

---

## 📂 Project Structure (Simplified)
```text
lib/
├── core/
│   ├── config/          # Environment & App configurations
│   ├── constants/       # App-wide constants (colors, strings)
│   ├── routing/         # GoRouter setup
│   ├── theme/           # App themes
│   └── widgets/         # Shared UI components
└── features/
    ├── ai_assistant/    # AI Chatbot logic & UI
    ├── assignments/     # Student assignments & tasks
    ├── auth/            # Login, Registration & Auth state
    ├── courses/         # Course listing, details, and video player
    ├── home/            # Main dashboard
    ├── profile/         # User profile
    ├── quiz/            # Quizzes and results
    └── schedule/        # Weekly timetable
```

---

## 🔮 Future Improvements
- **Push Notifications**: Integrate Firebase Cloud Messaging to remind students of upcoming assignment deadlines.
- **Offline Support**: Cache course content and schedules using local storage for offline access.
- **Dark Mode**: Add a system-aware dark theme for better accessibility and user comfort.

---

## 👨‍💻 Developer
**Omar Ahmed**  
*IT Student | Frontend Developer*  
[GitHub Profile](https://github.com/3umrzidan23-tech)
