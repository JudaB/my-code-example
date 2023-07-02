openssl genpkey -algorithm RSA -out private.key
openssl req -new -key private.key -out certificate.csr
openssl x509 -req -days 365 -in certificate.csr -signkey private.key -out certificate.crt
openssl x509 -in certificate.crt -text -noout

