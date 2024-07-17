# JanSampark App

## Overview
JanSampark is a comprehensive social media app designed to address urban community issues by connecting residents with local authorities. It allows verified users to report grievances, upvote concerns, and foster community engagement for timely issue resolution.

---

## Features
- **Community Engagement:** Connects residents to share and address local grievances.
- **Safety Alerts:** Post and upvote concerns such as road issues and safety alerts.
- **Content Verification:** Ensures accurate and trustworthy information.
- **Neighborhood Unity:** Promotes trust and unity through verified, localized alerts.
- **Authority Attention:** Highlights most upvoted posts to local authorities for action.
- **Transparency:** Tracks issue status and authority responses for accountability.

---

## Tech Stack
- **Frontend:** Flutter
- **Backend:** Node.js, Express.js
- **Database:** MongoDB

---

## Middleware and Backend Components
### Workflow:
Client Request -> Routing and Validation -> Authentication -> Content Verification -> Location-Based Filtering -> Integration -> Response

### Components:
- **Client Request:** Flutter app sends requests to Express.js API gateway.
- **Express.js Server:** Handles API requests, built with Node.js and Express.js.
- **Routing and Validation:** Routes requests and validates data.
- **MongoDB:** Stores user data, posts, and manages authentication.
- **Business Logic Layer:** Core logic for grievance handling, upvoting, and content verification.
- **Content Verification:** Uses custom logic or machine models (Node.js and Python).
- **Location-Based Filtering:** Ensures content relevance based on user location.
- **Integration:** Forwards high-priority grievances to local authorities via RESTful APIs.
- **Notifications:** Real-time updates and notifications using websockets.
- **Response:** Sends processed data back to the client through the API gateway.

---

## Database Structure
### Collections:
- **Users:** Manages user registration, authentication, and profiles.
- **Grievances:** Stores grievance details (title, description, location, category, media).
- **Upvotes:** Tracks upvotes for grievances.
- **Comments:** Manages discussions related to grievances.
- **Notifications:** Stores user notifications about grievance updates.
- **Authorities:** Facilitates interaction with local authorities.

---

## Usage
1. **User Registration and Authentication:** Setup user profiles and authentication.
2. **Reporting a Grievance:** Post grievances, add details, and location.
3. **Viewing and Upvoting Grievances:** Browse posted issues, upvote concerns.
4. **Collaboration and Discussion:** Comment and discuss on grievances.
5. **Notification and Updates:** Receive real-time updates on grievance status.
6. **Interaction with Local Authorities:** Facilitate communication and track resolutions.
7. **Feedback and Ratings:** Provide feedback post-resolution.
8. **Post-Resolution Community Engagement:** Foster community engagement around resolved issues.

---

## Getting Started
To get started with JanSampark, follow these steps:
1. Clone the repository.
2. Install dependencies for both frontend and backend.
3. Configure MongoDB connection.
4. Run the backend server.
5. Run the Flutter app on your device/emulator.

---


## Server Live 

[here](https://jansampark.onrender.com)


## Contributors

- [Kiran Patel](https://github.com/patelkiran185)

---

## License
This project is licensed under the MIT License - see the [LICENSE](./LICENSE) file for details.

---


<div style="text-align: center; margin-top: 20px;">

[![Built with Flutter](https://img.shields.io/badge/Built%20with-Flutter-blue.svg)](https://flutter.dev/)
[![Node.js](https://img.shields.io/badge/Powered%20by-Node.js-green.svg)](https://nodejs.org/)
[![MongoDB](https://img.shields.io/badge/Backed%20by-MongoDB-green.svg)](https://www.mongodb.com/)

</div>

