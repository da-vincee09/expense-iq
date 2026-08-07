# 💰 ExpenseIQ

ExpenseIQ is a personal expense tracking application built with **Flutter** and **Supabase**. It helps users manage their income and expenses, monitor their monthly budget, and organize transactions using customizable categories.

---

## ✨ Features

### 🔐 Authentication

* User registration
* User login
* Persistent authentication session
* Secure logout

### 📊 Dashboard

* 💵 Total Balance
* 📈 Total Income
* 📉 Total Expenses
* 🎯 Monthly budget progress
* 🕒 Recent transactions
* 📋 Complete transaction history

### 💳 Transactions

* ➕ Add income
* ➖ Add expenses
* ✏️ Edit transactions
* 🗑️ Delete transactions
* 📝 Notes support
* 🏷️ Category selection
* 📅 Date selection

### 🏷️ Categories

* ➕ Create custom categories
* ✏️ Update categories
* 🗑️ Delete categories
* 💰 Separate Income and Expense categories
* 🔄 Dynamic category loading from Supabase

### 👤 Profile

* View profile information
* ✏️ Update profile
* 💰 Set monthly budget
* 🏷️ Manage categories

---

## 🛠️ Tech Stack

### 📱 Frontend

* Flutter
* Provider (State Management)
* GoRouter (Navigation)

### ☁️ Backend

* Supabase
* PostgreSQL
* Row Level Security (RLS)
* Supabase Authentication

---

## 🏗️ Architecture

The project follows a **feature-first architecture** with clear separation of concerns.

```text
lib/
├── core/
├── features/
│   ├── auth/
│   ├── category/
│   ├── dashboard/
│   ├── navigation/
│   ├── profile/
│   └── transactions/
├── shared/
└── main.dart
```

Each feature is organized into:

* 📂 Data
* 🧩 Domain
* 🎨 Presentation

---

## 🗄️ Database

### Tables

* 👤 `profiles`
* 💳 `transactions`
* 🏷️ `categories`

All tables are protected using **Row Level Security (RLS)** so users can only access their own data.

---

## ✅ Current Functionality

* 🔐 Authentication
* 👤 Profile Management
* 💰 Monthly Budget
* 💳 Transaction CRUD
* 🏷️ Category CRUD
* 📊 Dashboard Overview
* 🔄 Dynamic Categories
* 🧭 Bottom Navigation

---

## 🚀 Planned Features

* 🔍 Transaction Search
* 🎛️ Transaction Filters
* 📈 Analytics Dashboard
* 📊 Charts & Reports
* 📄 Export to CSV/PDF
* 🔔 Notifications
* ⚙️ Settings
* 🌙 Dark Mode

---

## 🚀 Getting Started

### 📋 Prerequisites

* Flutter SDK
* Dart SDK
* Supabase Project

### 📥 Installation

```bash
git clone https://github.com/your-username/expense_iq.git
cd expense_iq
flutter pub get
```

Configure your Supabase project credentials (such as in a `.env` file or your preferred configuration).

Run the application:

```bash
flutter run
```

---

## 👨‍💻 Author

Developed by **Rodini Vince Rosario** as a Flutter portfolio project showcasing modern mobile application development with **Flutter**, **Provider**, **GoRouter**, and **Supabase**.

⭐ If you like this project, consider giving it a star on GitHub!
