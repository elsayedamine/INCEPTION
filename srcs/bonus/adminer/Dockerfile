FROM debian:12

# Install PHP and wget to download Adminer
RUN apt-get update && apt-get install -y \
    php \
    php-mysql \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Create working directory
WORKDIR /var/www/adminer

# Download the latest stable standalone Adminer script
RUN wget "https://www.adminer.org/latest.php" -O index.php

# Expose Adminer's internal port
EXPOSE 8080

# Start PHP's built-in web server listening on all network interfaces
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/adminer"]