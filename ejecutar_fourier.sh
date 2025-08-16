#!/bin/bash

# Script de ejecución rápida para Octave Fourier Clase
# Autor: Luis Chumbita
# Adapted from original MATLAB code by 知乎@电工李达康

echo "🚀 Iniciando Octave Fourier Clase - Versión Mejorada V3.0"
echo "========================================================"
echo ""

# Verificar si Octave está instalado
if ! command -v octave &> /dev/null; then
    echo "❌ ERROR: Octave no está instalado."
    echo "   Por favor instala Octave primero:"
    echo "   sudo apt install octave  # Ubuntu/Debian"
    echo "   sudo dnf install octave  # Fedora"
    echo "   sudo pacman -S octave    # Arch Linux"
    echo "   brew install octave      # macOS"
    exit 1
fi

echo "✅ Octave encontrado: $(octave --version | head -n1)"
echo ""

# Verificar si estamos en la carpeta correcta
if [ ! -f "fourier_octave_enhanced.m" ]; then
    echo "❌ ERROR: No se encontró el archivo principal."
    echo "   Asegúrate de ejecutar este script desde la carpeta OctaveFourierClase"
    echo "   cd OctaveFourierClase"
    echo "   ./ejecutar_fourier.sh"
    exit 1
fi

echo "📁 Carpeta correcta detectada"
echo "📋 Archivos disponibles:"
ls -la *.m | grep -E "(fourier|demo|draw|Init|interactive|export)" | while read line; do
    echo "   $line"
done
echo ""

# Función para ejecutar con interfaz gráfica
run_with_gui() {
    echo "🎮 Iniciando Octave con interfaz gráfica..."
    echo "   Cargando paquete de señales..."
    echo "   Ejecutando programa principal..."
    echo ""
    echo "💡 Consejos de uso:"
    echo "   - Usa el menú 'Archivo' para guardar imágenes"
    echo "   - Prueba diferentes funciones predefinidas"
    echo "   - Experimenta con funciones personalizadas"
    echo "   - Usa la vista 3D interactiva"
    echo ""
    
    octave --gui --eval "
        try
            pkg load signal;
            fprintf('✅ Paquete de señales cargado exitosamente\\n');
            fprintf('🚀 Ejecutando programa principal...\\n');
            fourier_octave_enhanced;
        catch ME
            fprintf('❌ Error: %s\\n', ME.message);
            fprintf('💡 Asegúrate de que todos los archivos .m estén en la misma carpeta\\n');
        end
    "
}

# Función para ejecutar en modo consola
run_console() {
    echo "💻 Iniciando Octave en modo consola..."
    echo "   Cargando paquete de señales..."
    echo "   Ejecutando programa principal..."
    echo ""
    
    octave --no-gui --eval "
        try
            pkg load signal;
            fprintf('✅ Paquete de señales cargado exitosamente\\n');
            fprintf('🚀 Ejecutando programa principal...\\n');
            fourier_octave_enhanced;
        catch ME
            fprintf('❌ Error: %s\\n', ME.message);
            fprintf('💡 Asegúrate de que todos los archivos .m estén en la misma carpeta\\n');
        end
    "
}

# Función para ejecutar demostración
run_demo() {
    echo "🎬 Iniciando demostración de funciones..."
    echo "   Cargando paquete de señales..."
    echo "   Ejecutando script de demostración..."
    echo ""
    
    octave --no-gui --eval "
        try
            pkg load signal;
            fprintf('✅ Paquete de señales cargado exitosamente\\n');
            fprintf('🎬 Ejecutando demostración...\\n');
            demo_enhanced_functions;
        catch ME
            fprintf('❌ Error: %s\\n', ME.message);
            fprintf('💡 Asegúrate de que todos los archivos .m estén en la misma carpeta\\n');
        end
    "
}

# Menú de opciones
echo "🎯 Selecciona el modo de ejecución:"
echo "   1) 🎮 Interfaz gráfica completa (recomendado)"
echo "   2) 💻 Modo consola (sin gráficos)"
echo "   3) 🎬 Solo demostración (sin interfaz principal)"
echo "   4) ❌ Salir"
echo ""
read -p "   Ingresa tu opción (1-4): " choice

case $choice in
    1)
        run_with_gui
        ;;
    2)
        run_console
        ;;
    3)
        run_demo
        ;;
    4)
        echo "👋 ¡Hasta luego!"
        exit 0
        ;;
    *)
        echo "❌ Opción inválida. Ejecutando interfaz gráfica por defecto..."
        run_with_gui
        ;;
esac

echo ""
echo "🎉 ¡Programa finalizado!"
echo "💡 Para más información, consulta: README_Enhanced.md"
echo "📚 Para ayuda de instalación: INSTALAR_Y_EJECUTAR.md" 