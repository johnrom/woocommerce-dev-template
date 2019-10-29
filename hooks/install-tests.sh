
# requires project name
if [[ -z "$1" ]]; then
    echo "You need to provide the name of the project where you're developing WooCommerce! e.g., nimble install-tests my-woocommerce-project"
    echo "This reflects your directory structure, e.g., nimble/sites/{my-woocommerce-project}"
    exit 1
fi

local inner_dir="/var/www/html"

if [ ! -d "$site_root/$project" ]; then
    echo "Project $project does not exist"
    exit 1
fi

if [ ! -d "$site_root/$project/www/wp-content/plugins/woocommerce/tests" ]; then
    echo "$project's WooCommerce doesn't appear to have been installed yet!"
    exit 1
fi

bashitup $project "export WP_CORE_DIR=$inner_dir && cd $inner_dir/wp-content/plugins/woocommerce && export WP_TESTS_DIR=$inner_dir/tests && ./tests/bin/install.sh woootests root example mysql"
