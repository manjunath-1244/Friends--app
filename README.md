
# Friends App 🧑‍🤝‍🧑

A Ruby on Rails application that allows users to manage their personal friend list.  
Each user can sign up, log in, and maintain a private list of friends with full CRUD functionality.

---

## 🚀 Features

- User authentication using **Devise**
- Secure **login, signup, and logout**
- Each user has their **own friends list**
- Create, read, update, and delete friends
- Friends displayed in a clean **tabular format**
- Authorization to prevent users from accessing others’ data
- GitHub-ready Rails project structure

---

## 🛠️ Tech Stack

- **Ruby on Rails**
- **Devise** (Authentication)
- **PostgreSQL / SQLite** (Database)
- **Bootstrap / HTML / CSS**
- **Git & GitHub**

---

## 🔗 Associations

```ruby
User has_many :friends
Friend belongs_to :user
````

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
git clone https://github.com/your-username/Friends--app.git
cd Friends--app
```

---

### 2️⃣ Install dependencies

```bash
bundle install
```

---

### 3️⃣ Setup database

```bash
rails db:create
rails db:migrate
```

---

### 4️⃣ Start the server

```bash
rails s
```

Visit:
👉 `http://localhost:3000`

---

## 🔐 Authentication Flow

* Users must **sign up or log in** to access the app
* After authentication, users are redirected to the **Friends Index**
* Logout option is available on the friends page

---

## 🧪 Development Notes

* Database IDs auto-increment by default
* Tokens and secrets are excluded via `.gitignore`
* Personal Access Tokens / SSH are used for GitHub authentication

---

## 📌 Future Enhancements

* Search and pagination for friends
* Profile pictures
* Admin roles
* Deployment to cloud (Render / Fly.io)

---

## 👨‍💻 Author

**Manjunath**
GitHub: [manjunath-1244](https://github.com/manjunath-1244)





