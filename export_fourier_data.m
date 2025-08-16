function export_fourier_data(point, t, f, ppy, phase, period)
    % Export Fourier analysis data to various formats
    
    % Create export dialog
    export_fig = figure('Name', 'Exportar Datos de Fourier', 'Position', [300, 300, 400, 300], ...
                        'Color', [0.94, 0.94, 0.94], 'MenuBar', 'none', 'NumberTitle', 'off');
    
    % Title
    uicontrol('Style', 'text', 'String', 'Exportar Datos de Análisis de Fourier', ...
              'Position', [50, 250, 300, 30], 'FontSize', 14, 'FontWeight', 'bold', ...
              'HorizontalAlignment', 'center', 'BackgroundColor', [0.94, 0.94, 0.94]);
    
    % File name input
    uicontrol('Style', 'text', 'String', 'Nombre del archivo:', ...
              'Position', [50, 200, 100, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    filename_edit = uicontrol('Style', 'edit', 'String', 'fourier_data', ...
                              'Position', [50, 170, 200, 25], 'FontSize', 10);
    
    % Format selection
    uicontrol('Style', 'text', 'String', 'Formato de exportación:', ...
              'Position', [50, 140, 150, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    format_popup = uicontrol('Style', 'popupmenu', 'String', 'CSV (.csv)|MAT (.mat)|TXT (.txt)', ...
                            'Position', [50, 110, 150, 25], 'FontSize', 10);
    
    % Data selection checkboxes
    uicontrol('Style', 'text', 'String', 'Datos a exportar:', ...
              'Position', [50, 80, 150, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    checkbox_time = uicontrol('Style', 'checkbox', 'String', 'Señal temporal', ...
                              'Position', [50, 55, 120, 20], 'Value', 1, 'BackgroundColor', [0.94, 0.94, 0.94]);
    
    checkbox_freq = uicontrol('Style', 'checkbox', 'String', 'Espectro de frecuencia', ...
                              'Position', [50, 35, 120, 20], 'Value', 1, 'BackgroundColor', [0.94, 0.94, 0.94]);
    
    checkbox_phase = uicontrol('Style', 'checkbox', 'String', 'Espectro de fase', ...
                               'Position', [50, 15, 120, 20], 'Value', 1, 'BackgroundColor', [0.94, 0.94, 0.94]);
    
    % Export button
    export_btn = uicontrol('Style', 'pushbutton', 'String', 'Exportar', ...
                           'Position', [280, 170, 80, 30], 'FontSize', 12, 'FontWeight', 'bold', ...
                           'BackgroundColor', [0.2, 0.6, 1.0], 'ForegroundColor', [1, 1, 1], ...
                           'Callback', @do_export);
    
    % Cancel button
    cancel_btn = uicontrol('Style', 'pushbutton', 'String', 'Cancelar', ...
                           'Position', [280, 130, 80, 30], 'FontSize', 12, ...
                           'BackgroundColor', [0.8, 0.8, 0.8], 'Callback', 'close(gcf)');
    
    % Export function
    function do_export(src, event)
        filename = get(filename_edit, 'String');
        if isempty(filename)
            errordlg('Por favor ingrese un nombre de archivo válido.', 'Error');
            return;
        end
        
        format_idx = get(format_popup, 'Value');
        format_names = {'csv', 'mat', 'txt'};
        format_ext = format_names{format_idx};
        
        % Check if any data is selected
        export_time = get(checkbox_time, 'Value');
        export_freq = get(checkbox_freq, 'Value');
        export_phase = get(checkbox_phase, 'Value');
        
        if ~export_time && ~export_freq && ~export_phase
            errordlg('Por favor seleccione al menos un tipo de datos para exportar.', 'Error');
            return;
        end
        
        % Get file path
        [filepath, filename_only] = fileparts(filename);
        if isempty(filepath)
            filepath = pwd;
        end
        full_filename = fullfile(filepath, [filename_only '.' format_ext]);
        
        try
            switch format_ext
                case 'csv'
                    export_to_csv(full_filename, export_time, export_freq, export_phase);
                case 'mat'
                    export_to_mat(full_filename, export_time, export_freq, export_phase);
                case 'txt'
                    export_to_txt(full_filename, export_time, export_freq, export_phase);
            end
            
            msgbox(sprintf('Datos exportados exitosamente a:\n%s', full_filename), 'Exportación Exitosa');
            close(export_fig);
            
        catch ME
            errordlg(sprintf('Error al exportar datos:\n%s', ME.message), 'Error de Exportación');
        end
    end
    
    % CSV export function
    function export_to_csv(filename, export_time, export_time, export_freq, export_phase)
        % Prepare data for CSV export
        data_cells = {};
        headers = {};
        
        if export_time
            % Time domain data
            time_data = [t; point];
            data_cells{end+1} = time_data;
            headers{end+1} = {'Tiempo', 'Amplitud'};
        end
        
        if export_freq
            % Frequency domain data
            freq_data = [f; ppy];
            data_cells{end+1} = freq_data;
            headers{end+1} = {'Frecuencia_Hz', 'Amplitud'};
        end
        
        if export_phase
            % Phase data
            phase_data = [f; phase];
            data_cells{end+1} = phase_data;
            headers{end+1} = {'Frecuencia_Hz', 'Fase_rad'};
        end
        
        % Write CSV file
        fid = fopen(filename, 'w');
        if fid == -1
            error('No se pudo crear el archivo CSV');
        end
        
        try
            % Write headers
            for i = 1:length(headers)
                fprintf(fid, '%s,%s\n', headers{i}{1}, headers{i}{2});
                % Write data
                data = data_cells{i};
                for j = 1:size(data, 2)
                    fprintf(fid, '%.6f,%.6f\n', data(1,j), data(2,j));
                end
                fprintf(fid, '\n'); % Empty line between sections
            end
        finally
            fclose(fid);
        end
    end
    
    % MAT export function
    function export_to_mat(filename, export_time, export_freq, export_phase)
        % Prepare data structure
        export_data = struct();
        
        if export_time
            export_data.time = t;
            export_data.signal = point;
        end
        
        if export_freq
            export_data.frequency = f;
            export_data.amplitude = ppy;
        end
        
        if export_phase
            export_data.phase = phase;
        end
        
        % Add metadata
        export_data.sampling_frequency = 2048; % This should be passed as parameter
        export_data.period = period;
        export_data.export_date = datestr(now);
        
        % Save MAT file
        save(filename, '-struct', 'export_data');
    end
    
    % TXT export function
    function export_to_txt(filename, export_time, export_freq, export_phase)
        % Prepare data for TXT export
        fid = fopen(filename, 'w');
        if fid == -1
            error('No se pudo crear el archivo TXT');
        end
        
        try
            % Write header
            fprintf(fid, 'DATOS DE ANÁLISIS DE FOURIER\n');
            fprintf(fid, '=============================\n\n');
            fprintf(fid, 'Fecha de exportación: %s\n', datestr(now));
            fprintf(fid, 'Frecuencia de muestreo: %d Hz\n', 2048);
            fprintf(fid, 'Período: %.2f s\n\n', period);
            
            if export_time
                fprintf(fid, 'DATOS TEMPORALES\n');
                fprintf(fid, '================\n');
                fprintf(fid, 'Tiempo(s)\tAmplitud\n');
                for i = 1:length(t)
                    fprintf(fid, '%.6f\t%.6f\n', t(i), point(i));
                end
                fprintf(fid, '\n');
            end
            
            if export_freq
                fprintf(fid, 'ESPECTRO DE FRECUENCIA\n');
                fprintf(fid, '======================\n');
                fprintf(fid, 'Frecuencia(Hz)\tAmplitud\n');
                for i = 1:length(f)
                    fprintf(fid, '%.6f\t%.6f\n', f(i), ppy(i));
                end
                fprintf(fid, '\n');
            end
            
            if export_phase
                fprintf(fid, 'ESPECTRO DE FASE\n');
                fprintf(fid, '================\n');
                fprintf(fid, 'Frecuencia(Hz)\tFase(rad)\n');
                for i = 1:length(f)
                    fprintf(fid, '%.6f\t%.6f\n', f(i), phase(i));
                end
                fprintf(fid, '\n');
            end
            
        finally
            fclose(fid);
        end
    end
end 