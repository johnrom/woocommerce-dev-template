
echo "checking cert for $project"

if [[ ! -f "$nimble_root/_conf/certs/$project.$tld.crt" ]]; then
    echo "$project does not have an SSL cert for HTTPS, generating..."

    nimble cert "$project"
fi
