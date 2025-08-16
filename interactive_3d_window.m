function interactive_3d_window(point, t, f, ppy, phase, period)
    % Interactive 3D visualization window with rotation and zoom capabilities
    
    % Create new figure for interactive 3D
    fig_3d = figure('Name', 'Visualización 3D Interactiva - Series de Fourier', ...
                    'Position', [200, 200, 1000, 800], 'Color', [0.94, 0.94, 0.94]);
    
    % Create axes
    ax_3d = axes('Parent', fig_3d, 'Position', [0.1, 0.1, 0.8, 0.8]);
    
    % Create slider for number of harmonics
    max_harmonics = min(50, length(f)-1); % Limit to reasonable number
    slider_h = uicontrol('Style', 'slider', 'Min', 1, 'Max', max_harmonics, ...
                        'Value', 10, 'SliderStep', [1/(max_harmonics-1), 5/(max_harmonics-1)], ...
                        'Position', [50, 30, 200, 20], 'Callback', @update_3d_plot);
    
    % Label for slider
    uicontrol('Style', 'text', 'String', 'Número de Armónicos:', ...
              'Position', [50, 55, 150, 20], 'HorizontalAlignment', 'left');
    
    % Display current harmonic count
    text_h = uicontrol('Style', 'text', 'String', '10 armónicos', ...
                       'Position', [260, 30, 100, 20], 'HorizontalAlignment', 'left');
    
    % Rotation controls
    uicontrol('Style', 'text', 'String', 'Controles de Rotación:', ...
              'Position', [400, 55, 150, 20], 'HorizontalAlignment', 'left', 'FontWeight', 'bold');
    
    % Reset view button
    uicontrol('Style', 'pushbutton', 'String', 'Vista Original', ...
              'Position', [400, 30, 100, 20], 'Callback', @reset_view);
    
    % Auto-rotate button
    auto_rotate_h = uicontrol('Style', 'pushbutton', 'String', 'Auto-Rotar', ...
                              'Position', [510, 30, 100, 20], 'Callback', @toggle_auto_rotate);
    
    % Initial plot
    update_3d_plot();
    
    % Nested functions
    function update_3d_plot(src, event)
        m = round(get(slider_h, 'Value'));
        set(text_h, 'String', sprintf('%d armónicos', m));
        
        % Clear and redraw
        cla(ax_3d);
        axes(ax_3d);
        hold on;
        
        % Original function
        plot3(-1*ones(1,length(t)), t, point, 'LineWidth', 3, 'Color', [0.8, 0.2, 0.2], ...
              'DisplayName', 'Función Original');
        
        % Individual harmonics with enhanced colors
        colors = jet(m+1);
        for i = 1:m+1
            harmonic = ppy(i).*cos(2*pi*f(i)*t + phase(i));
            plot3(f(i)*ones(1,length(t)), t, harmonic, 'LineWidth', 2, 'Color', colors(i,:), ...
                  'DisplayName', sprintf('Armónico %d', i-1));
        end
        
        % Fourier synthesis
        Fourier_synthesis = zeros(1, length(point));
        for i = 1:m+1
            Fourier_synthesis = Fourier_synthesis + ppy(i).*cos(2*pi*f(i)*t + phase(i));
        end
        
        plot3((m+1)*ones(1,length(t)), t, Fourier_synthesis, 'Color', [119/255,12/255,176/255], ...
              'LineWidth', 4, 'DisplayName', 'Síntesis de Fourier');
        
        % Frequency spectrum stems
        stem3(f(1:m+1), period*ones(1,m+1), ppy(1:m+1), 'Color', [244/255,159/255,47/255], ...
              'LineWidth', 3, 'MarkerSize', 10, 'DisplayName', 'Espectro de Frecuencia');
        
        % Enhanced styling
        title(sprintf('Visualización 3D Interactiva - %d Armónicos', m), 'FontSize', 16, 'FontWeight', 'bold');
        xlabel('Frecuencia (Armónicos)', 'FontSize', 14, 'FontWeight', 'bold');
        ylabel('Tiempo', 'FontSize', 14, 'FontWeight', 'bold');
        zlabel('Amplitud', 'FontSize', 14, 'FontWeight', 'bold');
        
        % Better axis limits
        axis([-1, m+2, -period, period, min(point)-0.5, max(point)+0.5]);
        
        % Enhanced grid and view
        grid on;
        set(gca, 'GridAlpha', 0.3, 'GridLineStyle', '--');
        view(-49, 23);
        
        % Add legend
        legend('Location', 'northeast', 'FontSize', 10);
        
        hold off;
        drawnow;
    end
    
    function reset_view(src, event)
        view(ax_3d, -49, 23);
        axis([-1, 12, -period, period, min(point)-0.5, max(point)+0.5]);
    end
    
    function toggle_auto_rotate(src, event)
        if strcmp(get(auto_rotate_h, 'String'), 'Auto-Rotar')
            set(auto_rotate_h, 'String', 'Detener Rotación');
            start_auto_rotation();
        else
            set(auto_rotate_h, 'String', 'Auto-Rotar');
            stop_auto_rotation();
        end
    end
    
    % Auto-rotation functionality
    rotation_timer = [];
    
    function start_auto_rotation()
        if ~isempty(rotation_timer)
            stop(rotation_timer);
        end
        
        rotation_timer = timer('ExecutionMode', 'fixedRate', 'Period', 0.1, ...
                              'TimerFcn', @rotate_view);
        start(rotation_timer);
    end
    
    function stop_auto_rotation()
        if ~isempty(rotation_timer) && isvalid(rotation_timer)
            stop(rotation_timer);
            delete(rotation_timer);
            rotation_timer = [];
        end
    end
    
    function rotate_view(src, event)
        current_view = view(ax_3d);
        new_azimuth = current_view(1) + 2;
        view(ax_3d, new_azimuth, current_view(2));
        drawnow;
    end
    
    % Clean up when figure is closed
    set(fig_3d, 'CloseRequestFcn', @close_3d_window);
    
    function close_3d_window(src, event)
        stop_auto_rotation();
        delete(fig_3d);
    end
end 