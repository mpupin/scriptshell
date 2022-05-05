#!/bin/bash
fichier=$1
motdepasse=$2
if [ -e $fichier ]
then
    openssl pkcs12 -in $fichier -out $fichier.clecert.pem -nodes -passin pass:$motdepasse
    openssl pkcs12 -in $fichier -out $fichier.cle.pem  -nodes -nocerts -passin pass:$motdepasse
    openssl pkcs12 -in $fichier -out $fichier.cert.pem -nokeys -passin pass:$motdepasse
    mv $fichier.cert.pem /etc/ssl/certs/$fichier.cert.pem
    mv $fichier.cle.pem /etc/ssl/private/$fichier.cle.pem
    mv $fichier.clecert.pem /etc/ssl/private/$fichier.clecert.pem
    echo "Les certificats ont été publiés dans les chemins /etc/ssl/certs/$fichier.cert.pem , /etc/ssl/private/$fichier.cle.pem , /etc/ssl/private/$fichier.clecert.pem"
else
    echo "Le fichier n'existe pas"
    exit 1
fi