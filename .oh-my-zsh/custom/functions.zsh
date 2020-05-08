# Generate random alphanumeric string
function random_string() {
  openssl rand -base64 500 | tr -dc 'a-zA-Z0-9' | fold -w ${1:-40} | head -n 1
}

# Generate random password
function random_pass() {
  openssl rand -base64 500 | fold -w ${1:-40} | head -n 1
}
