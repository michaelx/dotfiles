# Generate random alphanumeric string
function random() {
  openssl rand -base64 500 | tr -dc 'a-zA-Z0-9' | fold -w ${1:-40} | head -n 1
}
