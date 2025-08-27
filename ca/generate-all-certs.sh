#!/bin/bash

# List of services and environment
SERVICES=("auth" "backend" "apigateway" "frontend" "landing" "marketplace" "sp")
ENVIRONMENT="prod"

CERTS_DIR="certs"
KEYS_DIR="keys"
CA_CERT="$CERTS_DIR/ca-cert.pem"
CA_KEY="$KEYS_DIR/ca-key.pem"

# Ensure certs and keys directories exist
mkdir -p "$CERTS_DIR"
mkdir -p "$KEYS_DIR"

# Create CA if not exists (CA must always be ca-cert.pem and ca-key.pem)
create_ca() {
  if [[ ! -f "$CA_CERT" || ! -f "$CA_KEY" ]]; then
    echo "CA not found. Creating new CA..."
    openssl req -x509 -nodes -newkey rsa:4096 -keyout "$CA_KEY" -out "$CA_CERT" -days 3650 \
      -subj "//CN=ebezard-ca"
    echo "CA created: $CA_CERT and $CA_KEY"
  else
    echo "CA already exists."
  fi
}

generate_cert() {
  local name="$1"
  # Use 'localhost' as CN/SAN for all services
  local cn="localhost"
  local cert_path="$CERTS_DIR/$name-$ENVIRONMENT-cert.pem"
  local key_path="$KEYS_DIR/$name-$ENVIRONMENT-key.pem"
  local csr_path="$KEYS_DIR/$name-$ENVIRONMENT-csr.pem"

  # Create temporary SAN config file
  cat > "$name-$ENVIRONMENT-san.cnf" <<EOF
[ req ]
default_bits       = 4096
prompt             = no
default_md         = sha256
distinguished_name = dn
req_extensions     = req_ext

[ dn ]
CN = $cn

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = $cn
EOF

  # Generate key and CSR
  openssl req -new -nodes -out "$csr_path" -keyout "$key_path" -config "$name-$ENVIRONMENT-san.cnf"

  # Sign the certificate with the CA
  openssl x509 -req -in "$csr_path" -CA "$CA_CERT" -CAkey "$CA_KEY" -CAcreateserial \
    -out "$cert_path" -days 365 -sha256 -extfile "$name-$ENVIRONMENT-san.cnf" -extensions req_ext

  # Remove temporary files
  rm "$name-$ENVIRONMENT-san.cnf" "$csr_path"
}

echo "Checking for CA..."
create_ca

echo "Generating keys and certificates for all services and their Nginx..."

for service in "${SERVICES[@]}"; do
  # Microservice
  generate_cert "$service" "$service-$ENVIRONMENT"
  # Nginx for the microservice
  generate_cert "nginx-$service" "$service-$ENVIRONMENT"
done

echo "All keys and certificates have been generated!"
echo "Keys are in $KEYS_DIR/, certificates are in $CERTS_DIR/"