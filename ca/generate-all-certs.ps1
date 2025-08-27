# List of services and environment
$services = @("auth", "backend", "apigateway", "frontend", "landing", "marketplace", "sp")
$environment = "dev"

$certsDir = "certs"
$keysDir = "keys"
$caCert = "$certsDir\ca-cert.pem"
$caKey = "$keysDir\ca-key.pem"

# Ensure certs and keys directories exist
if (!(Test-Path $certsDir)) { New-Item -ItemType Directory -Path $certsDir | Out-Null }
if (!(Test-Path $keysDir)) { New-Item -ItemType Directory -Path $keysDir | Out-Null }

function New-CA {
    # Create CA if not exists
    if (!(Test-Path $caCert) -or !(Test-Path $caKey)) {
        Write-Host "CA not found. Creating new CA..."
        & openssl req -x509 -nodes -newkey rsa:4096 -keyout $caKey -out $caCert -days 3650 `
            -subj "/CN=ebezard-ca"
        Write-Host "CA created: $caCert and $caKey"
    } else {
        Write-Host "CA already exists."
    }
}

function New-Cert {
    param (
        [string]$name
    )
    $certPath = "$certsDir\$name-$environment-cert.pem"
    $keyPath = "$keysDir\$name-$environment-key.pem"
    $csrPath = "$keysDir\$name-$environment-csr.pem"
    $sanConfig = "$name-$environment-san.cnf"

    # Always use 'localhost' as CN/SAN
    @"
[ req ]
default_bits       = 4096
prompt             = no
default_md         = sha256
distinguished_name = dn
req_extensions     = req_ext

[ dn ]
CN = localhost

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = localhost
"@ | Set-Content $sanConfig

    # Generate key and CSR
    & openssl req -new -nodes -out $csrPath -keyout $keyPath -config $sanConfig

    # Sign the certificate with the CA
    & openssl x509 -req -in $csrPath -CA $caCert -CAkey $caKey -CAcreateserial `
        -out $certPath -days 365 -sha256 -extfile $sanConfig -extensions req_ext

    # Remove temporary files
    Remove-Item $sanConfig, $csrPath
}

Write-Host "Checking for CA..."
New-CA

Write-Host "Generating keys and certificates for all services and their Nginx..."

foreach ($service in $services) {
    # Microservice
    New-Cert $service
    # Nginx for the microservice
    New-Cert "nginx-$service"
}

Write-Host "All keys and certificates have been generated!"
Write-Host "Keys are in $keysDir\, certificates are in $certsDir\."