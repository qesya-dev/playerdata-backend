# PlayerData API

This is a simple RESTful API built with **Ruby on Rails 8** to manage athlete data, training sessions, and session performance metrics. It serves as a backend-only application (API-only), ideal for integration with frontend clients such as **React Native**.

---

## Features

- Full CRUD API for:
  - Athletes
  - Training Sessions
  - Session Metrics (linked to Training Sessions and Athletes)
- JWT Authentication:
  - Sign Up / Sign In
  - Refresh & Logout
- UUID as primary keys
- Token expiration handling
- Leaderboard by Distance or Sprints
- Proper validation and error handling
- Clean JSON responses with `data` and `meta` keys
- Organized by namespaces (`api/v1`)
- Seeded with 10 mock athletes & 3 training sessions
- Postman collection included for testing

---

## Requirements

- Ruby 3.3+
- Rails 8.x
- SQLite3 (default DB for development)
- Bundler

---

## Setup Instructions

1. **Clone the repository**

```bash
git clone https://github.com/your-username/playerdata-backend.git
cd playerdata-backend
```

2. **Install dependencies**

```bash
bundle install
```

3. **Set up the database**

```bash
rails db:drop db:create db:migrate db:seed
```

4. **Start the Rails server**

```bash
rails server
```

Your API is available at: [http://localhost:3000](http://localhost:3000)

---

## Authentication

### Sign Up

`POST /api/v1/auth/signup`

```json
{
  "name": "Steve Rogers",
  "position": "MF",
  "number": 8,
  "email": "steve@example.com",
  "password": "supersecret",
  "password_confirmation": "supersecret"
}
```

### Sign In

`POST /api/v1/auth/signin`

```json
{
  "email": "steve@example.com",
  "password": "supersecret"
}
```

### Refresh Token

`POST /api/v1/auth/refresh`

```json
{
  "refresh_token": "stored_refresh_token_here"
}
```

### Logout

`POST /api/v1/auth/logout`

```json
{
  "refresh_token": "stored_refresh_token_here"
}
```

---

## API Endpoints

All endpoints are prefixed with: `/api/v1`

### 🧍 Athletes

- `GET /athletes`  
- `GET /athletes/:id`  
- `POST /athletes`  
- `PUT /athletes/:id`  
- `DELETE /athletes/:id`

---

### 🏋️ Training Sessions

- `GET /training_sessions`  
- `GET /training_sessions/:id`  
- `POST /training_sessions`  
- `PUT /training_sessions/:id`  
- `DELETE /training_sessions/:id`

#### 🔻 Leaderboard

- `GET /training_sessions/:id/leaderboard?by=distance`  
- `GET /training_sessions/:id/leaderboard?by=sprints`

---

### 📊 Session Metrics

- `GET /training_sessions/:training_session_id/session_metrics`  
- `GET /training_sessions/:training_session_id/session_metrics/:id`  
- `POST /training_sessions/:training_session_id/session_metrics`  
- `PUT /training_sessions/:training_session_id/session_metrics/:id`  
- `DELETE /training_sessions/:training_session_id/session_metrics/:id`

---

## Postman Collection

The complete Postman collection is available in the repo as `PlayerData_API.postman_collection.json`.  
Includes pre-request scripts to save and use JWT tokens automatically.

---

## Seeded Data

- 10 real-world athletes
- 3 named training sessions
- Each athlete has metrics per session (distance, sprints, top speed)
