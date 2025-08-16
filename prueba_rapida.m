## Script de Prueba Rápida - Verificar Funcionamiento
## Ejecutar antes de usar el programa principal

function prueba_rapida()
    fprintf('🧪 INICIANDO PRUEBA RÁPIDA DEL SISTEMA FOURIER\n');
    fprintf('================================================\n\n');
    
    % Verificar paquete de señales
    try
        pkg load signal;
        fprintf('✅ Paquete de señales cargado exitosamente\n');
    catch
        fprintf('❌ ERROR: No se pudo cargar el paquete de señales\n');
        fprintf('   Ejecuta: pkg install -forge signal\n');
        return;
    end
    
    % Verificar funciones básicas
    fprintf('\n🔍 Verificando funciones básicas...\n');
    
    try
        % Probar CaluFFT
        test_signal = sin(2*pi*5*(0:0.001:1));
        [f, ppy, phase] = CaluFFT(test_signal, 1000);
        fprintf('✅ CaluFFT funcionando correctamente\n');
        fprintf('   - Frecuencias: %d componentes\n', length(f));
        fprintf('   - Amplitudes: %d componentes\n', length(ppy));
        fprintf('   - Fases: %d componentes\n', length(phase));
    catch ME
        fprintf('❌ ERROR en CaluFFT: %s\n', ME.message);
        return;
    end
    
    try
        % Probar Init_AimFunction_Enhanced
        sample_seq = 0:0.001:1-0.001;
        [point, t, f, ppy, phase, period] = Init_AimFunction_Enhanced(1, sample_seq, 1000);
        fprintf('✅ Init_AimFunction_Enhanced funcionando correctamente\n');
        fprintf('   - Señal generada: %d muestras\n', length(point));
        fprintf('   - Período: %.2f s\n', period);
    catch ME
        fprintf('❌ ERROR en Init_AimFunction_Enhanced: %s\n', ME.message);
        return;
    end
    
    try
        % Probar background_words
        context = background_words();
        fprintf('✅ background_words funcionando correctamente\n');
        fprintf('   - Longitud del texto: %d caracteres\n', length(context));
    catch ME
        fprintf('❌ ERROR en background_words: %s\n', ME.message);
        return;
    end
    
    try
        % Probar filesave (solo verificar que existe)
        if exist('filesave', 'file')
            fprintf('✅ filesave disponible\n');
        else
            fprintf('❌ ERROR: filesave no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando filesave: %s\n', ME.message);
        return;
    end
    
    % Verificar funciones de visualización
    fprintf('\n🎨 Verificando funciones de visualización...\n');
    
    try
        if exist('draw_all_enhanced', 'file')
            fprintf('✅ draw_all_enhanced disponible\n');
        else
            fprintf('❌ ERROR: draw_all_enhanced no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando draw_all_enhanced: %s\n', ME.message);
        return;
    end
    
    try
        if exist('interactive_3d_window', 'file')
            fprintf('✅ interactive_3d_window disponible\n');
        else
            fprintf('❌ ERROR: interactive_3d_window no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando interactive_3d_window: %s\n', ME.message);
        return;
    end
    
    try
        if exist('export_fourier_data', 'file')
            fprintf('✅ export_fourier_data disponible\n');
        else
            fprintf('❌ ERROR: export_fourier_data no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando export_fourier_data: %s\n', ME.message);
        return;
    end
    
    try
        if exist('draw_dynamic_process_enhanced', 'file')
            fprintf('✅ draw_dynamic_process_enhanced disponible\n');
        else
            fprintf('❌ ERROR: draw_dynamic_process_enhanced no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando draw_dynamic_process_enhanced: %s\n', ME.message);
        return;
    end
    
    % Verificar función principal
    fprintf('\n🎯 Verificando función principal...\n');
    
    try
        if exist('fourier_octave_enhanced', 'file')
            fprintf('✅ fourier_octave_enhanced disponible\n');
        else
            fprintf('❌ ERROR: fourier_octave_enhanced no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando fourier_octave_enhanced: %s\n', ME.message);
        return;
    end
    
    % Verificar script de demostración
    fprintf('\n🎬 Verificando script de demostración...\n');
    
    try
        if exist('demo_enhanced_functions', 'file')
            fprintf('✅ demo_enhanced_functions disponible\n');
        else
            fprintf('❌ ERROR: demo_enhanced_functions no encontrado\n');
            return;
        end
    catch ME
        fprintf('❌ ERROR verificando demo_enhanced_functions: %s\n', ME.message);
        return;
    end
    
    % Resumen final
    fprintf('\n🎉 ¡PRUEBA COMPLETADA EXITOSAMENTE!\n');
    fprintf('=====================================\n');
    fprintf('✅ Todas las funciones están disponibles\n');
    fprintf('✅ El sistema está listo para usar\n');
    fprintf('\n🚀 Para ejecutar el programa principal:\n');
    fprintf('   fourier_octave_enhanced\n');
    fprintf('\n🎬 Para ver la demostración:\n');
    fprintf('   demo_enhanced_functions\n');
    fprintf('\n💡 Para usar el script automático:\n');
    fprintf('   ./ejecutar_fourier.sh\n');
    
    fprintf('\n🎓 ¡El sistema Fourier está funcionando perfectamente!\n');
end 