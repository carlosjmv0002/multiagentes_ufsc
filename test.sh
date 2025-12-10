#!/bin/bash

echo "=========================================="
echo "Smart Home - Testes Automatizados"
echo "=========================================="
echo ""
echo "Executando os 3 cenários:"
echo "1. Proprietário chega em casa"
echo "2. Proprietário sai de casa"
echo "3. Intruso detectado"
echo ""
echo "=========================================="
echo ""

./gradlew run --args="main-test.jcm"
