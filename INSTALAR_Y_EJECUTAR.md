# 🚀 GUÍA DE INSTALACIÓN Y EJECUCIÓN - Octave Fourier Clase

## 📋 Requisitos Previos

### 1. **Instalar GNU Octave**
```bash
# En Ubuntu/Debian:
sudo apt update
sudo apt install octave

# En Fedora:
sudo dnf install octave

# En Arch Linux:
sudo pacman -S octave

# En macOS (con Homebrew):
brew install octave
```

### 2. **Verificar la Instalación**
```bash
octave --version
```

## 🔧 Configuración Inicial

### 1. **Abrir Octave**
```bash
octave
```

### 2. **Cargar Paquete de Señales (OBLIGATORIO)**
```octave
pkg load signal
```

### 3. **Verificar Paquetes Instalados**
```octave
pkg list
```

## 📁 Estructura de Archivos

```
OctaveFourierClase/
├── fourier_octave_enhanced.m      # 🎯 PROGRAMA PRINCIPAL
├── Init_AimFunction_Enhanced.m    # 🔧 Funciones predefinidas
├── draw_all_enhanced.m            # 📊 Visualización mejorada
├── interactive_3d_window.m        # 🎮 Ventana 3D interactiva
├── export_fourier_data.m          # 💾 Exportación de datos
├── draw_dynamic_process_enhanced.m # ⚡ Proceso dinámico
├── demo_enhanced_functions.m      # 🎬 Script de demostración
└── README_Enhanced.md             # 📖 Documentación completa
```

## 🚀 Cómo Ejecutar

### **Opción 1: Desde la Línea de Comandos**
```bash
# Navegar a la carpeta
cd OctaveFourierClase

# Ejecutar Octave
octave

# Dentro de Octave, cargar paquete y ejecutar
pkg load signal
fourier_octave_enhanced
```

### **Opción 2: Desde Octave GUI**
```bash
# Abrir Octave
octave --gui

# En la interfaz gráfica:
# 1. File → Open → Navegar a OctaveFourierClase
# 2. Abrir fourier_octave_enhanced.m
# 3. Ejecutar (F5 o Run)
```

### **Opción 3: Script de Demostración**
```bash
# Para ver todas las funciones en acción:
cd OctaveFourierClase
octave
pkg load signal
demo_enhanced_functions
```

## 🎯 Funciones Disponibles

### **Funciones Predefinidas (20 total)**
1. **Onda Cuadrada** - Señal digital básica
2. **Onda Triangular** - Señal analógica suave
3. **Diente de Sierra** - Señal de barrido
4. **Onda Escalonada** - Función Heaviside
5. **Tren de Pulsos** - Comb de Dirac
6. **Onda Trapezoidal** - Señal de control
7. **Rampa Lineal** - Función de crecimiento
8. **Onda Senoidal Recortada** - Con limitación
Y un largo etc...!

### **Funciones Personalizadas**
- Sintaxis: `sin(2*pi*x)`, `exp(-x)`, `x^2`, etc.
- Variable: Usar `x` como variable de tiempo
- Validación automática de sintaxis

## 🎮 Controles de la Interfaz

### **Panel Principal**
- **Selección de Función**: Radio buttons para predefinidas vs personalizadas
- **Parámetros**: Frecuencia y amplitud ajustables
- **Armónicos**: Selección predefinida o personalizada
- **Botones de Acción**: Proceso dinámico, vista 3D, exportación

### **Ventanas Adicionales**
- **3D Interactiva**: Rotación, zoom, auto-rotación
- **Proceso Dinámico**: Animación controlada con métricas
- **Exportación**: CSV, MAT, TXT con datos selectivos

## 🔧 Solución de Problemas

### **Error: "pkg load signal"**
```octave
# Instalar paquete si no está disponible
pkg install -forge signal
pkg load signal
```

### **Error: "function not found"**
```octave
# Verificar que estés en la carpeta correcta
pwd
ls *.m
```

### **Error: "Graphics not available"**
```bash
# Instalar dependencias de gráficos
sudo apt install octave-gui
# O usar versión sin GUI
octave --no-gui
```

### **Rendimiento Lento**
```octave
% Reducir frecuencia de muestreo en el código
SampleFreq = 1024; % En lugar de 2048
```

## 📚 Ejemplos de Uso

### **Ejemplo 1: Onda Cuadrada Básica**
```octave
pkg load signal
fourier_octave_enhanced
% Seleccionar "Onda Cuadrada" en el menú
% Ajustar frecuencia a 5 Hz
% Usar 10 armónicos
```

### **Ejemplo 2: Función Personalizada**
```octave
% En la interfaz, seleccionar "Personalizada"
% Ingresar: sin(2*pi*3*x) + 0.5*sin(2*pi*6*x)
% Ajustar parámetros según necesidad
```

### **Ejemplo 3: Análisis Dinámico**
```octave
% Hacer clic en "Ver Proceso de Ajuste Dinámico"
% Usar controles de reproducción
% Observar convergencia de armónicos
```

## 🎓 Para Uso Educativo

### **En el Aula**
1. **Demostración**: Mostrar diferentes tipos de señales
2. **Comparación**: Contrastar espectros de frecuencia
3. **Experimentación**: Cambiar parámetros en tiempo real
4. **Análisis**: Estudiar convergencia de series

### **Laboratorio**
1. **Mediciones**: Comparar señales teóricas vs reales
2. **Análisis**: Estudiar efectos de ruido
3. **Diseño**: Crear señales con características específicas
4. **Reportes**: Exportar datos para análisis posterior

## 🚀 Próximos Pasos

### **Mejoras Futuras**
- Importación de señales reales (audio, video)
- Filtros digitales IIR/FIR
- Análisis multidimensional (2D, 3D)
- Exportación de animaciones

### **Contribuciones**
- Agregar nuevas funciones
- Mejorar interfaz de usuario
- Optimizar rendimiento
- Traducir a más idiomas

---

## 🎉 ¡Listo para Usar!

**Comando de ejecución principal:**
```bash
cd OctaveFourierClase
octave
pkg load signal
fourier_octave_enhanced
```

**Para demostración completa:**
```bash
demo_enhanced_functions
```

**¡Disfruta explorando el fascinante mundo de las Series de Fourier! 🎓📊** 