#!/bin/bash

###############################################################################
# Script de Sincronización de Dotfiles
# Mantiene actualizados los dotfiles entre múltiples máquinas
###############################################################################

# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
cat << "EOF"
╔═══════════════════════════════════════════════════════════╗
║        Sincronizador de Dotfiles entre Laptops           ║
╚═══════════════════════════════════════════════════════════╝
EOF
echo -e "${NC}\n"

# Verificar que estamos en el directorio correcto
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠ Error: Ejecuta este script desde ~/dotfiles${NC}"
    exit 1
fi

# ===========================================================================
# FUNCIÓN: Pull (Bajar cambios desde GitHub)
# ===========================================================================
pull_changes() {
    echo -e "${BLUE}▶ Descargando cambios desde GitHub...${NC}"

    # Guardar cambios locales si hay
    if ! git diff-index --quiet HEAD --; then
        echo -e "${YELLOW}⚠ Tienes cambios locales. Guardando...${NC}"
        git stash
        STASHED=true
    fi

    # Pull desde GitHub
    git fetch origin
    git pull origin main

    # Restaurar cambios locales si se guardaron
    if [ "$STASHED" = true ]; then
        echo -e "${YELLOW}⚠ Restaurando cambios locales...${NC}"
        git stash pop
    fi

    echo -e "${GREEN}✓ Cambios descargados${NC}\n"
}

# ===========================================================================
# FUNCIÓN: Push (Subir cambios a GitHub)
# ===========================================================================
push_changes() {
    echo -e "${BLUE}▶ Subiendo cambios a GitHub...${NC}"

    # Actualizar lista de paquetes
    echo "→ Actualizando lista de paquetes..."
    pacman -Qqe | grep -v "^#" > packages.txt
    pacman -Qqm | grep -v "^#" > packages-aur.txt

    # Mostrar cambios
    echo -e "\n${YELLOW}Cambios detectados:${NC}"
    git status --short

    # Pedir confirmación
    echo -e "\n${YELLOW}¿Subir estos cambios a GitHub? (s/n)${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Ss]$ ]]; then
        echo "Cancelado"
        exit 0
    fi

    # Pedir mensaje de commit
    echo -e "\n${YELLOW}Mensaje del commit:${NC}"
    read -r message
    if [ -z "$message" ]; then
        message="Update dotfiles from $(hostname)"
    fi

    # Commit y push
    git add .
    git commit -m "$message"
    git push origin main

    echo -e "\n${GREEN}✓ Cambios subidos a GitHub${NC}\n"
}

# ===========================================================================
# FUNCIÓN: Sync (Pull + Push)
# ===========================================================================
sync_all() {
    pull_changes

    # Reinstalar paquetes que puedan faltar
    echo -e "${BLUE}▶ Verificando paquetes faltantes...${NC}"

    # Paquetes faltantes
    MISSING=$(comm -23 <(sort packages.txt) <(pacman -Qq | sort) | wc -l)

    if [ "$MISSING" -gt 0 ]; then
        echo -e "${YELLOW}⚠ Faltan $MISSING paquetes${NC}"
        echo -e "${YELLOW}¿Instalar paquetes faltantes? (s/n)${NC}"
        read -r response
        if [[ "$response" =~ ^[Ss]$ ]]; then
            comm -23 <(sort packages.txt) <(pacman -Qq | sort) | sudo pacman -S --needed -
        fi
    else
        echo -e "${GREEN}✓ Todos los paquetes instalados${NC}"
    fi

    push_changes
}

# ===========================================================================
# FUNCIÓN: Status
# ===========================================================================
show_status() {
    echo -e "${BLUE}▶ Estado actual:${NC}\n"

    # Git status
    git status

    # Paquetes faltantes
    MISSING=$(comm -23 <(sort packages.txt) <(pacman -Qq | sort) | wc -l)
    echo -e "\n${YELLOW}Paquetes faltantes: $MISSING${NC}"

    # Última sincronización
    LAST_SYNC=$(git log -1 --format="%ar - %s")
    echo -e "${YELLOW}Último commit: $LAST_SYNC${NC}\n"
}

# ===========================================================================
# MENÚ PRINCIPAL
# ===========================================================================

case "${1:-menu}" in
    pull)
        pull_changes
        ;;
    push)
        push_changes
        ;;
    sync)
        sync_all
        ;;
    status)
        show_status
        ;;
    menu|*)
        echo "Uso: $0 {pull|push|sync|status}"
        echo ""
        echo "Comandos:"
        echo "  pull    - Descargar cambios desde GitHub"
        echo "  push    - Subir cambios a GitHub"
        echo "  sync    - Sincronizar (pull + push)"
        echo "  status  - Ver estado actual"
        echo ""
        ;;
esac
