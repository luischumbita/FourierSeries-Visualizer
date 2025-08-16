function draw_dynamic_process_enhanced(point, t, f, ppy, phase, period)
    % Enhanced dynamic process visualization with better controls and smoother animation
    
    % Create dynamic process window
    dynamic_fig = figure('Name', 'Proceso de Ajuste Dinámico - Versión Mejorada', ...
                         'Position', [200, 200, 1000, 700], 'Color', [0.94, 0.94, 0.94]);
    
    % Create main axes
    main_ax = axes('Parent', dynamic_fig, 'Position', [0.1, 0.2, 0.6, 0.7]);
    
    % Create control panel
    control_panel = uipanel('Parent', dynamic_fig, 'Title', 'Controles de Animación', ...
                           'Position', [0.75, 0.1, 0.23, 0.8], 'FontSize', 12, 'FontWeight', 'bold');
    
    % Speed control
    uicontrol('Parent', control_panel, 'Style', 'text', 'String', 'Velocidad de Animación:', ...
              'Position', [20, 600, 150, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    speed_slider = uicontrol('Parent', control_panel, 'Style', 'slider', ...
                            'Min', 0.1, 'Max', 2.0, 'Value', 0.5, 'SliderStep', [0.1, 0.2], ...
                            'Position', [20, 570, 150, 20], 'Callback', @update_speed);
    
    speed_text = uicontrol('Parent', control_panel, 'Style', 'text', 'String', '0.5x', ...
                           'Position', [180, 570, 50, 20], 'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.94, 0.94, 0.94]);
    
    % Harmonic range control
    uicontrol('Parent', control_panel, 'Style', 'text', 'String', 'Rango de Armónicos:', ...
              'Position', [20, 520, 150, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    max_harmonics = min(50, length(f)-1);
    range_slider = uicontrol('Parent', control_panel, 'Style', 'slider', ...
                            'Min', 1, 'Max', max_harmonics, 'Value', 20, 'SliderStep', [1, 5], ...
                            'Position', [20, 490, 150, 20], 'Callback', @update_range);
    
    range_text = uicontrol('Parent', control_panel, 'Style', 'text', 'String', '1-20 armónicos', ...
                           'Position', [20, 460, 150, 20], 'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.94, 0.94, 0.94]);
    
    % Animation controls
    play_btn = uicontrol('Parent', control_panel, 'Style', 'pushbutton', 'String', '▶ Reproducir', ...
                         'Position', [20, 400, 80, 30], 'FontSize', 11, 'FontWeight', 'bold', ...
                         'BackgroundColor', [0.2, 0.8, 0.2], 'ForegroundColor', [1, 1, 1], ...
                         'Callback', @toggle_animation);
    
    pause_btn = uicontrol('Parent', control_panel, 'Style', 'pushbutton', 'String', '⏸ Pausar', ...
                          'Position', [110, 400, 80, 30], 'FontSize', 11, 'FontWeight', 'bold', ...
                          'BackgroundColor', [0.8, 0.6, 0.2], 'ForegroundColor', [1, 1, 1], ...
                          'Callback', @pause_animation);
    
    reset_btn = uicontrol('Parent', control_panel, 'Style', 'pushbutton', 'String', '🔄 Reiniciar', ...
                          'Position', [20, 360, 80, 30], 'FontSize', 11, 'FontWeight', 'bold', ...
                          'BackgroundColor', [0.6, 0.6, 0.6], 'ForegroundColor', [1, 1, 1], ...
                          'Callback', @reset_animation);
    
    step_btn = uicontrol('Parent', control_panel, 'String', '⏭ Siguiente', ...
                         'Position', [110, 360, 80, 30], 'FontSize', 11, 'FontWeight', 'bold', ...
                         'BackgroundColor', [0.4, 0.4, 0.8], 'ForegroundColor', [1, 1, 1], ...
                         'Callback', @step_animation);
    
    % Progress display
    uicontrol('Parent', control_panel, 'Style', 'text', 'String', 'Progreso:', ...
              'Position', [20, 300, 150, 20], 'HorizontalAlignment', 'left', ...
              'BackgroundColor', [0.94, 0.94, 0.94], 'FontWeight', 'bold');
    
    progress_text = uicontrol('Parent', control_panel, 'Style', 'text', 'String', '0 / 20 armónicos', ...
                              'Position', [20, 270, 150, 20], 'HorizontalAlignment', 'left', ...
                              'BackgroundColor', [0.94, 0.94, 0.94]);
    
    % Error display
    error_text = uicontrol('Parent', control_panel, 'Style', 'text', 'String', 'Error RMS: 0.000', ...
                           'Position', [20, 240, 150, 20], 'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.94, 0.94, 0.94], 'FontWeight', 'bold');
    
    % Statistics panel
    stats_panel = uipanel('Parent', control_panel, 'Title', 'Estadísticas', ...
                          'Position', [0.05, 0.05, 0.9, 0.15], 'FontSize', 10);
    
    stats_text = uicontrol('Parent', stats_panel, 'Style', 'text', ...
                           'String', 'Armónicos: 0\nFrecuencia Max: 0 Hz\nAmplitud Max: 0', ...
                           'Position', [10, 10, 180, 60], 'HorizontalAlignment', 'left', ...
                           'BackgroundColor', [0.94, 0.94, 0.94], 'FontSize', 9);
    
    % Animation state variables
    animation_running = false;
    current_harmonic = 0;
    animation_timer = [];
    animation_speed = 0.5;
    max_harmonics_range = 20;
    
    % Initial plot
    update_plot();
    
    % Nested functions
    function update_speed(src, event)
        animation_speed = get(speed_slider, 'Value');
        set(speed_text, 'String', sprintf('%.1fx', animation_speed));
        if animation_running
            restart_animation();
        end
    end
    
    function update_range(src, event)
        max_harmonics_range = round(get(range_slider, 'Value'));
        set(range_text, 'String', sprintf('1-%d armónicos', max_harmonics_range));
        if current_harmonic > max_harmonics_range
            current_harmonic = max_harmonics_range;
            update_plot();
        end
    end
    
    function toggle_animation(src, event)
        if animation_running
            pause_animation();
        else
            start_animation();
        end
    end
    
    function start_animation()
        if current_harmonic >= max_harmonics_range
            current_harmonic = 0;
        end
        
        animation_running = true;
        set(play_btn, 'String', '⏸ Pausar', 'BackgroundColor', [0.8, 0.6, 0.2]);
        
        % Create timer for animation
        if ~isempty(animation_timer)
            stop(animation_timer);
            delete(animation_timer);
        end
        
        animation_timer = timer('ExecutionMode', 'fixedRate', 'Period', 0.5/animation_speed, ...
                               'TimerFcn', @animation_step);
        start(animation_timer);
    end
    
    function pause_animation(src, event)
        animation_running = false;
        set(play_btn, 'String', '▶ Reproducir', 'BackgroundColor', [0.2, 0.8, 0.2]);
        
        if ~isempty(animation_timer)
            stop(animation_timer);
        end
    end
    
    function reset_animation(src, event)
        current_harmonic = 0;
        update_plot();
        update_progress();
        
        if animation_running
            pause_animation();
        end
    end
    
    function step_animation(src, event)
        if current_harmonic < max_harmonics_range
            current_harmonic = current_harmonic + 1;
            update_plot();
            update_progress();
        end
    end
    
    function animation_step(src, event)
        if current_harmonic < max_harmonics_range
            current_harmonic = current_harmonic + 1;
            update_plot();
            update_progress();
        else
            pause_animation();
        end
    end
    
    function update_plot()
        cla(main_ax);
        axes(main_ax);
        hold on;
        
        % Plot original signal
        plot(t, point, 'r--', 'LineWidth', 2, 'DisplayName', 'Señal Original');
        
        if current_harmonic > 0
            % Calculate Fourier synthesis
            Fourier_synthesis = zeros(1, length(point));
            for i = 1:current_harmonic+1
                Fourier_synthesis = Fourier_synthesis + ppy(i).*cos(2*pi*f(i)*t + phase(i));
            end
            
            % Plot synthesis
            plot(t, Fourier_synthesis, 'Color', [119/255,12/255,176/255], ...
                 'LineWidth', 3, 'DisplayName', sprintf('Síntesis (%d armónicos)', current_harmonic));
            
            % Plot individual harmonics
            colors = jet(current_harmonic+1);
            for i = 1:current_harmonic+1
                harmonic = ppy(i).*cos(2*pi*f(i)*t + phase(i));
                plot(t, harmonic, 'Color', colors(i,:), 'LineWidth', 1, ...
                     'DisplayName', sprintf('Armónico %d', i-1));
            end
        end
        
        hold off;
        
        % Enhanced styling
        title(sprintf('Proceso de Ajuste Dinámico - %d Armónicos', current_harmonic), ...
              'FontSize', 16, 'FontWeight', 'bold');
        xlabel('Tiempo (s)', 'FontSize', 12, 'FontWeight', 'bold');
        ylabel('Amplitud', 'FontSize', 12, 'FontWeight', 'bold');
        
        grid on;
        set(gca, 'GridAlpha', 0.3);
        axis([-period, period, min(point)-0.5, max(point)+0.5]);
        
        % Add legend
        legend('Location', 'best', 'FontSize', 10);
        
        drawnow;
    end
    
    function update_progress()
        set(progress_text, 'String', sprintf('%d / %d armónicos', current_harmonic, max_harmonics_range));
        
        % Calculate and display error
        if current_harmonic > 0
            Fourier_synthesis = zeros(1, length(point));
            for i = 1:current_harmonic+1
                Fourier_synthesis = Fourier_synthesis + ppy(i).*cos(2*pi*f(i)*t + phase(i));
            end
            
            error_rms = sqrt(mean((point - Fourier_synthesis).^2));
            set(error_text, 'String', sprintf('Error RMS: %.3f', error_rms));
            
            % Update statistics
            max_freq = max(f(1:current_harmonic+1));
            max_amp = max(ppy(1:current_harmonic+1));
            set(stats_text, 'String', sprintf('Armónicos: %d\nFrecuencia Max: %.1f Hz\nAmplitud Max: %.3f', ...
                                            current_harmonic, max_freq, max_amp));
        else
            set(error_text, 'String', 'Error RMS: 0.000');
            set(stats_text, 'String', 'Armónicos: 0\nFrecuencia Max: 0 Hz\nAmplitud Max: 0');
        end
    end
    
    function restart_animation()
        if animation_running
            pause_animation();
            start_animation();
        end
    end
    
    % Clean up when figure is closed
    set(dynamic_fig, 'CloseRequestFcn', @close_dynamic_window);
    
    function close_dynamic_window(src, event)
        if ~isempty(animation_timer)
            stop(animation_timer);
            delete(animation_timer);
        end
        delete(dynamic_fig);
    end
end 