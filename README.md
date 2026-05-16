*This project has been created as part of the 42 curriculum by aelsayed.*

# Inception

## 📝 Description
The **Inception** project is a comprehensive system administration and DevOps exercise designed to introduce the concepts of microservices orchestration using **Docker**. The goal is to build a fully containerized, secure, and resilient infrastructure from scratch without utilizing pre-made community images from Docker Hub (except for bare-minimum Linux distributions like Debian).

### Project Overview & Sources
The entire cluster is orchestrated via a single unified `docker-compose.yml` file managing a private network environment. The infrastructure consists of the following dedicated source layers:
- **NGINX**: The sole gateway into the infrastructure, serving traffic exclusively over port 443 using TLSv1.3.
- **WordPress**: Handled via `php-fpm` to dynamically serve web blocks.
- **MariaDB**: The relational database layer holding state information.
- **vsftpd (FTP Server)**: A secure file transfer channel configured with a chroot jail to access the shared WordPress volume.
- **Redis**: An in-memory database configuration acting as an object cache to optimize database query overhead.
- **Adminer**: A lightweight, single-file database management utility.
- **Webserv (Bonus Static Website)**: A custom HTTP web server implemented completely from scratch by `gnxrlyqf` and me in C++ 98. It acts as a live production test for the `webserv` engine, securely hosting and serving my personal portfolio page under a dedicated NGINX reverse-proxy route.
- **Code Playground**: A custom-designed Flask web application providing an isolated code execution environment to run Python and Bash scripts natively inside the container matrix.

---

## 📐 Infrastructure Design Choices & Technical Comparisons

### 🖥️ Virtual Machines vs. Docker
- **Virtual Machines (VMs)** isolate applications by virtualizing an entire physical hardware system. Each VM includes a full guest operating system (OS), its own kernel, virtual drivers, and binaries, consuming significant CPU, RAM, and storage overhead.
- **Docker Containers** isolate applications at the OS level. They share the host machine's Linux kernel directly and isolate processes using Linux namespaces and cgroups. This makes containers incredibly lightweight, fast to boot, and highly resource-efficient.
- *Design Choice*: Docker was chosen to implement a microservices architecture where services remain isolated from one another without incurring the performance costs of multiple running guest kernels.

### 🔑 Secrets vs. Environment Variables
- **Environment Variables** are configuration strings injected into a process environment. They are easy to implement but are often exposed in plain text through command histories, system logs, or tools like `docker inspect`.
- **Docker Secrets** provide a highly secure mechanism for storing sensitive payload data (such as passwords and SSL keys). Secrets are encrypted at rest, transmitted securely, and mounted solely into the memory (`tmpfs`) of containers explicitly granted access.
- *Design Choice*: For this project implementation, **Environment Variables** managed via a centralized `.env` file were selected. While Docker Secrets offer superior production-grade security, environment variables were chosen here to maintain strict and easy compliance with Docker Compose standards, ensuring seamless portability and environment reproducibility. To minimize exposure risks, the `.env` file is explicitly excluded from version control using `.gitignore`.

### 🌐 Docker Network vs. Host Network
- **Host Networking** removes network isolation between the container and the Docker host, making the container bind directly to the host's network interfaces (e.g., exposing port 80 directly on the machine's primary IP).
- **Docker Networks (Bridge Mode)** establish an isolated, software-defined internal network switch. Containers can communicate with each other using their service names as hostnames via built-in DNS resolution, completely isolated from the external internet unless explicitly exposed via port mapping.
- *Design Choice*: A dedicated internal bridge network named `inception` was created. Containers like MariaDB and Redis are entirely hidden inside this network, while NGINX serves as the single exposed interface to the host.

### 💾 Docker Volumes vs. Bind Mounts
- **Bind Mounts** point directly to a specific user-defined directory path on the host machine. They depend on the host's directory structure and can cause file permission conflicts between the host OS and container users.
- **Docker Volumes** are managed completely by Docker within its internal storage directory (`/var/lib/docker/volumes/`). They are safer, abstract host OS path rules away, and are highly optimized for container performance and automated backup lifecycles.
- *Design Choice*: Explicit paths under `/home/aelsayed/data/` are utilized to ensure absolute data persistence across container restarts while matching strict project evaluation specifications for volume storage mapping.

---

## 🛠️ Instructions

### 1. Prerequisites
Before executing the initialization script, ensure your local environment contains the mandatory directory structures for persistent storage volumes:

```bash
mkdir -p /home/aelsayed/data/wordpress
mkdir -p /home/aelsayed/data/mariadb
```
Additionally, ensure your local /etc/hosts file routes domain queries correctly:

```text
127.0.0.1 aelsayed.42.fr
```

### 2. Configuration Setup
Create a .env file in the root of your project directory populated with your orchestration parameters:

```bash
MYSQL_PASSWORD=secure_password
WP_ADMIN_PASS=secure_password
USER_PASSWORD=secure_password
FTP_PASS=secure_password
```

### 3. Compilation & Execution
Build and spin up the complete infrastructure cluster in detached mode:

```bash
make up
```
To stop the entire cluster environment cleanly while keeping volume data intact:

```bash
make down
```
To completely purge the infrastructure including persistent volumes:
```bash
make fclean
```

## 📚 Resources

### Documentation & References
- [Docker Documentation Engine](https://docs.docker.com/)
- [NGINX Reverse Proxy Configuration Guide](https://nginx.org/en/docs/)
- [Alpine / Debian Package Systems Reference](https://www.debian.org/distrib/packages)
- [vsftpd.conf Official Manual Pages](https://security.appspot.com/vsftpd/vsftpd_conf.html)
- [Flask Web Development Framework Documentation](https://flask.palletsprojects.com/)

### 🤖 AI Usage Statement
Artificial Intelligence was used during the development of this project to assist with structural planning, architectural choices, infrastructure debugging, and frontend development.

**Specific Tasks & Parts Benefiting from AI:**
1. **Architectural Ideation & Service Selection**: AI was used to brainstorm and select a clever, independent, and secure custom service for the project's bonus requirements, resulting in the implementation of an isolated code-execution playground container.
2. **Infrastructure Debugging & Step-by-Step Resolution**: AI assisted in diagnosing system configuration conflicts, tracking down routing bugs (such as pathing errors and internal container failures), and providing commented, step-by-step instructions to ensure correct service orchestration.
3. **Frontend Interface Engineering**: Assisted in designing and structuring the modern UI for the code playground web application, creating an aesthetically continuous, dark-blue system developer dashboard layout complete with dynamic execution states and custom styling.
4. **Documentation Polishing & Technical Auditing**: AI was utilized to draft, format, and audit this README.md file. This included polishing the ideas firstly written and ensuring this readme follows the guidelines of the subject concerning readme specifications.