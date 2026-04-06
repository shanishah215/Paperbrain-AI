# PaperBrain 📚🧠

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![Vercel](https://img.shields.io/badge/Vercel-000000?style=for-the-badge&logo=vercel&logoColor=white)](https://vercel.com)
[![GetX](https://img.shields.io/badge/GetX-8C4FFF?style=for-the-badge&logo=dart&logoColor=white)](https://pub.dev/packages/get)
[![Gemini AI](https://img.shields.io/badge/Gemini%20AI-4285F4?style=for-the-badge&logo=google&logoColor=white)](https://ai.google.dev/)

PaperBrain is a premium Flutter application that combines PDF document analysis with AI-powered chat interactions. Upload your PDF documents and have intelligent conversations about their content using Google's Gemini AI.

**Live Demo:** [https://paperbrain-ai.vercel.app/](https://paperbrain-ai.vercel.app/)

## ✨ Features

- **📄 PDF Document Upload & Viewing**: Seamlessly upload and read PDF documents with a premium viewer.
- **🤖 AI-Powered Document Analysis**: Intelligent conversation about document contents.
- **💬 Interactive Chat Interface**: Modern, responsive chat UI with real-time AI feedback.
- **📱 Premium Design**: Dark-mode optimized, sleek, and responsive Flutter Web experience.
- **🏗️ Clean Architecture**: Strict separation of concerns (Presentation, Domain, Data).

## 🚀 Getting Started

### Prerequisites

- Flutter (latest stable version)
- Dart SDK
- Google Gemini API Key
- Android Studio / VS Code

### Local Setup

1.  Clone the repository:
    ```bash
    git clone https://github.com/shanishah215/Paperbrain-AI.git
    ```
2.  Create a `.env` file in the root:
    ```env
    API_KEY=your_gemini_api_key_here
    ```
3.  Install dependencies:
    ```bash
    flutter pub get
    ```
4.  Run the app:
    ```bash
    flutter run -d chrome
    ```

## ☁️ Vercel Deployment

This project is optimized for Vercel deployment using a custom build script.

1.  **Environment Variables**: Add `API_KEY` to your Vercel Project Settings.
2.  **Build Command**: `bash build.sh`
3.  **Output Directory**: `build/web`

The `build.sh` script handles Flutter SDK installation, dependency resolution, and secure API key injection during the build process.

## 🏗️ Project Architecture

The project follows **Clean Architecture** principles strictly:

```
lib/src/
├── data/           # Repository implementations & Data sources
├── domain/         # Business logic, Entities & Use cases
├── features/       # Feature-based UI modules (Home, Chat, PDF)
│   ├── presentation/
│   ├── domain/
│   └── data/
└── main.dart       # App entry point
```

- **State Management**: [GetX](https://pub.dev/packages/get)
- **Networking**: [google_generative_ai](https://pub.dev/packages/google_generative_ai)
- **PDF Handling**: [pdfrx](https://pub.dev/packages/pdfrx)

## 🛠️ Tech Stack

- **Framework**: Flutter (Web)
- **State Management**: GetX
- **AI**: Google Gemini Pro (via Generative AI SDK)
- **Hosting**: Vercel
- **Styling**: Custom Flutter ThemeData (Slate/Indigo Palette)