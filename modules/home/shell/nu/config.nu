def mdcd [name:string] {
    if not ($name | path exists) {
        mkdir $name
    }
    if not ($name | path type) == "dir" {
        return
    }
    cd $name
}
