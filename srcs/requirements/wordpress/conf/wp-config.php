<?php
define('DB_NAME', getenv('SQL_DATABASE'));
define('DB_USER', getenv('SQL_USER'));
define('DB_PASSWORD', getenv('SQL_PASSWORD'));
define('DB_HOST', getenv('MARIADB_HOST'));

define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Authentication keys (can be generated or static)
define('AUTH_KEY',         'put_your_unique_phrase_here');
define('SECURE_AUTH_KEY',  'put_your_unique_phrase_here');
define('LOGGED_IN_KEY',    'put_your_unique_phrase_here');
define('NONCE_KEY',        'put_your_unique_phrase_here');
define('AUTH_SALT',        'put_your_unique_phrase_here');
define('SECURE_AUTH_SALT', 'put_your_unique_phrase_here');
define('LOGGED_IN_SALT',   'put_your_unique_phrase_here');
define('NONCE_SALT',       'put_your_unique_phrase_here');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');