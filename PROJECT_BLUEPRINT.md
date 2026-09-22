# EDUFLOW — SMART STUDENT PLATFORM

## Complete Flutter Project Blueprint, Architecture & Implementation Specification — V2

---

# 0. PROJECT DIRECTIVE

Act as a:

* World-Class Software Architect
* Senior Flutter Developer
* Firebase Architect
* UI/UX Engineer
* Backend Engineer
* QA Engineer
* Security Engineer

You are responsible for designing and implementing a complete, professional, portfolio-quality Flutter mobile application called:

# EduFlow — Smart Student Platform

This document is the **single source of truth for the entire project**.

All architecture, implementation, navigation, Firebase integration, data modeling, UI/UX, demo data, AI integration, testing, and quality decisions must follow this document.

Do not introduce unnecessary features, services, APIs, packages, architectural layers, or complexity that are not required by this specification.

The final result must feel like a real modern university/student platform rather than a tutorial project or a collection of disconnected screens.

---

# 1. PROJECT GOAL

EduFlow is a smart student platform designed to help university students manage and track their academic experience from one mobile application.

The application allows a student to:

1. Create an account
2. Log in
3. View a personalized home dashboard
4. Browse courses
5. Open course details
6. View lectures
7. Watch educational YouTube videos
8. Track completed lectures
9. View assignments
10. View assignment details
11. View weekly schedule
12. Take quizzes
13. View quiz results
14. Track academic progress
15. Ask an AI Study Assistant educational questions
16. Manage their profile
17. Log out securely

The application must prioritize:

* Professional UI/UX
* Clean and maintainable architecture
* Real navigation
* Real state management
* Real Firebase data
* Real authentication
* Real demo data
* Secure AI architecture
* Proper loading/error/empty states
* Responsive mobile layouts
* Strong separation of concerns
* Portfolio-quality code

---

# 2. CORE TECHNOLOGY STACK

Use:

* Flutter
* Dart
* Firebase Core
* Firebase Authentication
* Cloud Firestore
* Firebase Cloud Functions
* SharedPreferences
* GoRouter
* flutter_bloc / Cubit
* Equatable
* Intl
* YouTube Player Flutter
* One external AI provider through Firebase Cloud Functions

The AI provider should be Gemini or another single supported AI provider.

Do not add unnecessary external APIs.

The application should intentionally keep external services to a minimum.

---

# 3. ARCHITECTURAL PHILOSOPHY

Use a practical and maintainable version of:

* Clean Architecture
* Feature-First Architecture
* MVVM
* Repository Pattern
* Cubit-based state management

Do NOT over-engineer the application.

The goal is not to demonstrate the maximum number of architecture patterns.

The goal is to demonstrate a professional architecture that is:

* Clean
* Understandable
* Maintainable
* Scalable
* Testable
* Appropriate for the project's scope

---

# 4. MVVM INTERPRETATION

In this project:

```text
View
↓
Flutter Pages / Widgets
```

```text
ViewModel
↓
Cubit
```

```text
Domain
↓
Entities + Repository Contracts
```

```text
Data
↓
Models + Data Sources + Repository Implementations
```

Therefore:

**Cubit acts as the ViewModel layer.**

Do NOT create separate:

* Controllers
* ViewModels
* Cubits
* Blocs

for the same responsibility.

Avoid duplicated state-management layers.

---

# 5. HIGH-LEVEL ARCHITECTURE

The application should generally follow:

```text
UI / View
    ↓
Cubit / ViewModel
    ↓
Repository
    ↓
Data Source
    ↓
Firebase / Local JSON
```

For example:

```text
CoursesScreen
    ↓
CoursesCubit
    ↓
CoursesRepository
    ↓
CoursesRemoteDataSource
    ↓
Cloud Firestore
```

For quizzes:

```text
QuizScreen
    ↓
QuizCubit
    ↓
QuizRepository
    ↓
QuizLocalDataSource
    ↓
Local JSON
```

When submitting a quiz result:

```text
QuizCubit
    ↓
QuizRepository
    ↓
Firestore Data Source
    ↓
quiz_attempts
```

---

# 6. PROJECT SCOPE

The project must focus strictly on:

* Student
* Education
* Courses
* Lectures
* Assignments
* Schedule
* Quizzes
* Progress
* AI Study Assistant
* Profile
* Authentication

Do NOT add:

* Weather
* Maps
* E-commerce
* Payments
* Social media
* Admin dashboard
* Complex notification system
* Unnecessary APIs
* Assignment file upload
* Firebase Storage
* Phone Authentication
* YouTube Data API
* AI chat history
* Complex offline architecture
* Separate progress screen
* Separate settings screen
* Unnecessary backend services

---

# 7. AUTHENTICATION

Use Firebase Authentication with:

```text
Email + Password
```

Firebase Authentication is responsible for:

* Registration
* Login
* Logout
* Authentication state

Do NOT implement phone authentication.

The phone number collected during registration is simply stored as student profile information in Firestore.

---

# 8. DEMO ACCOUNT

The project MUST include a fully prepared Demo Account.

Example:

```text
Email:
demo@eduflow.com

Password:
Demo123456
```

These credentials may be changed later.

The Demo Account must be a real Firebase Authentication account.

It must have realistic Firestore data.

When the reviewer logs in, the application must NOT appear empty.

The reviewer must immediately see realistic academic content.

---

# 9. DEMO ACCOUNT EXPERIENCE

The intended demonstration experience is:

```text
Open App
    ↓
Splash
    ↓
Onboarding
    ↓
Login
    ↓
Use Demo Account
    ↓
Home
    ↓
Explore populated academic data
    ↓
Courses
    ↓
Course Details
    ↓
Lecture Player
    ↓
Assignments
    ↓
Assignment Details
    ↓
Schedule
    ↓
Quiz
    ↓
Quiz Result
    ↓
AI Assistant
    ↓
Profile
    ↓
Logout
    ↓
Login
```

The reviewer should not need to manually create:

* Courses
* Assignments
* Schedule
* Quiz results
* Progress
* Lectures

before being able to explore the application.

---

# 10. DEMO STUDENT DATA

The Demo Account should represent:

```text
Name:
Omar Ahmed

Major:
Computer Science

Level:
Level 2

University:
EduFlow University
```

The email should match the Firebase Authentication account.

---

# 11. DEMO COURSES

Create at least four realistic courses.

## Course 1

```text
Name:
Database Systems

Progress:
85%
```

## Course 2

```text
Name:
Flutter Development

Progress:
72%
```

## Course 3

```text
Name:
Web Technology

Progress:
64%
```

## Course 4

```text
Name:
Software Engineering

Progress:
78%
```

Each course must contain:

* Course ID
* Course name
* Course code
* Instructor
* Description
* Total lecture count
* Lecture references
* YouTube lecture IDs

Course progress should preferably be calculated from lecture completion rather than duplicated as an arbitrary value.

---

# 12. COURSE PROGRESS

Course progress should be based on:

```text
Completed Lectures / Total Lectures
```

Example:

```text
8 completed
11 total

Progress:
72.7%
```

The UI may display a rounded percentage:

```text
73%
```

Avoid storing duplicate progress values if they can be calculated reliably from existing data.

---

# 13. OVERALL PROGRESS

Overall progress should be calculated from the student's course progress.

For the four demo courses:

```text
Database Systems — 85%
Flutter Development — 72%
Web Technology — 64%
Software Engineering — 78%
```

Average:

```text
74.75%
```

Display approximately:

```text
75%
```

The application should not display `72%` as the overall progress unless a specific weighting system is intentionally implemented.

For this project, use the simple average of course progress.

---

# 14. LECTURES

Each course must contain multiple lectures.

Example:

```text
01 Introduction to Flutter
02 Widgets
03 Layouts
04 Navigation
05 State Management
06 Cubit
...
```

Each lecture should contain:

* Lecture ID
* Course ID
* Title
* Description
* Order
* YouTube Video ID

Do not build a YouTube search API.

Store YouTube video IDs directly.

---

# 15. YOUTUBE EDUCATIONAL VIDEOS

Use:

```text
youtube_player_flutter
```

The application should be able to:

* Open lecture
* Display video
* Play video
* Pause video
* Enter fullscreen
* Return from fullscreen
* Mark lecture as completed

No YouTube Data API is required.

No YouTube API key should be added to the Flutter application.

---

# 16. LECTURE COMPLETION

Lecture completion is user-specific.

Do NOT store:

```text
completed = true
```

inside the global lecture document.

Instead, store user-specific lecture progress.

Recommended structure:

```text
users/{userId}/lecture_progress/{lectureId}
```

Example:

```text
{
  completed: true,
  completedAt: Timestamp
}
```

This allows different students to have different lecture progress.

---

# 17. COURSE DETAILS

Course Details must display:

* Course name
* Course code
* Instructor
* Description
* Progress
* Lecture count
* Completed lectures
* Lecture list
* Continue Learning button
* Take Quiz button when a quiz exists

Example:

```text
Flutter Development

Instructor:
Ahmed Hassan

Progress:
73%

8 / 11 Lectures Completed
```

---

# 18. LECTURE LIST

Example:

```text
01 Introduction to Flutter       ✓
02 Widgets                       ✓
03 Layouts                       ✓
04 Navigation                    ✓
05 State Management              ▶
06 Cubit                         🔒
```

The visual state should clearly communicate:

* Completed
* Available
* Locked, if locking logic is actually implemented

Do NOT show fake locked states that do not have real logic.

If lecture locking is not implemented, all available lectures should simply be accessible.

---

# 19. LECTURE PLAYER SCREEN

Add a dedicated Lecture Player screen.

This is an actual screen because the application needs a dedicated interface for watching a lecture.

The Lecture Player should display:

* Lecture title
* Course name
* YouTube video
* Lecture description
* Completion status
* Mark as Completed button

When the user marks the lecture completed:

```text
Lecture Player
    ↓
Firestore
    ↓
User Lecture Progress
    ↓
Course progress updates
```

---

# 20. ASSIGNMENTS

Create realistic assignments.

Example:

## SQL Database Project

```text
Course:
Database Systems

Status:
Submitted

Grade:
92/100

Due Date:
September 5, 2026
```

## Flutter UI Task

```text
Course:
Flutter Development

Status:
Submitted

Grade:
88/100
```

## Web Technology Assignment

```text
Course:
Web Technology

Status:
Pending

Grade:
Not available
```

---

# 21. ASSIGNMENT DATA

Each assignment should contain:

```text
id
userId
courseId
title
description
dueDate
status
grade
feedback
```

The assignment is student-specific through:

```text
userId
```

No assignment upload functionality is required.

---

# 22. ASSIGNMENT DETAILS

Display:

* Assignment title
* Course
* Description
* Due date
* Submission status
* Grade
* Instructor feedback

For submitted:

```text
Status: Submitted
Grade: 92/100
```

For pending:

```text
Status: Pending
Grade: —
```

Do not create unnecessary submission/file-upload infrastructure.

---

# 23. WEEKLY SCHEDULE

The application must have a Weekly Schedule screen.

Display:

* Days
* Time
* Course
* Instructor
* Classroom

Example:

```text
Sunday

10:00 AM

Database Systems

Room 204
```

Allow the user to switch between days.

Highlight the current day.

If there are no classes:

```text
No classes scheduled
```

Do not leave blank screens.

---

# 24. SCHEDULE DATA

Each schedule item should contain:

```text
id
userId
courseId
dayOfWeek
startTime
endTime
instructor
classroom
```

Store actual time/day values in a structured way.

Use `intl` to format them for the UI.

---

# 25. QUIZ SYSTEM

Quiz questions must be stored locally.

Do NOT create a separate quiz API.

Recommended:

```text
assets/
└── quizzes/
    ├── database.json
    ├── flutter.json
    └── web.json
```

The local JSON files contain:

* Quiz ID
* Quiz title
* Course ID
* Questions
* Options
* Correct answer
* Explanation

---

# 26. QUIZ JSON STRUCTURE

Recommended structure:

```json
{
  "quizId": "database-fundamentals",
  "title": "Database Fundamentals",
  "courseId": "database-systems",
  "questions": [
    {
      "id": "q1",
      "question": "Example question",
      "options": [
        "Option A",
        "Option B",
        "Option C",
        "Option D"
      ],
      "correctAnswer": 1,
      "explanation": "Explanation of the correct answer."
    }
  ]
}
```

---

# 27. QUIZ SCREEN

The Quiz screen must support a real interactive quiz.

Display:

* Quiz title
* Question number
* Question
* Multiple-choice options
* Progress indicator
* Next button
* Submit Quiz button at the end

Example:

```text
Question 3 of 10

What is normalization?

○ Option A

○ Option B

○ Option C

○ Option D
```

Flow:

```text
Quiz
 ↓
Select Answer
 ↓
Next
 ↓
Next Question
 ↓
Submit Quiz
 ↓
Calculate Result
 ↓
Save Attempt
 ↓
Quiz Result
```

---

# 28. QUIZ STATE

QuizCubit is responsible for:

* Current question
* Selected answer
* Question index
* Answers
* Progress
* Quiz completion
* Score calculation
* Error state
* Loading state when necessary

Do not place quiz business logic directly inside widgets.

---

# 29. QUIZ SCORING

Calculate:

```text
Correct Answers
Wrong Answers
Total Questions
Percentage
Pass/Fail
```

Use:

```text
60%
```

as the default passing threshold.

Therefore:

```text
>= 60% → Passed

< 60% → Failed
```

---

# 30. QUIZ ATTEMPTS

Quiz questions are local.

Quiz attempts are stored in Firestore.

Recommended:

```text
quiz_attempts/{attemptId}
```

Fields:

```text
id
userId
quizId
courseId
score
totalQuestions
percentage
passed
completedAt
```

Do not store full quiz questions in Firestore.

Do not create a quiz API.

---

# 31. DEMO QUIZ RESULTS

The Demo Account must already have quiz attempts.

Example:

```text
Database Fundamentals

Score:
8/10

Percentage:
80%

Status:
Passed

Completed:
September 5, 2026
```

Another:

```text
Flutter Basics

Score:
9/10

Percentage:
90%

Status:
Passed
```

The reviewer must be able to see quiz history/results without taking a quiz first.

---

# 32. QUIZ RESULT SCREEN

Display:

```text
Quiz Completed 🎉

8 / 10

80%

Passed
```

Also display:

* Correct answers
* Wrong answers
* Total questions
* Date
* Course

Buttons:

```text
Try Again
```

and:

```text
Back to Course
```

Try Again must start a fresh quiz session.

Do not reuse the previous QuizCubit state.

---

# 33. AI STUDY ASSISTANT

The application must contain a professional AI Study Assistant.

Example questions:

* Explain normalization
* Explain Flutter state management
* Explain OOP
* Help me understand SQL
* Summarize a topic

The AI should behave as an educational assistant.

---

# 34. AI SECURITY ARCHITECTURE

The architecture MUST be:

```text
Flutter
   ↓
Firebase Cloud Function
   ↓
AI Provider
   ↓
Firebase Cloud Function
   ↓
Flutter
```

The AI API key must NEVER be placed directly inside:

* Flutter source code
* Dart files
* `firebase_options.dart`
* `pubspec.yaml`
* public GitHub files
* client-side `.env`

The AI credential belongs only to the backend environment/configuration.

---

# 35. AI DEVELOPMENT VS PRODUCTION

For local development/testing, a Functions `.env` file may be used.

Example:

```text
functions/.env
```

with:

```text
GEMINI_API_KEY=...
```

The file MUST be excluded from Git.

However:

`.env` is NOT considered the secure production solution for sensitive API keys.

For production deployment, use the appropriate secure secret mechanism such as Firebase Secret Manager.

Do not expose the API key to Flutter.

---

# 36. AI FUNCTION

The backend should contain a dedicated function such as:

```text
askStudyAi
```

It must:

1. Verify the user is authenticated.
2. Validate the incoming message.
3. Reject empty messages.
4. Apply a reasonable input length limit.
5. Send the request to the AI provider.
6. Return a clean response.
7. Convert technical backend errors into safe client-facing errors.
8. Never expose the API key.

---

# 37. AI CHAT HISTORY

Do NOT implement persistent AI chat history at this stage.

The conversation is session-based.

Example:

```text
Open AI Assistant
 ↓
Ask questions
 ↓
Conversation exists in current session
 ↓
Leave screen
 ↓
Session ends
```

Do not create an unnecessary Firestore `chat_messages` collection.

---

# 38. AI UI

The AI screen should contain:

* AI avatar
* User message bubbles
* AI message bubbles
* Text input
* Send button
* Loading/typing indicator
* Error state
* Empty initial state

Example initial state:

```text
How can I help you study today?
```

---

# 39. FIRESTORE COLLECTIONS

Use the following main collections:

```text
users
courses
lectures
assignments
schedules
quiz_attempts
```

Additionally use the user subcollection:

```text
users/{userId}/lecture_progress
```

Do not create unnecessary collections.

---

# 40. USER DOCUMENT

Recommended:

```text
users/{userId}
```

Fields:

```text
name
email
phone
major
level
university
profileImage
createdAt
```

The document ID MUST be the Firebase Authentication UID.

---

# 41. COURSE DOCUMENT

Recommended:

```text
courses/{courseId}
```

Fields:

```text
id
name
code
instructor
description
totalLectures
```

Do not store user-specific completion information inside global course documents.

---

# 42. LECTURE DOCUMENT

Recommended:

```text
lectures/{lectureId}
```

Fields:

```text
id
courseId
title
description
order
youtubeVideoId
```

---

# 43. ASSIGNMENT DOCUMENT

Recommended:

```text
assignments/{assignmentId}
```

Fields:

```text
id
userId
courseId
title
description
dueDate
status
grade
feedback
```

---

# 44. SCHEDULE DOCUMENT

Recommended:

```text
schedules/{scheduleId}
```

Fields:

```text
id
userId
courseId
dayOfWeek
startTime
endTime
instructor
classroom
```

---

# 45. QUIZ ATTEMPT DOCUMENT

Recommended:

```text
quiz_attempts/{attemptId}
```

Fields:

```text
id
userId
quizId
courseId
score
totalQuestions
percentage
passed
completedAt
```

---

# 46. LECTURE PROGRESS DOCUMENT

Recommended:

```text
users/{userId}/lecture_progress/{lectureId}
```

Fields:

```text
completed
completedAt
```

This is private user-specific data.

---

# 47. FIRESTORE DATA OWNERSHIP

Separate data conceptually into:

## Global academic data

```text
courses
lectures
```

These can be readable by authenticated users according to the security rules.

## Private student data

```text
users
assignments
schedules
quiz_attempts
lecture_progress
```

Users should only access their own private records.

---

# 48. FIRESTORE SECURITY RULES

Create proper:

```text
firestore.rules
```

Security rules must ensure:

* Unauthenticated users cannot access protected student data.
* Authenticated users can access allowed public academic data.
* Users can only read their own user document.
* Users can only read their own assignments.
* Users can only read their own schedules.
* Users can only read their own quiz attempts.
* Users can only read/write their own lecture progress.
* Users cannot modify another student's private data.
* Sensitive backend operations cannot be performed directly from the client.

Security rules must not simply allow:

```text
allow read, write: if true;
```

Never use insecure development rules in the final project.

---

# 49. DEMO SEED SYSTEM

Create a dedicated seed mechanism for the Demo Account.

The seed process must be able to:

```text
Create Demo Firebase User
        ↓
Create User Document
        ↓
Create Courses
        ↓
Create Lectures
        ↓
Create Assignments
        ↓
Create Schedule
        ↓
Create Quiz Attempts
        ↓
Create Lecture Progress
        ↓
Finish
```

The seed process must be repeatable.

---

# 50. SEED DUPLICATE PREVENTION

Do not use random Firestore IDs for static demo content.

Use stable IDs such as:

```text
database-systems
flutter-development
web-technology
software-engineering
```

and stable lecture IDs.

Use deterministic `set()` operations where appropriate.

Running the seed process multiple times must NOT create duplicate demo records.

---

# 51. SEED SECURITY

Do NOT expose an unrestricted public seed endpoint.

The seed mechanism should be intended for development/setup.

It must be protected from normal application users.

If implemented through a Cloud Function, it must have appropriate authorization/protection.

A normal user must never be able to trigger unrestricted database seeding.

---

# 52. DEMO ACCOUNT CREDENTIALS

Demo credentials must NOT be hardcoded into public production source files unnecessarily.

If credentials are documented, treat them carefully.

Do not commit private real credentials, API keys, secrets, or environment files.

A demo password may be documented separately if intentionally public and safe to do so, but it should not be treated as a production secret.

---

# 53. ONBOARDING

The onboarding experience contains three onboarding pages.

## Page 1

Display:

* Illustration
* Title
* Description
* Page indicator
* Next
* Skip

## Page 2

Display:

* Illustration
* Title
* Description
* Page indicator
* Next
* Skip

## Page 3

Display:

* Illustration
* Title
* Description
* Page indicator
* Get Started

Navigation:

```text
Onboarding 1
 ↓
Onboarding 2
 ↓
Onboarding 3
 ↓
Login
```

Skip:

```text
Onboarding
 ↓
Login
```

---

# 54. ONBOARDING PERSISTENCE

Use SharedPreferences to store:

```text
hasSeenOnboarding
```

First application launch:

```text
Splash
 ↓
Onboarding
 ↓
Login
```

After onboarding has been completed:

```text
Splash
 ↓
Login
```

If the user is already authenticated:

```text
Splash
 ↓
Home
```

SharedPreferences must NOT be used to store Firebase user data.

---

# 55. SPLASH SCREEN

The Splash screen should display:

* EduFlow logo
* App name
* Short tagline
* Loading indicator

The Splash screen must NOT simply wait for an arbitrary delay.

It should initialize the application and determine authentication state.

Conceptually:

```text
Splash
 ↓
Firebase initialization
 ↓
Check Auth State
 ↓
Check onboarding state
 ↓
Navigate
```

---

# 56. AUTHENTICATION DECISION FLOW

The routing logic should behave approximately like:

```text
Application starts
        ↓
Is Firebase initialized?
        ↓
Check Firebase Auth
        ↓
Authenticated?
   /            \
 Yes             No
 ↓                ↓
Home       Has seen onboarding?
             /          \
           Yes           No
            ↓             ↓
          Login       Onboarding
```

---

# 57. LOGIN SCREEN

Fields:

* Email
* Password

Buttons:

* Login
* Create Account
* Use Demo Account

Login form validation:

### Email

* Required
* Valid email format

### Password

* Required
* Minimum length

Wrong credentials should show a friendly error.

Show loading state while authenticating.

---

# 58. USE DEMO ACCOUNT

Provide a convenient:

```text
Use Demo Account
```

action.

It may populate the email and password fields with the demo credentials.

Do not require the reviewer to manually type credentials every time.

The demo action should remain clean and professional.

---

# 59. REGISTER SCREEN

Fields:

* Full Name
* Email
* Phone
* Password
* Confirm Password

Button:

```text
Create Account
```

Navigation:

```text
Register
 ↓
Firebase Authentication
 ↓
Create User Document
 ↓
Home
```

Also:

```text
Already have an account? Login
```

---

# 60. REGISTRATION VALIDATION

Validate:

### Name

* Required
* Reasonable minimum length

### Email

* Required
* Valid format

### Phone

* Required
* Valid format

### Password

* Required
* Minimum length

### Confirm Password

* Required
* Must match password

Show clear user-friendly messages.

---

# 61. REGISTRATION ERROR HANDLING

Handle cases such as:

* Email already in use
* Invalid email
* Weak password
* Network failure
* Firebase failure

Do not expose raw Firebase exception messages to the user.

---

# 62. USER CREATION

After Firebase Authentication creates the account:

```text
Firebase Auth
 ↓
Get UID
 ↓
Create users/{uid}
```

The UID must be the Firestore user document ID.

If the Firestore profile creation fails, the application must handle that failure gracefully rather than pretending registration was completely successful.

---

# 63. HOME DASHBOARD

Home is the main dashboard and the most important UI screen.

It should display:

## Header

* Student name
* Profile picture/avatar
* Greeting

Example:

```text
Good evening, Omar 👋
```

## Overall Progress

```text
Overall Progress
75%
```

## Continue Learning

Example:

```text
Flutter Development
73%
```

Button:

```text
Continue
```

Navigation:

```text
Home
 ↓
Course Details
```

## Upcoming Assignment

Example:

```text
SQL Database Project
```

Button:

```text
View Assignment
```

## Upcoming Schedule

Show the next class.

Button:

```text
View Schedule
```

## Recent Quiz

Example:

```text
Database Fundamentals
8/10
80%
```

Button:

```text
View Result
```

## AI Assistant Shortcut

Button:

```text
Ask AI
```

---

# 64. HOME DATA ARCHITECTURE

Home should not directly query Firebase from widgets.

Use:

```text
HomeScreen
 ↓
HomeCubit
 ↓
HomeRepository
 ↓
Data Sources / Repositories
```

HomeRepository should aggregate the information required by the dashboard.

The UI should not contain Firebase queries.

---

# 65. MAIN NAVIGATION

Use a bottom navigation bar with exactly:

```text
Home
Courses
Assignments
Schedule
Profile
```

Do NOT add:

* Quiz
* AI
* Progress

to the bottom navigation.

Quiz is accessed from Course Details.

AI is accessed from Home.

Progress is represented through the dashboard and course information rather than a separate tab.

---

# 66. COURSES SCREEN

Display all available courses.

Example:

```text
Database Systems             85%
Flutter Development          73%
Web Technology               64%
Software Engineering         78%
```

Each course is a clickable card.

Tap:

```text
Course Card
 ↓
Course Details
```

---

# 67. COURSE CUBITS

Use:

```text
CoursesCubit
CourseDetailsCubit
```

CoursesCubit handles the course list.

CourseDetailsCubit handles:

* Selected course
* Course lectures
* Completion information
* Course progress
* Loading
* Error
* Empty states when applicable

---

# 68. ASSIGNMENTS SCREEN

Display assignment cards containing:

* Title
* Course
* Due date
* Status
* Grade if available

Example:

```text
SQL Database Project
Database Systems
Submitted
92/100
```

Tap:

```text
Assignment
 ↓
Assignment Details
```

---

# 69. ASSIGNMENTS CUBIT

AssignmentsCubit manages:

* Assignment loading
* Assignment list
* Empty state
* Error state
* Selection/navigation data if needed

Do not place business logic directly in the widget.

---

# 70. WEEKLY SCHEDULE SCREEN

Provide:

* Day selector
* Current-day highlighting
* Schedule cards
* Time
* Course
* Instructor
* Classroom

Example:

```text
Sunday
10:00 AM

Database Systems
Ahmed Hassan
Room 204
```

Empty day:

```text
No classes scheduled
```

---

# 71. PROFILE SCREEN

Display:

* Profile picture/avatar
* Name
* Email
* University
* Major
* Level

Sections:

```text
Personal Information
Academic Information
App Information
Logout
```

Do NOT create a separate Settings screen unless there is a future requirement.

---

# 72. PROFILE IMAGE

Do not add Firebase Storage.

The profile image may be:

* A predefined local asset
* A remote URL already provided in profile data
* A generated initials avatar

No profile image upload is required.

---

# 73. LOGOUT

Logout must perform:

```text
FirebaseAuth.signOut()
```

Then GoRouter must redirect to:

```text
/login
```

The user must not be able to press Back and return to authenticated pages.

Do not rely only on `pushReplacement`.

Authentication state and route guards must enforce this.

---

# 74. ROUTING

Use:

```text
GoRouter
```

Create appropriate routes for:

```text
/splash
/onboarding
/login
/register
/home
/courses
/course-details
/lecture-player
/assignments
/assignment-details
/schedule
/quiz
/quiz-result
/ai-assistant
/profile
```

Onboarding may internally use a PageView instead of three separate routes.

---

# 75. ROUTE PROTECTION

Authenticated routes must require authentication.

Examples:

```text
/home
/courses
/course-details
/lecture-player
/assignments
/assignment-details
/schedule
/quiz
/quiz-result
/ai-assistant
/profile
```

If a logged-out user attempts to access:

```text
/home
```

redirect to:

```text
/login
```

If a user logs out:

```text
Authenticated routes
 ↓
Login
```

Back navigation must not restore access.

---

# 76. ROUTING ARCHITECTURE

Routing should be centralized.

Recommended:

```text
lib/core/routing/app_router.dart
```

Do not scatter navigation configuration across unrelated screens.

---

# 77. CLEAN ARCHITECTURE FOLDER STRUCTURE

Use:

```text
lib/
│
├── core/
│   ├── constants/
│   ├── di/
│   ├── errors/
│   ├── routing/
│   ├── theme/
│   ├── utils/
│   └── widgets/
│
├── features/
│   ├── auth/
│   ├── home/
│   ├── courses/
│   ├── assignments/
│   ├── schedule/
│   ├── quiz/
│   ├── ai_assistant/
│   └── profile/
│
├── firebase_options.dart
└── main.dart
```

Do NOT create a separate:

```text
progress/
```

feature.

Progress is a cross-feature concept represented through course completion and dashboard calculations.

---

# 78. FEATURE STRUCTURE

Major features should generally use:

```text
feature/
│
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

Do not force unnecessary layers into tiny features.

---

# 79. USE CASES

Use Cases are allowed when meaningful business logic exists.

Do NOT create a Use Case class for every simple operation just to increase file count.

Use Cases should be introduced when they improve:

* Business logic separation
* Testability
* Reusability
* Readability

The architecture should remain lean.

---

# 80. DATA SOURCES

Use clearly named data sources.

Prefer:

```text
courses_remote_data_source.dart
auth_remote_data_source.dart
quiz_local_data_source.dart
quiz_remote_data_source.dart
```

instead of vague names such as:

```text
courses_datasource.dart
```

This makes the source type explicit.

---

# 81. MODELS

Use models for external data representations.

Examples:

```text
StudentModel
CourseModel
LectureModel
AssignmentModel
ScheduleModel
QuizAttemptModel
```

Models handle conversion from/to:

* Firestore
* JSON
* Local data

---

# 82. DOMAIN ENTITIES

Use clean domain entities such as:

```text
Student
Course
Lecture
Assignment
ScheduleItem
QuizAttempt
```

Do not name entities unnecessarily:

```text
CoursesEntity
AssignmentsEntity
```

Prefer singular domain names.

---

# 83. REPOSITORIES

Repositories belong to the domain contract and data implementation.

Example:

```text
domain/
└── repositories/
    └── courses_repository.dart
```

and:

```text
data/
└── repositories/
    └── courses_repository_impl.dart
```

The UI must depend on repository abstractions through the Cubit/ViewModel layer.

---

# 84. CUBITS

Use Cubits approximately for:

```text
AuthCubit
HomeCubit
CoursesCubit
CourseDetailsCubit
AssignmentsCubit
ScheduleCubit
QuizCubit
AiAssistantCubit
ProfileCubit
```

Do not create:

```text
ProgressCubit
```

unless a future requirement genuinely needs a separate progress feature.

---

# 85. CUBIT STATES

Use appropriate states such as:

```text
Initial
Loading
Loaded / Success
Error
Empty
```

Not every Cubit must have every state if it is not logically necessary.

Use Equatable for predictable state comparisons.

---

# 86. CORE WIDGETS

Create reusable widgets only when genuinely shared.

Examples:

```text
AppButton
AppTextField
AppCard
LoadingWidget
ErrorStateWidget
EmptyStateWidget
```

Do not create dozens of abstractions before they are needed.

Feature-specific widgets belong inside the feature:

```text
courses/presentation/widgets/
```

---

# 87. DEPENDENCY INJECTION

Use:

```text
lib/core/di/injection_container.dart
```

to register major dependencies.

A lightweight DI approach such as `get_it` may be used if it improves the architecture.

Do not create a complex dependency injection framework.

---

# 88. THEME

Create a centralized theme.

Recommended:

```text
lib/core/theme/app_theme.dart
```

The theme should define:

* Primary color
* Secondary color
* Background
* Surface
* Text colors
* Error
* Success
* Typography
* Button styling
* Input styling
* Card styling
* Border radius
* Consistent spacing where appropriate

Avoid hardcoding the same colors/styles throughout screens.

---

# 89. UI/UX DIRECTION

The visual identity should be:

* Modern
* Clean
* Minimal
* Premium
* Professional
* Student-friendly
* Light-first

Recommended direction:

```text
Deep Blue / Indigo
+
White / Light Surfaces
+
Dark Text
+
Muted Gray
+
Subtle Success / Error colors
```

Avoid:

* Excessive gradients
* Excessive colors
* Huge shadows
* Overly complex animations
* Cluttered layouts

---
## Responsive Web Support

EduFlow must be designed from the beginning as a **responsive Flutter application** that provides a polished experience on both **Android/mobile devices and Web/desktop screens**.

This is an extension of the existing mobile-first design, not a separate web application. Do not create a second codebase or duplicate business logic.

### Core Requirement

The same Flutter project must support:

* Android
* Flutter Web
* Desktop-sized browser windows

The application must automatically adapt its layout based on the available screen width.

The Web version must look intentionally designed for desktop screens, not like a stretched mobile application.

### Responsive Navigation

Use adaptive navigation:

#### Mobile

Keep the existing bottom navigation:

* Home
* Courses
* Assignments
* Schedule
* Profile

#### Tablet/Desktop/Web

Use a professional sidebar or navigation rail instead of the bottom navigation.

The sidebar should contain:

* EduFlow logo/name
* Home
* Courses
* Assignments
* Schedule
* Profile
* AI Assistant

The navigation must remain consistent with the existing GoRouter structure.

Do not create separate navigation logic for Web and Android. Only the presentation/layout should change.

### Responsive Home Dashboard

The Home Dashboard should have different layouts depending on screen size.

#### Mobile

Use a vertically scrollable layout with:

* Welcome header
* Overall progress
* Continue Learning
* Upcoming Assignment
* Next Class
* Recent Quiz
* AI Assistant shortcut

#### Web/Desktop

Use the additional horizontal space effectively.

Possible layout:

* Top header with student information
* Summary/stat cards
* Continue Learning section
* Upcoming Assignment section
* Next Class section
* Recent Quiz section
* AI Assistant shortcut

Use rows, columns, grids, and flexible layouts where appropriate.

Do not simply increase the width of mobile cards.

### Responsive Course Screens

The Courses screen should adapt naturally:

* Mobile: single-column course cards/list
* Tablet: 2-column layout when appropriate
* Desktop/Web: 2–4 column grid depending on available width

Course Details should also adapt:

* Mobile: vertically stacked content
* Desktop/Web: use the available width to create a cleaner two-column or balanced layout when appropriate

Do not force a desktop layout when the screen is too narrow.

### Responsive Assignments

Assignments should adapt between:

* Mobile list/card layout
* Desktop/Web wider list or grid layout

Assignment Details should remain readable and well-spaced on large screens without excessive empty space.

### Responsive Schedule

The Weekly Schedule should be optimized for both screen sizes.

* Mobile: compact vertical/day-based layout
* Desktop/Web: wider weekly layout or horizontal arrangement when space allows

The schedule must remain easy to scan and must not overflow horizontally on small screens.

### Responsive Quiz

The Quiz experience must remain comfortable on mobile while taking advantage of larger Web screens.

* Keep the question area readable.
* Avoid excessively wide text blocks.
* Keep answer buttons/cards appropriately sized.
* Center and constrain the quiz content on large screens instead of stretching it across the entire browser.

### Responsive AI Assistant

The AI Assistant should adapt to screen size:

* Mobile: full-width chat experience
* Desktop/Web: centered chat panel with a reasonable maximum width

Do not allow chat content to become excessively wide on large monitors.

### Responsive Profile

Profile should remain visually balanced on both mobile and desktop.

On Web/Desktop, use a constrained content width rather than stretching the profile content across the entire screen.

### Responsive Lecture Player

The lecture/video player should adapt to the available screen size.

* Mobile: optimized portrait/mobile layout
* Desktop/Web: larger player with appropriate maximum width
* Preserve aspect ratio.
* Avoid overflow or distorted video dimensions.

### Breakpoints and Layout Strategy

Use Flutter's responsive layout tools such as:

* `LayoutBuilder`
* `MediaQuery`
* `ConstrainedBox`
* `Expanded`
* `Flexible`
* `Wrap`
* `GridView`
* `NavigationRail` or an appropriate sidebar/navigation pattern

Do not hardcode one fixed screen width.

Prefer reusable responsive widgets/helpers when the same behavior is needed across multiple screens.

Avoid creating excessive responsive utility files or over-engineering the solution.

### Important UI Rule

Responsive behavior must change **layout**, not application functionality.

Android and Web should use:

* The same Firebase backend
* The same repositories
* The same domain layer
* The same Cubits/ViewModels
* The same business logic
* The same Firestore data
* The same authentication system
* The same GoRouter routes

Only the presentation/layout should adapt to the available screen size.

### Web Quality Requirements

When running:

```bash
flutter run -d chrome
```

the application should:

* Open correctly in a browser.
* Have a professional desktop layout.
* Have no horizontal overflow.
* Have no RenderFlex overflow errors.
* Have readable text and properly sized components.
* Use the available screen width intelligently.
* Keep content within reasonable maximum widths.
* Maintain consistent spacing and visual hierarchy.
* Preserve the same functionality available on Android.

Do not create a separate Web-only feature set.

### Responsive Testing

Before considering the project complete, test the application at multiple sizes, including approximately:

* Small mobile width
* Large mobile width
* Tablet width
* Laptop/desktop browser width
* Large desktop browser width

Verify:

* No overflow
* No clipped text
* No broken navigation
* No stretched cards
* No unusable buttons
* No excessive empty space
* No broken grids
* No broken video/player layout
* No broken dialogs or forms

The final EduFlow application should feel like **one professionally designed responsive product**, not a mobile application forced into a desktop browser.


# 90. DASHBOARD DESIGN

The Home screen should be the strongest visual screen.

Recommended hierarchy:

```text
Greeting
 ↓
Overall Progress
 ↓
Continue Learning
 ↓
Upcoming Assignment
 ↓
Next Class
 ↓
Recent Quiz
 ↓
Ask AI
```

Use clean cards, spacing, progress indicators, and clear hierarchy.

---

# 91. COURSE CARD DESIGN

A course card should communicate quickly:

```text
Course Name
Course Code
Progress Bar
Percentage
```

Cards should be clean and not oversized.

---

# 92. ASSIGNMENT CARD DESIGN

Display:

```text
Assignment Title
Course
Due Date
Status Badge
Grade
```

Use clear status styling.

---

# 93. SCHEDULE DESIGN

Use a clear day selector such as:

```text
Sun
Mon
Tue
Wed
Thu
```

Highlight the current day.

Display schedule entries as clean cards/timeline items.

---

# 94. QUIZ DESIGN

Use:

* Question progress
* Question card
* Option cards
* Selected state
* Next button
* Submit button

Avoid making the quiz look like a basic form.

---

# 95. AI DESIGN

Use a modern chat layout:

```text
AI message
User message
AI message
User message
```

with:

* Message bubbles
* Input field
* Send button
* Loading indicator
* Friendly empty state

---

# 96. RESPONSIVE DESIGN

The application is primarily mobile-first.

All screens must work correctly on:

* Small phones
* Normal phones
* Large phones

Avoid:

* Fixed screen widths
* Hardcoded layout dimensions
* Overflow
* Unnecessary absolute positioning

Use appropriate:

```text
MediaQuery
LayoutBuilder
Flexible
Expanded
SingleChildScrollView
ListView
SafeArea
```

when needed.

---

# 97. FORM VALIDATION

All authentication forms must have complete validation.

Email:

* Required
* Valid format

Password:

* Required
* Minimum length

Confirm Password:

* Required
* Must match

Name:

* Required
* Reasonable minimum length

Phone:

* Required
* Valid format

Errors must be clear and user-friendly.

---

# 98. LOADING STATES

Every asynchronous operation must have an appropriate loading state.

Examples:

```text
Logging in...
Creating account...
Loading courses...
Loading assignments...
Loading profile...
Loading schedule...
Loading quiz...
Sending message...
Saving progress...
```

Never freeze the UI during asynchronous work.

---

# 99. ERROR STATES

Handle:

* Network errors
* Firebase Authentication errors
* Firestore errors
* AI failures
* Invalid credentials
* Empty data
* Unexpected backend failures

Never show raw technical exceptions to the user.

Convert them into clear user-friendly messages.

---

# 100. EMPTY STATES

Every list-based feature should have a meaningful empty state.

Example:

```text
No assignments yet.

You're all caught up!
```

Schedule:

```text
No classes scheduled.
```

Courses:

```text
No courses available.
```

Do not leave blank white screens.

---

# 101. ERROR / EMPTY / LOADING COMPONENTS

Use reusable components where appropriate:

```text
LoadingWidget
ErrorStateWidget
EmptyStateWidget
```

Keep the UI consistent throughout the application.

---

# 102. DATE AND TIME HANDLING

Use Firestore `Timestamp` for stored dates where appropriate.

Do not store display-only strings such as:

```text
"September 5, 2026"
```

as the primary database value.

Use `intl` to format dates and times for the UI.

Examples:

```text
September 5, 2026
10:00 AM
```

---

# 103. FIREBASE FUNCTIONS STRUCTURE

Use a simple and maintainable backend structure:

```text
functions/
└── src/
    ├── ai/
    │   └── gemini.js
    │
    ├── config/
    │   └── firebase.js
    │
    ├── handlers/
    │   ├── askStudyAi.js
    │   └── seedDemoData.js
    │
    └── index.js
```

Do not create unnecessary backend layers.

---

# 104. FIREBASE ADMIN SDK

The backend should initialize Firebase Admin in:

```text
functions/src/config/firebase.js
```

The Admin SDK must be used only on the trusted backend.

Do not expose Admin credentials or backend secrets to Flutter.

---

# 105. GEMINI BACKEND

The Gemini implementation belongs in:

```text
functions/src/ai/gemini.js
```

The handler should call the AI provider through that abstraction.

Flutter must never directly communicate with Gemini using the secret API key.

---

# 106. CLOUD FUNCTION AUTHENTICATION

The AI function should verify that:

```text
request.auth != null
```

before processing the request.

Unauthenticated users should not be able to use the protected AI endpoint.

---

# 107. AI ERROR HANDLING

If Gemini fails:

Return a safe client-facing error such as:

```text
Unable to connect to the study assistant.
Please try again.
```

Do not return:

* API keys
* internal stack traces
* raw provider exceptions
* internal server details

---

# 108. FIREBASE CONFIGURATION

The project already uses:

```text
firebase_options.dart
```

Do not manually rewrite or replace generated Firebase configuration unless required.

Do not change the Firebase project ID.

The configured Firebase project is:

```text
eduflow-student-app-19a5b
```

unless intentionally changed later.

---

# 109. ENVIRONMENT FILES

The following must never be committed:

```text
functions/.env
```

Ensure Git ignores it.

The project must have appropriate `.gitignore` rules.

Never commit:

* API keys
* secrets
* passwords
* private credentials
* `.env` files containing secrets

---

# 110. FIREBASE BILLING / PRODUCTION

The architecture must distinguish between local development and production deployment.

Local development may use:

```text
Firebase Emulator
+
functions/.env
```

Production deployment of Cloud Functions may require Firebase Blaze/pay-as-you-go.

Do not assume that local `.env` development configuration is equivalent to production secret management.

When deploying production Functions, use an appropriate secure secret-management solution.

---

# 111. NO FIREBASE STORAGE

Firebase Storage is not required.

Reasons:

* No assignment uploads
* No profile image upload
* No file management

Do not add Firebase Storage unless a future requirement explicitly introduces it.

---

# 112. NO PHONE AUTH

The Phone field in registration is only profile information.

Authentication remains:

```text
Email + Password
```

---

# 113. NO YOUTUBE DATA API

Store:

```text
youtubeVideoId
```

and use the player package.

Do not add:

```text
YouTube Data API
```

---

# 114. NO QUIZ API

Quiz content remains local.

Use:

```text
assets/quizzes/*.json
```

Quiz attempts remain in Firestore.

---

# 115. NO AI CHAT DATABASE

Do not create AI conversation history in Firestore at this stage.

Keep AI chat session-based.

---

# 116. NO SEPARATE PROGRESS SCREEN

Do NOT create:

```text
ProgressScreen
ProgressCubit
progress feature
```

Progress is represented through:

* Home Dashboard
* Course Cards
* Course Details
* Quiz Results
* Academic Profile Information

---

# 117. NO SEPARATE SETTINGS SCREEN

Do not create a dedicated settings screen unless future requirements justify it.

Profile can contain:

```text
Personal Information
Academic Information
App Information
Logout
```

---

# 118. MAIN NAVIGATION SUMMARY

Bottom navigation:

```text
Home
Courses
Assignments
Schedule
Profile
```

Secondary navigation:

```text
Courses
 ↓
Course Details
 ↓
Lecture Player
```

and:

```text
Course Details
 ↓
Quiz
 ↓
Quiz Result
```

Home shortcuts:

```text
Home
 ↓
Assignment Details
```

```text
Home
 ↓
Schedule
```

```text
Home
 ↓
Quiz Result
```

```text
Home
 ↓
AI Assistant
```

---

# 119. COMPLETE SCREEN LIST

The application should contain the following main screens:

```text
01. Splash
02. Onboarding 1
03. Onboarding 2
04. Onboarding 3
05. Login
06. Register
07. Home Dashboard
08. Courses
09. Course Details
10. Lecture Player
11. Assignments
12. Assignment Details
13. Weekly Schedule
14. Quiz
15. Quiz Result
16. AI Assistant
17. Profile
```

The previous plan's 16-screen count is intentionally updated to 17 because the Lecture Player is a real required screen.

---

# 120. NAVIGATION FLOW

## Startup

```text
Splash
 ↓
Firebase Initialization
 ↓
Auth State
 ↓
Routing Decision
```

## New User

```text
Splash
 ↓
Onboarding
 ↓
Login
 ↓
Register
 ↓
Create Account
 ↓
Home
```

## Existing Logged-Out User

```text
Splash
 ↓
Login
```

## Existing Logged-In User

```text
Splash
 ↓
Home
```

## Course Flow

```text
Home
 ↓
Courses
 ↓
Course Details
 ↓
Lecture Player
```

## Quiz Flow

```text
Course Details
 ↓
Quiz
 ↓
Quiz Result
 ↓
Back to Course
```

## Assignment Flow

```text
Home
 ↓
Assignment
 ↓
Assignment Details
```

## AI Flow

```text
Home
 ↓
AI Assistant
```

## Logout

```text
Profile
 ↓
Logout
 ↓
Firebase Sign Out
 ↓
Login
```

---

# 121. FEATURE STRUCTURE

Recommended feature organization:

```text
features/
│
├── auth/
│
├── home/
│
├── courses/
│
├── assignments/
│
├── schedule/
│
├── quiz/
│
├── ai_assistant/
│
└── profile/
```

---

# 122. COURSES FEATURE

Courses should contain:

```text
courses/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
└── presentation/
    ├── cubit/
    │   ├── courses_cubit.dart
    │   └── course_details_cubit.dart
    │
    ├── pages/
    │   ├── courses_page.dart
    │   ├── course_details_page.dart
    │   └── lecture_player_page.dart
    │
    └── widgets/
```

---

# 123. AUTH FEATURE

Auth should contain:

```text
auth/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

---

# 124. HOME FEATURE

Home should contain:

```text
home/
├── data/
├── domain/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

The Home feature must not become a giant file.

---

# 125. ASSIGNMENTS FEATURE

```text
assignments/
├── data/
├── domain/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

It should support:

* Assignment list
* Assignment details
* Loading
* Error
* Empty state

---

# 126. SCHEDULE FEATURE

```text
schedule/
├── data/
├── domain/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

---

# 127. QUIZ FEATURE

```text
quiz/
├── data/
│   ├── datasources/
│   │   ├── quiz_local_data_source.dart
│   │   └── quiz_remote_data_source.dart
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   └── repositories/
│
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

---

# 128. AI ASSISTANT FEATURE

```text
ai_assistant/
├── data/
├── domain/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

The Flutter data source communicates with Firebase Cloud Functions, not directly with Gemini.

---

# 129. PROFILE FEATURE

```text
profile/
├── data/
├── domain/
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

---

# 130. CORE STRUCTURE

Recommended:

```text
core/
├── constants/
├── di/
├── errors/
├── routing/
├── theme/
├── utils/
└── widgets/
```

Potential shared files:

```text
app_constants.dart
firebase_constants.dart
injection_container.dart
exceptions.dart
failures.dart
app_router.dart
app_theme.dart
```

Only create additional utilities when genuinely needed.

---

# 131. STATE MANAGEMENT RULE

Widgets should be responsible for:

* Display
* User interaction
* Layout

Cubits should be responsible for:

* State
* User action coordination
* Calling repositories
* UI state transitions

Repositories should be responsible for:

* Data abstraction

Data sources should be responsible for:

* Firebase/JSON interaction

Do not put Firestore queries directly inside UI widgets.

---

# 132. BUSINESS LOGIC RULE

Do not place important business logic inside:

```text
build()
```

or button callbacks.

Examples of logic that belong outside UI:

* Quiz scoring
* Pass/fail calculation
* Progress calculation
* Authentication handling
* Firestore queries
* AI calls
* Lecture completion persistence

---

# 133. REUSABILITY RULE

Reusable components should be created when:

* Used by multiple screens
* Have a stable purpose
* Improve consistency

Do not abstract every small widget.

Avoid unnecessary generic components.

---

# 134. PACKAGE DISCIPLINE

Only install packages that provide clear value.

Expected packages may include:

```text
flutter_bloc
firebase_core
firebase_auth
cloud_firestore
shared_preferences
go_router
equatable
intl
youtube_player_flutter
```

Optionally:

```text
get_it
```

if used for dependency injection.

Do not add packages such as:

* Dio
* Retrofit
* Freezed
* JSON code generation
* Large UI frameworks

unless a genuine project requirement appears.

---

# 135. TESTING STRATEGY

Before declaring the project complete, test:

## Authentication

* Registration
* Login
* Logout
* Demo Account
* Invalid credentials
* Validation
* Firebase errors

## Navigation

Verify:

```text
Splash → Onboarding
Onboarding → Login
Login → Register
Login → Home
Home → Courses
Home → Assignment
Home → Schedule
Home → Quiz Result
Home → AI
Courses → Course Details
Course Details → Lecture Player
Course Details → Quiz
Quiz → Result
Result → Course
Profile → Logout
Logout → Login
```

---

# 136. QUIZ TESTS

Test:

```text
10 questions
8 correct
→ 80%
→ Passed
```

Test failing result:

```text
10 questions
5 correct
→ 50%
→ Failed
```

Test:

* Empty quiz
* Selecting answers
* Changing answers
* Next question
* Submit
* Try again
* Result calculation

---

# 137. PROGRESS TESTS

Test:

```text
8 completed
11 total
→ approximately 73%
```

Test overall calculation from course progress.

Ensure displayed progress is consistent across:

* Home
* Courses
* Course Details

---

# 138. VALIDATION TESTS

Test:

* Empty email
* Invalid email
* Empty password
* Weak password
* Empty name
* Invalid phone
* Password mismatch

---

# 139. FLUTTER ANALYSIS

Before completion run:

```bash
flutter analyze
```

Fix all reasonable errors and warnings.

Do not leave avoidable analyzer errors.

---

# 140. TEST COMMAND

Run:

```bash
flutter test
```

At minimum, create useful unit tests for:

* Quiz scoring
* Progress calculation
* Validation
* Important business logic

Do not create meaningless tests only to increase test count.

---

# 141. BUILD VERIFICATION

Verify that the project can successfully run on the target Android emulator/device.

Confirm:

* No build errors
* No runtime crashes
* Firebase initializes correctly
* Authentication works
* Firestore reads/writes work
* Navigation works
* YouTube player works
* Quiz works
* AI function works when configured

---

# 142. RESPONSIVE TESTING

Test on:

* Small phone layout
* Standard phone layout
* Large phone layout

Check for:

* Overflow
* Clipped text
* Broken cards
* Keyboard issues
* Incorrect scrolling
* Bottom navigation problems
* Landscape/fullscreen video behavior where applicable

---

# 143. FINAL SECURITY AUDIT

Before completion verify:

* No API keys in Flutter
* No API keys in Git
* `.env` ignored
* Firebase rules are not public
* AI function requires authentication
* Seed mechanism is protected
* Users cannot access other users' private data
* No service-account credentials are committed
* No real private credentials are committed

---

# 144. FINAL CODE QUALITY AUDIT

Check:

1. Architecture
2. Folder structure
3. Navigation
4. Authentication
5. Firebase
6. Firestore
7. Security Rules
8. Demo Account
9. Seed Data
10. Courses
11. Lectures
12. Lecture Progress
13. Assignments
14. Schedule
15. Quiz
16. Quiz Results
17. Progress Calculation
18. AI Assistant
19. Profile
20. UI/UX
21. Validation
22. Loading states
23. Error states
24. Empty states
25. Responsive layouts
26. Reusable components
27. State management
28. Error handling
29. Security
30. Unused imports
31. Unused files
32. Dead code
33. Debug prints
34. Flutter analyzer
35. Flutter tests
36. Build success

---

# 145. FINAL DEMO EXPERIENCE

The reviewer should be able to:

```text
Open App
    ↓
Splash
    ↓
Onboarding
    ↓
Login
    ↓
Use Demo Account
    ↓
Home
    ↓
See realistic academic dashboard
    ↓
Open Courses
    ↓
Open Flutter Development
    ↓
View Course Details
    ↓
Open Lecture
    ↓
Watch YouTube Lecture
    ↓
Mark Lecture Completed
    ↓
Return to Course
    ↓
See Updated Progress
    ↓
Take Quiz
    ↓
Submit Quiz
    ↓
View Quiz Result
    ↓
Open Assignments
    ↓
View Assignment Details
    ↓
Open Weekly Schedule
    ↓
Open AI Assistant
    ↓
Ask Educational Question
    ↓
Receive AI Response
    ↓
Open Profile
    ↓
Logout
    ↓
Return to Login
```

The entire experience must feel connected.

---

# 146. PORTFOLIO QUALITY REQUIREMENT

The final application should demonstrate that the developer understands:

* Flutter
* Dart
* Clean Architecture
* Feature-First Architecture
* MVVM
* Cubit
* Repository Pattern
* Firebase Authentication
* Firestore
* Cloud Functions
* Local JSON
* State management
* Navigation
* Form validation
* Error handling
* Security
* Responsive UI
* Reusable components
* Testing
* Backend integration
* Secure API architecture

The project must not feel like a basic CRUD tutorial.

---

# 147. IMPORTANT IMPLEMENTATION PRINCIPLES

Never:

* Put business logic inside widgets
* Put Firebase queries directly inside screens
* Put Gemini API keys in Flutter
* Hardcode Firestore data directly into screens
* Create fake navigation
* Create buttons that do nothing
* Create unnecessary APIs
* Create unnecessary backend services
* Create duplicate architecture layers
* Create unnecessary features
* Create a separate Progress screen
* Create Firebase Storage without a requirement
* Create YouTube API integration
* Create AI chat history without a requirement
* Create an unrestricted seed endpoint

---

# 148. IMPORTANT ARCHITECTURAL PRINCIPLE

Do not confuse:

```text
Professional
```

with:

```text
Over-engineered
```

The architecture must remain lean.

Use Clean Architecture where it improves separation of concerns.

Use Cubit as the ViewModel.

Use repositories for data abstraction.

Use data sources for Firebase/local data access.

Use Use Cases only where they genuinely improve the design.

---

# 149. IMPLEMENTATION ORDER

Build the project in a controlled order.

Recommended sequence:

```text
1. Verify existing Flutter/Firebase project
2. Verify architecture/folder structure
3. Install required dependencies
4. Configure dependency injection
5. Configure theme/design system
6. Configure routing
7. Implement authentication
8. Implement onboarding persistence
9. Implement Firestore models/data sources/repositories
10. Implement demo seed system
11. Implement Home
12. Implement Courses
13. Implement Course Details
14. Implement Lecture Player
15. Implement Lecture Progress
16. Implement Assignments
17. Implement Schedule
18. Implement Quiz
19. Implement Quiz Results
20. Implement Profile
21. Implement AI Assistant backend
22. Connect AI Assistant to Flutter
23. Configure Security Rules
24. Add tests
25. Run analyzer
26. Run tests
27. Run application
28. Perform final audit
```

Do not attempt to build everything as one enormous file or one enormous widget.

---

# 150. IMPLEMENTATION STYLE

Use:

* Small focused files
* Clear naming
* Strong typing
* Null safety
* Reusable components
* Meaningful abstractions
* Simple readable code

Avoid:

* Giant files
* Giant widgets
* Duplicate code
* Magic numbers
* Magic strings
* Excessive comments
* Unnecessary abstractions

Comments should explain genuinely non-obvious decisions rather than obvious code.

---

# 151. EXISTING PROJECT PRESERVATION

The existing Firebase configuration must be preserved.

Do not unnecessarily regenerate:

```text
firebase_options.dart
```

Do not change:

```text
Firebase Project ID
```

Do not destroy existing Firebase configuration.

Do not run:

```text
flutter create
```

over the existing project.

Do not run:

```text
firebase init
```

again unless genuinely required.

---

# 152. EXISTING API / CONFIGURATION SAFETY

If an important API/configuration already exists:

* Do not replace it unnecessarily.
* Do not change credentials.
* Do not rewrite generated Firebase configuration.
* Do not break existing working configuration.

If a change is genuinely required, make the smallest safe change.

---

# 153. DEBUGGING PRINCIPLE

When an error appears:

1. Identify the actual root cause.
2. Fix the root cause.
3. Do not randomly change unrelated files.
4. Do not upgrade multiple dependencies without reason.
5. Do not replace working architecture because of one error.
6. Re-run the relevant verification command.
7. Continue only after confirming the fix.

---

# 154. AI IMPLEMENTATION PRINCIPLE

When using an AI coding assistant such as Antigravity:

* Inspect the existing project first.
* Read this entire document before implementation.
* Treat this document as the source of truth.
* Do not repeatedly ask for confirmation for every small step.
* Perform related implementation tasks together.
* Do not make unrelated architectural changes.
* Do not invent features.
* Do not remove required features.
* Do not replace working configuration unnecessarily.

---

# 155. DEMO DATA QUALITY

Demo data must look realistic.

Do not use:

```text
Course 1
Course 2
Assignment 1
Quiz 1
```

Use realistic academic names.

Examples:

```text
Database Systems
Flutter Development
Web Technology
Software Engineering
```

Use realistic:

* Instructor names
* Descriptions
* Dates
* Grades
* Classroom numbers
* Lecture titles
* Quiz names

---

# 156. DEMO ACCOUNT MUST NEVER LOOK EMPTY

After login, the reviewer should immediately see:

```text
Student name
Overall progress
Current course
Upcoming assignment
Next class
Recent quiz
```

The application must demonstrate its main capabilities without requiring setup from the reviewer.

---

# 157. DATA CONSISTENCY

All demo data must be internally consistent.

For example:

If Course Details says:

```text
8 / 11 lectures completed
```

the lecture progress data must actually reflect that.

If the course displays:

```text
73%
```

it should correspond to the completion data.

If Home says:

```text
75% overall
```

it should correspond to the configured course progress calculation.

Quiz results, assignments, courses, and schedule must reference valid IDs.

---

# 158. NAVIGATION CONSISTENCY

Every important button must perform its intended action.

Examples:

```text
Continue
View Assignment
View Schedule
View Result
Ask AI
Take Quiz
Try Again
Back to Course
Logout
```

No fake buttons.

No dead-end screens.

No placeholder navigation in the final product.

---

# 159. QUALITY BAR

The final product should look like a polished student application that could reasonably be shown in:

* LinkedIn
* GitHub
* Portfolio
* Technical interview
* Flutter project showcase

The reviewer should be able to understand from the project that real engineering decisions were made.

---

# 160. FINAL PRODUCT DEFINITION

EduFlow is a:

> **Modern Smart Student Platform built with Flutter and Firebase, using practical Clean Architecture + MVVM/Cubit, real authentication, real Firestore academic data, local quizzes, secure server-side AI integration, YouTube educational lectures, demo seed data, professional navigation, responsive UI, proper state handling, and portfolio-quality engineering practices.**

The final product must prioritize:

```text
Clean Architecture
+
Professional UI/UX
+
Real Navigation
+
Firebase
+
Demo Account
+
Seed Data
+
Lecture Tracking
+
Local Quizzes
+
Secure AI
+
Proper State Management
+
Security
+
Testing
+
Portfolio Quality
```

This document is the authoritative specification for the project.

Do not remove required functionality.

Do not add unnecessary functionality.

Do not over-engineer the architecture.

Build EduFlow as one coherent, realistic, professional student platform.
