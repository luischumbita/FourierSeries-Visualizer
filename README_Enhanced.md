# Visualización de Series de Fourier - Versión Mejorada V3.0

## Descripción del Proyecto

Este proyecto es una herramienta avanzada de visualización de Series de Fourier desarrollada para GNU Octave. Permite analizar y visualizar cómo diferentes señales pueden ser representadas como superposición de ondas sinusoidales de diferentes frecuencias.

## Características Principales

### 🎯 **Funciones Predefinidas Ampliadas (20 funciones)**
- **Ondas Básicas**: Cuadrada, Triangular, Diente de Sierra, Escalonada
- **Ondas Avanzadas**: Trapezoidal, Rampa Lineal, Senoidal Recortada
- **Señales Moduladas**: AM (Amplitud Modulada), FM (Frecuencia Modulada)
- **Señales Especiales**: Chirp (frecuencia variable), Función Sinc
- **Funciones de Ventana**: Hamming, Hanning, Blackman, Kaiser
- **Ondas Asimétricas**: Cuadrada y Triangular con diferentes ciclos de trabajo
- **Señales Complejas**: Senoidal con múltiples armónicos
- **Simulación de Ruido**: Ondas con ruido simulado para análisis realista

### 🎮 **Controles Interactivos Mejorados**
- **Parámetros Ajustables**: Frecuencia y amplitud personalizables
- **Selección de Armónicos**: Opciones predefinidas (3, 5, 9, 15, 22, 50, 100) o personalizadas
- **Funciones Personalizadas**: Entrada de expresiones matemáticas con validación
- **Controles de Frecuencia**: Ajuste fino de parámetros de frecuencia

### 🖼️ **Visualización Avanzada**
- **Vista 3D Interactiva**: Rotación, zoom y navegación interactiva
- **Gráficos Mejorados**: Colores diferenciados para cada armónico
- **Leyendas Informativas**: Identificación clara de cada componente
- **Ejes Etiquetados**: Etiquetas descriptivas en español

### 📊 **Análisis Dinámico**
- **Proceso de Ajuste Dinámico**: Visualización paso a paso del ajuste de armónicos
- **Controles de Animación**: Reproducir, pausar, reiniciar, velocidad ajustable
- **Métricas en Tiempo Real**: Error RMS, estadísticas de frecuencia y amplitud
- **Rango Configurable**: Control del número máximo de armónicos a visualizar

### 💾 **Exportación de Datos**
- **Múltiples Formatos**: CSV, MAT, TXT
- **Datos Selectivos**: Exportar solo los datos deseados
- **Metadatos Incluidos**: Información de muestreo y fecha de exportación
- **Interfaz Intuitiva**: Diálogo de exportación fácil de usar

## Archivos del Proyecto

### Archivos Principales
- `fourier_octave_enhanced.m` - Programa principal mejorado
- `Init_AimFunction_Enhanced.m` - Funciones predefinidas ampliadas
- `draw_all_enhanced.m` - Visualización mejorada
- `interactive_3d_window.m` - Ventana 3D interactiva
- `export_fourier_data.m` - Exportación de datos
- `draw_dynamic_process_enhanced.m` - Proceso dinámico mejorado

### Archivos Originales (Source/)
- `CaluFFT.m` - Cálculo de FFT
- `GUI_Design.m` - Diseño de interfaz original
- `main.m` - Programa principal original
- Y otros archivos de soporte

## Instalación y Uso

### Requisitos
- GNU Octave 6.0 o superior
- Paquete de procesamiento de señales (`pkg load signal`)

### Instalación
1. Clona o descarga el proyecto
2. Abre Octave en la carpeta del proyecto
3. Ejecuta: `fourier_octave_enhanced`

### Uso Básico
1. **Seleccionar Función**: Elige entre las 20 funciones predefinidas o ingresa una función personalizada
2. **Ajustar Parámetros**: Modifica frecuencia y amplitud según sea necesario
3. **Seleccionar Armónicos**: Elige el número de armónicos para la síntesis
4. **Visualizar Resultados**: Observa la expansión de Fourier en tiempo real

## Funciones Personalizadas

### Sintaxis
- Usa `x` como variable de tiempo
- Expresiones matemáticas estándar de Octave
- Ejemplos válidos:
  - `sin(2*pi*x)` - Onda senoidal
  - `exp(-x)` - Exponencial decreciente
  - `x^2` - Función cuadrática
  - `sinc(x)` - Función sinc
  - `sin(2*pi*x) + 0.5*sin(4*pi*x)` - Onda compleja

### Validación
- Verificación automática de sintaxis
- Mensajes de error descriptivos
- Fallback a función por defecto en caso de error

## Características Técnicas

### Frecuencia de Muestreo
- **Mejorada**: 2048 Hz (vs 1024 Hz original)
- **Resolución**: Mayor precisión en el análisis de frecuencias
- **Rendimiento**: Optimizado para visualizaciones suaves

### Algoritmos
- **FFT**: Transformada Rápida de Fourier
- **Síntesis**: Reconstrucción de señales a partir de armónicos
- **Análisis**: Cálculo de espectros de amplitud y fase

### Interfaz de Usuario
- **Responsiva**: Adaptable a diferentes resoluciones de pantalla
- **Intuitiva**: Controles organizados lógicamente
- **Accesible**: Etiquetas en español y controles claros

## Casos de Uso

### Educación
- **Teoría de Señales**: Comprensión visual de conceptos de Fourier
- **Laboratorios**: Experimentación con diferentes tipos de señales
- **Presentaciones**: Demostraciones interactivas en clase

### Investigación
- **Análisis de Señales**: Estudio de características espectrales
- **Diseño de Filtros**: Visualización de respuestas en frecuencia
- **Procesamiento**: Análisis de señales reales o simuladas

### Desarrollo
- **Prototipado**: Prueba rápida de algoritmos de procesamiento
- **Validación**: Verificación de implementaciones de FFT
- **Documentación**: Generación de gráficos para reportes

## Mejoras Futuras

### Funcionalidades Planificadas
- **Análisis de Señales Reales**: Importación de archivos de audio/video
- **Filtros Digitales**: Implementación de filtros IIR/FIR
- **Análisis Multidimensional**: Extensiones a 2D y 3D
- **Exportación de Animaciones**: Guardado de procesos dinámicos como GIF/MP4

### Optimizaciones Técnicas
- **GPU Acceleration**: Uso de OpenCL para cálculos intensivos
- **Paralelización**: Procesamiento multi-núcleo
- **Memoria**: Gestión optimizada para señales grandes

## Contribuciones

### Cómo Contribuir
1. Fork del proyecto
2. Crear rama para nueva funcionalidad
3. Implementar cambios con documentación
4. Crear Pull Request con descripción detallada

### Áreas de Contribución
- **Nuevas Funciones**: Agregar más tipos de señales
- **Mejoras de UI**: Interfaz más intuitiva
- **Optimizaciones**: Mejor rendimiento y precisión
- **Documentación**: Traducciones y ejemplos adicionales

## Licencia y Créditos

### Idea Original
- **知乎@电工李达康** - Código base en MATLAB
- **Email**: qizhenkang@sina.com

### Adaptación y Mejoras
- **Versión 3.0 Enhanced** - Adaptado para Octave con funcionalidades adicionales
- **Desarrollado por**: Luis Chumbita

### Licencia
- Código original: Derechos reservados del autor
- Mejoras: Disponible para uso educativo y de investigación

## Soporte y Contacto

### Problemas Comunes
- **Paquete Signal**: Asegúrate de cargar `pkg load signal`
- **Memoria**: Para señales grandes, considera reducir la frecuencia de muestreo
- **Rendimiento**: En sistemas lentos, reduce el número máximo de armónicos

### Reportar Bugs
- Describir el problema con pasos para reproducirlo
- Incluir información del sistema (Octave, OS)
- Adjuntar archivos de ejemplo si es posible

---

**¡Disfruta explorando el fascinante mundo de las Series de Fourier con esta herramienta mejorada!** 