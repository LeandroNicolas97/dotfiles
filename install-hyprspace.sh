#!/bin/bash

###############################################################################
# Script para instalar el plugin hyprspace de Hyprland
###############################################################################

set -e

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}▶ Instalando plugin hyprspace para Hyprland${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"

# Verificar que Hyprland está instalado
if ! command -v hyprctl &> /dev/null; then
    echo -e "${RED}✗ Error: Hyprland no está instalado${NC}"
    exit 1
fi

echo -e "${YELLOW}⚠ Este script necesita permisos sudo para inicializar hyprpm${NC}\n"

# Inicializar hyprpm (necesita sudo la primera vez)
echo -e "${BLUE}→ Inicializando hyprpm...${NC}"
sudo hyprpm update

# Agregar el repositorio de hyprspace
echo -e "\n${BLUE}→ Agregando repositorio de hyprspace...${NC}"
hyprpm add https://github.com/KZDKM/Hyprspace

# Habilitar el plugin
echo -e "\n${BLUE}→ Habilitando plugin hyprspace...${NC}"
hyprpm enable Hyprspace

# Verificar instalación
echo -e "\n${BLUE}→ Verificando instalación...${NC}"
hyprpm list

echo -e "\n${GREEN}✓ Plugin hyprspace instalado correctamente${NC}"
echo -e "\n${YELLOW}⚠ Para aplicar los cambios, recarga Hyprland:${NC}"
echo -e "  ${BLUE}hyprctl reload${NC}"
echo -e "  o presiona ${BLUE}Super + Shift + R${NC}\n"
