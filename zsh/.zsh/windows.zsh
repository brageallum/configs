function git() {
  if $(pwd -P | grep -q "^\/mnt\/c\/*"); then
    git.exe "$@"
  else
    command git "$@"
  fi
}

function dotnet() {
  if $(pwd -P | grep -q "^\/mnt\/c\/*"); then
  dotnet.exe "$@"
  else
    command dotnet "$@"
  fi
}

function yarn() {
  cmd.exe /C "yarn $@"
}
