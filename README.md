📌 Friends App

Friends App is a full-featured Ruby on Rails application that demonstrates real-world backend development concepts such as authentication, authorization, admin workflows, background jobs, scheduled tasks, CSV exports, and API exposure using Jbuilder.

The project is designed as a **production-style Rails application**, not just a basic CRUD app.

---

## 🚀 Tech Stack

- Ruby 3.2.x
- Ruby on Rails 8.1.1
- Devise (Authentication)
- Jbuilder (APIs)
- Active Job (Background Jobs)
- Action Mailer (Emails)
- Active Storage (File Uploads)
- Kaminari (Pagination)
- Whenever (Cron Jobs)
- CSV (Data Export)
- Git & GitHub (Version Control)

---

## 🔐 Authentication & Authorization

### Authentication
- User Signup, Login, Logout implemented using **Devise**
- Secure session-based authentication

### Authorization
- Role-based access:
  - **Admin**
  - **Normal User**
- Ownership-based authorization
- Admin has full access across the application

---

## 👥 Friends Management

### Features
- Create, Read, Update, Delete friends
- Each friend belongs to a user
- Normal users can manage only their own friends
- Admin can manage friends of all users
- Profile image upload using **Active Storage**
- Search friends by first name, last name, or email
- Pagination using **Kaminari**

### Commands Used
```bash
rails generate scaffold Friend first_name last_name email phone twitter user:references
rails db:migrate
rails active_storage:install
rails db:migrate
bundle add kaminari
````

---

## 📝 Posts Management

### Features

* Users can create posts
* All users can view posts
* Post owner can edit/delete their post
* Admin can delete posts of any user
* Total post count displayed

### Commands Used

```bash
rails generate scaffold Post content:text user:references
rails db:migrate
```

---

## 💬 Comments System

### Features

* Any logged-in user can comment on any post
* Comment owner can edit/delete their comment
* Post owner can delete comments on their post
* Admin can edit or delete comments of any user

### Commands Used

```bash
rails generate model Comment body:text user:references post:references
rails generate controller Comments
rails db:migrate
```

---

## 🛠️ Admin Dashboard

### Features

* Admin-only dashboard
* Displays:

  * Total users count
  * Total friends count
  * Friends per user report
* Admin-only CSV export access

### Implementation

* Admin namespace (`Admin::`)
* Role-based authorization
* Aggregated database queries

---

## 📧 Emails & Background Jobs

### Features

* Email notification when a friend is created
* Admin summary emails
* CSV export emails sent asynchronously

### Implementation

* **Action Mailer** for email delivery
* **Active Job** for background processing

### Commands Used

```bash
rails generate mailer UserMailer
rails generate mailer AdminReportMailer
rails generate mailer AdminExportMailer
rails generate job ExportFriends
rails generate job ExportPosts
```

---

## 📄 CSV Export Feature

### Features

* Admin can export:

  * Friends data
  * Posts data
* CSV generation runs in background
* CSV files sent to admin email as attachments

### Benefits

* Non-blocking UI
* Scalable for large datasets
* Production-ready workflow

---

## ⏱️ Scheduled Tasks (Cron Jobs)

### Features

* Automated admin reports
* Scheduled background execution

### Implementation

* **Whenever gem** used to define cron jobs

### Commands Used

```bash
bundle add whenever
wheneverize .
whenever --update-crontab
crontab -l
```

---

## 🔌 API Integration (Jbuilder)

### Purpose

* Learning APIs
* Preparing application for mobile or frontend integrations

### Features

* Versioned APIs (`/api/v1`)
* Read-only Friends API
* JSON responses built using **Jbuilder**

### API Endpoints

```
GET /api/v1/friends.json
GET /api/v1/friends/:id.json
```

### Implementation Details

* Separate API controllers under `Api::V1`
* Routes default to JSON format
* Controllers fetch data
* Jbuilder formats JSON response

### Commands Used

```bash
bundle add jbuilder
rails generate controller api/v1/friends index show
```

---

## 🎨 UI Styling

* Explored Bootstrap integration with Rails
* Learned asset pipeline, SCSS, and JS bundling
* UI improvements planned for future enhancements

---

## 🗂️ Project Structure (Key Folders)

```
app/
├── controllers/
│   ├── friends_controller.rb
│   ├── posts_controller.rb
│   ├── comments_controller.rb
│   └── api/v1/friends_controller.rb
├── views/
│   ├── friends/
│   ├── posts/
│   ├── comments/
│   └── api/v1/friends/
├── models/
│   ├── user.rb
│   ├── friend.rb
│   ├── post.rb
│   └── comment.rb
├── jobs/
├── mailers/
└── config/
```

---

## 🧠 Key Learnings

* Rails MVC architecture
* Secure authentication & authorization
* Ownership-based access control
* Background job processing
* Email workflows
* CSV generation & exports
* Cron job scheduling
* API development using Jbuilder
* Clean and scalable Rails project structure

---

## ▶️ How to Run the Project Locally

```bash
git clone <repo-url>
cd friends
bundle install
rails db:create
rails db:migrate
rails s
```

Visit:

```
http://localhost:3000
```

---

## 🧾 One-Line Summary

> Built a production-style Ruby on Rails application with authentication, role-based admin access, posts and comments, background jobs, scheduled tasks, CSV exports, and versioned JSON APIs using Jbuilder.

---

## 📌 Future Improvements

* API authentication (JWT)
* Pagination in APIs
* Improved UI using Bootstrap
* API endpoints for posts and comments
* Performance optimizations

---

## 🤝 Author

Kondabathini Manjunath

---

