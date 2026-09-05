def mdcd [name:string] {
    if not ($name | path exists) {
        mkdir $name
    }
    if not ($name | path type) == "dir" {
        return
    }
    cd $name
}


$env.config.keybindings ++= [
    {
        name: completion_menu
        modifier: control
        keycode: char_t
        mode: [emacs vi_insert vi_normal helix_normal helix_select helix_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menunext }
                { edit: complete }
            ]
        }
    }
    {
        name: ide_completion_menu
        modifier: none
        keycode: tab
        mode: [emacs vi_insert vi_normal helix_normal helix_select helix_insert]
        event: {
            until: [
                { send: menu name: completion_menu }
                { send: menunext }
                { edit: complete }
            ]
        }
    }
]
