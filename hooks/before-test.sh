#
# Initialize tests for this project
#

# requires project name
if [[ -z "$2" ]]; then
    echo "You need to provide the type of tests to create! e.g., nimble test project"
    exit 1
fi

local type="$4"
local name="$5"
local inner_dir="/var/www/html"

# install db
nimble install-tests "$project"
