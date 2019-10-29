# copy folders
cp -R "$template_dir"/_conf "$site_dir"
cp -R "$template_dir"/.vscode "$site_dir"

# ignore project directories
cp "$template_dir"/.gitignore.dist "$site_dir"/.gitignore
