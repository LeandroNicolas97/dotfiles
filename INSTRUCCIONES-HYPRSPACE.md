# Instrucciones para instalar el plugin Hyprspace

## ✅ Errores solucionados
He comentado temporalmente la configuración del plugin hyprspace en tu `hyprland.conf`.
Ahora Hyprland funciona **sin errores**.

## 🎯 ¿Qué es Hyprspace?
Es un plugin que muestra un overview de todos tus workspaces (similar a Mission Control de macOS o el overview de GNOME).
Tu configuración lo usa para Super+Tab.

## 📦 Cómo instalarlo (cuando quieras)

### Opción 1: Instalación rápida (RECOMENDADA)
Ejecuta este comando en tu terminal (te pedirá contraseña para sudo):
```bash
sudo hyprpm update && hyprpm add https://github.com/KZDKM/Hyprspace && hyprpm enable Hyprspace && hyprctl reload
```

### Opción 2: Paso a paso
```bash
# 1. Inicializar hyprpm (necesita sudo la primera vez, te pedirá contraseña)
sudo hyprpm update

# 2. Agregar el repositorio de hyprspace
hyprpm add https://github.com/KZDKM/Hyprspace

# 3. Habilitar el plugin
hyprpm enable Hyprspace

# 4. Verificar que se instaló correctamente
hyprpm list

# 5. Recargar Hyprland
hyprctl reload
```

## 🔄 Después de instalar
1. Descomenta las líneas en `~/dotfiles/hyprland/hyprland.conf`:
   - Línea 54: `exec-once = hyprpm reload -n`
   - Líneas 76-122: Configuración del plugin
   - Líneas 320-340: Keybindings de overview

2. Recarga Hyprland con `Super + Shift + R` o `hyprctl reload`

3. Prueba presionar `Super + Tab` para abrir el overview

## ℹ️ Notas importantes
- No necesitas instalar el plugin ahora, Hyprland funciona perfectamente sin él
- El plugin es solo para la funcionalidad de overview (Super+Tab)
- Todas las demás funciones de tu configuración funcionan correctamente
- Cuando instales el plugin, automáticamente se compilará para tu versión de Hyprland
