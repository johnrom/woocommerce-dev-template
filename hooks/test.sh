local inner_dir="/var/www/html"

bashitup "$project" "export WP_CORE_DIR=$inner_dir && cd $inner_dir/wp-content/plugins/woocommerce && export WP_TESTS_DIR=$inner_dir/tests && XDEBUG_CONFIG='' phpunit ${*:6}"
