source ~/.cache/nu/default_config.nu
# nu -c $'register ((which nu_plugin_highlight).path.0)'

def mdcd [name:string] {
    if not ($name | path exists) {
        mkdir $name
    }
    if not ($name | path type) == "dir" {
        return
    }
    cd $name
}