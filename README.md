
Friends App 

A Ruby on Rails application that allows users to manage their personal friend list.
Each user can sign up, log in, and maintain a **secure, private list of friends** with full CRUD functionality.
The application also supports **admin-level access** to view all friends across users.

---

## 🚀 Features

### 🔐 Authentication & Authorization

* User authentication using **Devise**
* Secure **signup, login, and logout**
* Authorization to prevent users from accessing others’ data
* Role-based access control (**User / Admin**)

### 👥 Friends Management

* Each user has their **own friends list**
* Full CRUD functionality:

  * Create
  * Read
  * Update
  * Delete friends
* Friends displayed in a **clean, tabular format**

### 👑 Admin Features

* Admin users can view **all friends created by all users**
* Normal users can view **only their own friends**
* Role-based logic implemented at the controller level

### 📄 Pagination

* Pagination implemented to limit the number of friends displayed per page
* Improves performance and usability for large datasets

---

## 🛠️ Tech Stack

* **Ruby on Rails**
* **Devise** (Authentication)
* **PostgreSQL / SQLite** (Database)
* **Bootstrap / HTML / CSS**
* **Git & GitHub**

---

## 🔗 Associations

```ruby
User has_many :friends
Friend belongs_to :user
```

Each friend record is associated with a specific user using a foreign key.

---

## 📋 Friend Attributes

* First Name
* Last Name
* Email
* Phone
* Twitter Handle

---

## ⚙️ Setup Instructions

### 1️⃣ Clone the repository

```bash
git clone https://github.com/your-username/friends-app.git
cd friends-app
```

### 2️⃣ Install dependencies

```bash
bundle install
```

### 3️⃣ Setup database

```bash
rails db:create
rails db:migrate
```

### 4️⃣ Start the server

```bash
rails s
```

Visit 👉 **[http://localhost:3000](http://localhost:3000)**

---

## 🔐 Authentication Flow

* Users must **sign up or log in** to access the application
* After successful authentication, users are redirected to the **Friends Index**
* Logout option is available in the navigation header
* Access to friends data is restricted based on user role

---

## 👑 Admin Role Setup (Development)

To mark a user as admin:

```bash
rails console
user = User.find_by(email: "admin@example.com")
user.update(role: "admin")
```

Admin users:

* Can view **all friends**
* Normal users remain restricted to their own data

---

## 🧪 Development Notes

* Database IDs auto-increment by default
* Strong Parameters used for secure data handling
* Tokens and secrets are **never committed** to the repository
* GitHub authentication handled using:

  * **SSH (recommended)** or
  * Personal Access Tokens (PAT) for HTTPS

---

## 📌 Future Enhancements

* Search functionality for friends
* Improved pagination UI
* Profile pictures for users
* Advanced admin dashboard
* Role-based edit/delete permissions
* Deployment to cloud platforms (Render / Fly.io / Heroku)

---

## 👨‍💻 Author

**Manjunath**
GitHub: [manjunath-1244](https://github.com/manjunath-1244)








