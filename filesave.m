function filesave(src, event, handle)
    % Función para guardar imágenes de gráficos
    % Parameters:
    %   src - Source object (not used)
    %   event - Event data (not used)
    %   handle - Handle to the axes to save
    
    if isempty(handle)
        errordlg('No se puede guardar: handle de ejes inválido', 'Error');
        return;
    end
    
    try
        % Crear nueva figura para guardar
        newFig = figure('Visible', 'off');
        newAxes = copyobj(handle, newFig);
        set(newAxes, 'Units', 'default', 'Position', 'default');
        
        % Diálogo para seleccionar archivo
        [filename, pathname] = uiputfile({
            '*.jpg', 'JPEG Image (*.jpg)';
            '*.png', 'PNG Image (*.png)';
            '*.pdf', 'PDF Document (*.pdf)';
            '*.eps', 'EPS File (*.eps)'
        }, 'Guardar Imagen', 'untitled');
        
        if isequal(filename, 0) || isequal(pathname, 0)
            % Usuario canceló
            close(newFig);
            return;
        end
        
        % Construir ruta completa
        fpath = fullfile(pathname, filename);
        
        % Guardar imagen usando print (más compatible con Octave)
        print(newFig, fpath, '-dpng'); % Por defecto PNG
        
        % Cerrar figura temporal
        close(newFig);
        
        % Mensaje de confirmación
        msgbox(sprintf('Imagen guardada exitosamente en:\n%s', fpath), 'Guardado Exitoso');
        
    catch ME
        % Manejo de errores
        if exist('newFig', 'var') && ishandle(newFig)
            close(newFig);
        end
        errordlg(sprintf('Error al guardar imagen:\n%s', ME.message), 'Error de Guardado');
    end
end 