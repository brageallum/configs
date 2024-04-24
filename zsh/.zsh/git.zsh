unalias gp
function gp() {
    git fetch && git rebase
}

unalias gs
function gs() {
    git status "$@"
}

unalias gsv
function gsv() {
    git status -v
}

unalias ga
function ga() {
    git add "$@"
}

unalias gl
function gl() {
    local number=${1:-3}  # Defaults to 3 if no argument is provided
    git log -n $number
}

unalias gup
function gup() {
    local gitRoot=$(git rev-parse --show-toplevel)
    local scriptPath="$gitRoot/.git/hooks/validate.sh"

    if [ -x "$scriptPath" ]; then  # Check if the script is executable
        if "$scriptPath" "$@"; then  # Pass all arguments to the script
            git push
        else
            echo "Validation failed. Push aborted."
            return 1
        fi
    else
        echo "Validation script not found or not executable."
        return 1
    fi
}


