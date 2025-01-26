
# Health Connect Flutter App

This Flutter app integrates with the **Google Health Connect API** to fetch and display health-related data such as step count, calories burned, and other vital statistics. The app uses **Google APIs** for user authentication and retrieves data from various fitness and health apps connected via Health Connect.

## Features
- Authenticate users via **OAuth 2.0** using their Google account.
- Fetch and display health-related data, including **steps**, **calories burned**, **heart rate**, and more.
- Log and track health data over time.
- Cross-platform support for **Android** and **iOS** using Flutter.

## Prerequisites
To use this app, you need:
- A **Google Cloud Project** with the **Google Health Connect API** enabled.
- **OAuth 2.0 credentials** for authentication.

## Setup Instructions

### 1. Create a Google Cloud Project and Enable Health Connect API

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing one.
3. Enable the **Google Health Connect API** in your Google Cloud project.
4. Create **OAuth 2.0 credentials** (Client ID and Secret) and download the `credentials.json` file.

### 2. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/your-username/health-connect-flutter-app.git
cd health-connect-flutter-app
