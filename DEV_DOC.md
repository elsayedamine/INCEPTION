# Developer & Infrastructure Documentation

This guide provides technical instructions for engineers looking to set up, develop, test, or modify this containerized microservice infrastructure stack.

---

## 🛠️ Local Environment Set Up

### 1. System Prerequisites
The deployment machine must have the following system utilities installed locally:
*   GNU Make (`make`)
*   Docker Engine (v20.10+)
*   Docker Compose V2

### 2. Domain Domain Name Resolution (DNS)
To intercept regional domain calls locally, append this mapping route directly inside the host system's configuration file `/etc/hosts`:
```text
127.0.0.1 aelsayed.42.fr
```

### 3. Creating Environment Configurations
The infrastructure relies on local environment variables to establish network parameters. Create an uncommitted file named .env in the root project folder populated with these explicit key mappings:

```bash
DOMAIN_NAME=aelsayed.42.fr
SQL_DATABASE=inception_db
SQL_USER=wp_user
SQL_PASSWORD=secure_password
SQL_ROOT_PASSWORD=root_password
FTP_USER=ftpadmin
FTP_PASSWORD=ftp_password
```

## 🏗️ Orchestration and Build Commands
The root project contains a specialized Makefile designed to encapsulate Docker Compose workflows into clean commands.

```bash
make up       # Compiles custom Dockerfiles, configures networks, and detaches containers.
make down     # Halts service run states safely without altering system volume layers.
make stop     # Pauses the active runtime execution loop of the containers.
make start    # Resumes a previously paused container runtime sequence.
make clean    # Destroys active container environments and private virtual network frameworks.
make fclean   # Performs a deep wipe: clears containers, networks, and deletes all persistent data disks.
make re       # Forces a complete scratch recompilation and initialization sequence.
```

## 💾 Storage Layout and Data Persistence
Data state persistence across container restarts or teardown updates is managed through high-performance Docker Volumes mapped explicitly to local host target directories.

### Local Host Path Framework
Before building the stack, the following target data storage paths must exist on the local host machine:
/home/aelsayed/data/wordpress — Houses all PHP assets, source code configurations, plugins, and custom media uploads.
/home/aelsayed/data/mariadb — Houses raw relational system tables, index trees, and database schemas.

### Architectural Mapping Layer
Inside the docker-compose.yml file, these directory structures are explicitly tied into dedicated volume channels:

```yaml
volumes:
  wordpress_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/aelsayed/data/wordpress

  mariadb_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /home/aelsayed/data/mariadb
```

### Development Implications
- **Persistence**: Deleting containers via make down or make clean does not harm data within these storage mappings.
- **File Changes**:  Modifying code within /home/aelsayed/data/wordpress will immediately reflect inside the running WordPress environment without requiring a container rebuild.
- **Hard Purges**:  Executing make fclean actively removes these folders using host root privileges to restore the environment to an absolute pristine state.