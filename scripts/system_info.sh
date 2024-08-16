#!/bin/bash

# Función para imprimir líneas divisorias
print_line() {
    printf "%-78s\n" | tr ' ' "-"
}

# Función para imprimir filas con formato
print_row() {
    printf "| %-25s | %-50s |\n" "$1" "$2"
}

# Encabezado de la tabla
echo -e "\n\e[1;34mInformación del Sistema:\e[0m"
print_line
print_row "Componente" "Detalle"
print_line

# Filas con información del sistema
print_row "Nombre del PC" "$(hostname)"
print_row "Sistema Operativo" "$(lsb_release -d | cut -f2)"
print_row "Versión del Kernel" "$(uname -r)"
print_row "Uso de la CPU" "$(top -bn1 | grep 'Cpu(s)' | sed 's/.*, *\([0-9.]*\)%* id.*/\1/')% idle"
print_row "Uso de Memoria RAM" "$(free -h | awk '/^Mem:/ {print $3 "/" $2}')"
print_row "Uso del Disco Duro" "$(df -h --total | grep 'total' | awk '{print $3 "/" $2 " (" $5 " usado)"}')"
print_row "IP Local" "$(hostname -I | awk '{print $1}')"
print_row "IP Pública" "$(curl -s https://api.ipify.org)"
print_line

# Estado de servicios
echo -e "\n\e[1;34mEstado de Servicios:\e[0m"
print_line
print_row "Servicio" "Estado"
print_line
print_row "Docker" "$(systemctl is-active docker)"
print_row "Apache" "$(systemctl is-active apache2)"
print_row "MySQL" "$(systemctl is-active mysql)"
print_line

# Conectividad a Internet
echo -e "\n\e[1;34mConectividad a Internet:\e[0m"
print_line
if ping -c 3 google.com &> /dev/null; then
    print_row "Conectividad" "\e[32mConectado\e[0m"
else
    print_row "Conectividad" "\e[31mDesconectado\e[0m"
fi
print_line
