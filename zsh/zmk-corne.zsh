# cornev3-firmware — helpers de build y flash para nice!nano v2.
# Cargado desde ~/dotfiles/zsh/.zshrc.

# Ruta del repo y del config dir
export ZMK_CORNE_DIR="$HOME/leandro-git/cornev3-firmware"
export ZMK_CORNE_CFG="$ZMK_CORNE_DIR/config"

# Workaround: en Arch ccache a veces queda con libfmt vieja tras un libfmt bump.
# Si /usr/bin/ccache no resuelve sus libs, deshabilitamos ccache en Zephyr.
if [ -x /usr/bin/ccache ] && ! /usr/bin/ccache --version >/dev/null 2>&1; then
    export USE_CCACHE=0
    export CMAKE_C_COMPILER_LAUNCHER=
    export CMAKE_CXX_COMPILER_LAUNCHER=
fi

# ---------------------------------------------------------------------------
# Build
# ---------------------------------------------------------------------------

# Compila una mitad del split.  $1 = left|right.  Resto = flags extra (ej: -p).
_zmk_corne_build_one() {
    local side=$1; shift
    # El right lleva nice!view (display SPI sobre el adapter del nice!nano).
    local shields="cornev3_${side}"
    [[ "$side" == "right" ]] && shields="cornev3_right nice_view_adapter nice_view"
    west build "$@" -s zmk/app \
        -b nice_nano/nrf52840/zmk \
        -d "$ZMK_CORNE_DIR/build/cornev3_${side}" \
        -- -DSHIELD="$shields" \
           -DZMK_CONFIG="$ZMK_CORNE_CFG"
}

# Compila ambas mitades del teclado completo (split BLE).
# Pasale flags adicionales a west: `zmk-corne -p` para pristine, etc.
zmk-corne() {
    ( cd "$ZMK_CORNE_DIR" || return 1
      _zmk_corne_build_one left  "$@" || return 1
      _zmk_corne_build_one right "$@" || return 1
      echo
      echo "OK — UF2s en:"
      echo "  $ZMK_CORNE_DIR/build/cornev3_left/zephyr/zmk.uf2"
      echo "  $ZMK_CORNE_DIR/build/cornev3_right/zephyr/zmk.uf2" )
}

# Atajo: build pristine (limpia build dir antes de compilar).
zmk-corne-clean() { zmk-corne -p always; }

# Variante standalone debug (USB-only, USB CDC logs en /dev/ttyACM0).
zmk-corne-debug() {
    ( cd "$ZMK_CORNE_DIR" || return 1
      west build "$@" -s zmk/app -b nice_nano/nrf52840/zmk \
          -d "$ZMK_CORNE_DIR/build/cornev3_left_debug" \
          -- -DSHIELD="cornev3_left_debug" \
             -DZMK_CONFIG="$ZMK_CORNE_CFG" \
             -DSNIPPET=zmk-usb-logging || return 1
      west build "$@" -s zmk/app -b nice_nano/nrf52840/zmk \
          -d "$ZMK_CORNE_DIR/build/cornev3_right_debug" \
          -- -DSHIELD="cornev3_right_debug" \
             -DZMK_CONFIG="$ZMK_CORNE_CFG" \
             -DSNIPPET=zmk-usb-logging || return 1 )
}

zmk-corne-debug-clean() { zmk-corne-debug -p always; }

# ---------------------------------------------------------------------------
# Detect
# ---------------------------------------------------------------------------

# Devuelve por stdout el /dev/sdX del NICENANO en bootloader, vacio si no esta.
_zmk_nicenano_dev() {
    lsblk -o NAME,LABEL -nr | awk '$2=="NICENANO"{print "/dev/"$1; exit}'
}

# Espera (con timeout) hasta que aparezca el NICENANO.  $1 = timeout en seg (default 30).
_zmk_wait_nicenano() {
    local timeout=${1:-30}
    local dev
    echo "Esperando NICENANO en modo bootloader (doble tap en RESET)..." >&2
    for i in $(seq 1 $timeout); do
        dev=$(_zmk_nicenano_dev)
        if [[ -n "$dev" ]]; then
            echo "  encontrado: $dev" >&2
            print -- "$dev"
            return 0
        fi
        sleep 1
    done
    echo "  timeout tras ${timeout}s — NICENANO no aparecio." >&2
    return 1
}

# Comando explicito para chequear si esta en bootloader.
zmk-detect() {
    local dev
    dev=$(_zmk_nicenano_dev)
    if [[ -n "$dev" ]]; then
        echo "NICENANO detectado en $dev"
        lsblk -o NAME,LABEL,SIZE,MOUNTPOINT "$dev"
    else
        echo "NICENANO no detectado.  Hace doble tap en RESET del nice!nano."
        return 1
    fi
}

# ---------------------------------------------------------------------------
# Flash
# ---------------------------------------------------------------------------

# Flashea un UF2 al NICENANO (espera a que aparezca, monta, copia, espera unmount).
# $1 = side (left|right|left_debug|right_debug)
_zmk_corne_flash() {
    local side=$1
    local uf2="$ZMK_CORNE_DIR/build/cornev3_${side}/zephyr/zmk.uf2"
    local dev mnt

    if [[ ! -f "$uf2" ]]; then
        echo "ERROR: no existe $uf2" >&2
        echo "       compila primero con 'zmk-corne' o 'zmk-corne-debug'." >&2
        return 1
    fi

    echo "==> Flashing ${side} half"
    dev=$(_zmk_wait_nicenano 30) || return 1

    mnt=$(udisksctl mount -b "$dev" 2>/dev/null | sed 's/.* at //' | tr -d '.')
    [[ -z "$mnt" ]] && { echo "ERROR: no pude montar $dev" >&2; return 1; }

    echo "  copiando $(basename "$uf2") a $mnt ..."
    cp "$uf2" "$mnt/" && sync

    udisksctl unmount -b "$dev" 2>/dev/null
    echo "OK — el nice!nano se reinicia solo en unos segundos."
}
zmk-flash-left()  { _zmk_corne_flash left;  }
zmk-flash-right() { _zmk_corne_flash right; }

# Variantes para los debug builds standalone.
zmk-flash-left-debug()  { _zmk_corne_flash left_debug;  }
zmk-flash-right-debug() { _zmk_corne_flash right_debug; }
