woocommerce_init(){
    local dir="."
    local inner_dir="/var/www/html"

    if [[ -z "$project" ]]; then
        echo "Please enter a project to initialize! e.g. nimble init myproject"
        return
    fi

    if is_root; then
        local dir="$site_root/$project/www"
        local woo_dir="$dir/wp-content/plugins/woocommerce"
    fi

    if confirm "Would you like to clone WooCommerce?" Y; then
        echo "Cloning git@github.com:woocommerce/woocommerce.git ..."
        git clone "git@github.com:woocommerce/woocommerce.git" "$woo_dir"
    fi

    cd "$woo_dir" && npm_install
    cd -

    local url="$project.$tld"

    if confirm "Would you like to install WordPress?" Y; then
        echo "Installing WP to $dir -> $url"

        ask title "Site Title" "$project"
        ask user "Admin User" "admin" --required
        ask password "Admin Password" "password" --required
        ask email "Admin Email" "$(git config user.email)" --required

        echo "Waiting for WordPress at $dir/wp-config.php"
        while [ ! -f $dir/wp-config.php ]
        do
            sleep 2
        done

        echo "Installing WordPress. This could take a few seconds..."

        until MSYS2_ARG_CONV_EXCL="*" MSYS_NO_PATHCONV=1 wp "$project" core install --path="'$inner_dir'" --url="'$url'" --title="'$title'" --admin_user="'$user'" --admin_password="'$password'" --admin_email="'$email'" --skip-email
        do
            echo "WP Install Failed. Retrying..."
            sleep 2
        done
    fi

    if confirm "Would you like to set up Composer for Unit Testing and Code Sniffing?" Y; then
        echo "Running Composer Install"

        if [[ -z "$(which composer)" ]]; then
            echo "You have to install Composer first!"
        else
            cd $woo_dir && composer install
            cd -
        fi
    fi
}

woocommerce_init "$project"
