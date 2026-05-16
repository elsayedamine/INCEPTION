# User & Administrator Documentation

Welcome to the system infrastructure user guide. This document provides clear, high-level instructions on what services this stack provides, how to control it, and how to verify that everything is running smoothly.

---

## 🗺️ Provided Services
This infrastructure provides a fully containerized web hosting and utility environment consisting of the following services:

*   **Public Web Traffic Gateway (NGINX):** Secures all incoming web traffic via HTTPS encryption.
*   **Content Management System (WordPress):** The primary website platform.
*   **Relational Database Engine (MariaDB):** Stores all website content, user profiles, and system settings securely.
*   **High-Performance Cache (Redis):** Speeds up the website by remembering frequent database queries.
*   **Database Admin Panel (Adminer):** A simple graphic interface to inspect and manage database tables.
*   **File Transfer Channel (vsftpd):** Allows administrators to securely upload or download files directly from the website's asset folders.
*   **Isolated Code Playground:** A custom workspace tool allowing users to safely test and run Python or Bash scripts via an interactive terminal-like web interface.

---

## 🚀 Controlling the Project Lifecycle

All infrastructure lifecycle commands must be executed from the root of the repository directory using the system `make` utility.

**To Start the Infrastructure:**
```bash
    make up
    \# This command reads the configuration layer, builds the containers, creates the private network, and launches all services cleanly in the background.
```

**To Stop the Infrastructure:**
```bash
    make down
    \# This safely ceases all running app processes without harming your persistent media assets or data collections.
```

---

## 🌐 Accessing the Services

Once the stack is launched, you can access your applications via a web browser using your custom domain.

| Service Name | Web Address (URL) | Purpose |
| :--- | :--- | :--- |
| **Main Website** | `https://aelsayed.42.fr` | The main public-facing WordPress landing page. |
| **WordPress Admin** | `https://aelsayed.42.fr/wp-admin` | Control panel to draft posts, manage themes, and edit configuration settings. |
| **Database Manager** | `https://aelsayed.42.fr/adminer` | Graphical panel used to review, query, or backup MariaDB database tables. |
| **Webserv Engine:** | `https://aelsayed.42.fr/webserv` | A custom HTTP server written entirely from scratch in by `gnxrlyqf` and me C++ 98 to host static portfolio content. |
| **Code Playground** | `https://aelsayed.42.fr/playground/` | Interactive developer playground panel to run scripts. |

---

## 🔑 Locating and Managing Credentials

To safeguard system integrity, all administrative passwords and database keys are kept outside the pushed source code. The file named `.env` located at the root of the project directory is where those keys should be integrated as variables.

### Key Variables inside `.env`:
*   `USER_PASSWORD` & `MYSQL_PASSWORD`: Credentials used by WordPress to read/write to the database.
*   `WP_ADMIN_PASS`: The administrative master key for the absolute database root.
*   `FTP_PASS`: System access accounts required to connect via an FTP client.

> ⚠️ **Administrative Note:** Never track the `.env` file into a Git repository. If passwords need modification, edit the file locally on the host machine and run `make down && make up` to safely reload them.

---

## 🔍 Verifying Service Health

To verify that all application layers are working correctly, run the following status commands:

1.  **Check Process Running Status:**
```bash
    docker compose ps
    \# Look at the `STATUS` column. Every service should read `Up` or `Running`.
```

## Inspect Active Performance Logs:

```Bash
    docker compose logs -f [service_name]
    \# Replace `[service_name]` with specific instances (e.g., `nginx`, `wordpress`, `playground`)
```

