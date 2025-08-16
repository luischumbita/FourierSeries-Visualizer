function draw_all_enhanced(m, point, t, f, ppy, phase, period, h_axes_3d, h_axes_f, h_axes_nh, h_axes_zz)
    % Enhanced drawing function with better visualization
    
    % 3D Main Picture
    axes(h_axes_3d);
    draw_mainpicture_enhanced(m, point, t, f, ppy, phase, period);
    
    % Frequency Spectrum
    axes(h_axes_f);
    draw_frequency_enhanced(m, f, ppy);
    
    % Phase Spectrum
    axes(h_axes_zz);
    draw_phase_enhanced(m, f, phase);
    
    % Harmonic Fitting
    axes(h_axes_nh);
    draw_harmonic_enhanced(m, point, t, f, ppy, phase);
    
    % Update display
    drawnow;
end

function draw_mainpicture_enhanced(m, point, t, f, ppy, phase, period)
    cla;
    hold on;
    
    % Original function with better styling
    plot3(-1*ones(1,length(t)), t, point, 'LineWidth', 2.5, 'Color', [0.8, 0.2, 0.2], 'DisplayName', 'Función Original');
    
    % Individual harmonics with different colors
    colors = jet(m+1);
    for i = 1:m+1
        harmonic = ppy(i).*cos(2*pi*f(i)*t + phase(i));
        plot3(f(i)*ones(1,length(t)), t, harmonic, 'LineWidth', 1.5, 'Color', colors(i,:), ...
              'DisplayName', sprintf('Armónico %d', i-1));
    end
    
    % Fourier synthesis
    Fourier_synthesis = zeros(1, length(point));
    for i = 1:m+1
        Fourier_synthesis = Fourier_synthesis + ppy(i).*cos(2*pi*f(i)*t + phase(i));
    end
    
    % Enhanced synthesis line
    plot3((m+1)*ones(1,length(t)), t, Fourier_synthesis, 'Color', [119/255,12/255,176/255], ...
          'LineWidth', 3, 'DisplayName', 'Síntesis de Fourier');
    
    % Enhanced frequency spectrum stems
    stem3(f(1:m+1), period*ones(1,m+1), ppy(1:m+1), 'Color', [244/255,159/255,47/255], ...
          'LineWidth', 3, 'MarkerSize', 8, 'DisplayName', 'Espectro de Frecuencia');
    
    grid on;
    hold off;
    
    % Enhanced title and labels
    title('Visualización de la Expansión de Fourier - Versión Mejorada', 'FontSize', 16, 'FontWeight', 'bold');
    view(-49, 23);
    xlabel('Frecuencia (Armónicos)', 'FontSize', 14, 'FontWeight', 'bold');
    ylabel('Tiempo', 'FontSize', 14, 'FontWeight', 'bold');
    zlabel('Amplitud', 'FontSize', 14, 'FontWeight', 'bold');
    
    % Better axis limits
    axis([-1, m+2, -period, period, min(point)-0.5, max(point)+0.5]);
    
    % Add legend
    legend('Location', 'northeast', 'FontSize', 10);
    
    % Enhanced grid
    grid on;
    set(gca, 'GridAlpha', 0.3, 'GridLineStyle', '--');
end

function draw_frequency_enhanced(m, f, ppy)
    cla;
    hold on;
    
    % Enhanced frequency spectrum
    stem(f(1:m+1), ppy(1:m+1), 'Color', [244/255,159/255,47/255], 'LineWidth', 2.5, 'MarkerSize', 6);
    
    % Add connecting line for better visualization
    plot(f(1:m+1), ppy(1:m+1), 'Color', [244/255,159/255,47/255], 'LineWidth', 1, 'LineStyle', '--');
    
    hold off;
    
    title('Espectro de Amplitud - Frecuencia', 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Frecuencia (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Amplitud', 'FontSize', 12, 'FontWeight', 'bold');
    
    grid on;
    set(gca, 'GridAlpha', 0.3);
    axis tight;
    
    % Add some padding
    ylim([0, max(ppy(1:m+1))*1.1]);
end

function draw_phase_enhanced(m, f, phase)
    cla;
    hold on;
    
    % Enhanced phase spectrum
    stem(f(1:m+1), phase(1:m+1), 'Color', [123/255,159/255,47/255], 'LineWidth', 2.5, 'MarkerSize', 6);
    
    % Add connecting line
    plot(f(1:m+1), phase(1:m+1), 'Color', [123/255,159/255,47/255], 'LineWidth', 1, 'LineStyle', '--');
    
    hold off;
    
    title('Espectro de Fase - Frecuencia', 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Frecuencia (Hz)', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Fase (rad)', 'FontSize', 12, 'FontWeight', 'bold');
    
    grid on;
    set(gca, 'GridAlpha', 0.3);
    axis tight;
    
    % Normalize phase to [-π, π]
    ylim([-pi, pi]);
end

function draw_harmonic_enhanced(m, point, t, f, ppy, phase)
    cla;
    hold on;
    
    % Calculate Fourier synthesis
    Fourier_synthesis = zeros(1, length(point));
    for i = 1:m+1
        Fourier_synthesis = Fourier_synthesis + ppy(i).*cos(2*pi*f(i)*t + phase(i));
    end
    
    % Enhanced synthesis line
    plot(t, Fourier_synthesis, 'Color', [119/255,12/255,176/255], 'LineWidth', 2.5, 'DisplayName', 'Síntesis de Fourier');
    
    % Original signal for reference
    plot(t, point, 'r--', 'LineWidth', 1.5, 'DisplayName', 'Señal Original');
    
    hold off;
    
    grid on;
    set(gca, 'GridAlpha', 0.3);
    
    title(['Ajuste con ' num2str(m) ' armónicos - Comparación'], 'FontSize', 14, 'FontWeight', 'bold');
    xlabel('Tiempo', 'FontSize', 12, 'FontWeight', 'bold');
    ylabel('Amplitud', 'FontSize', 12, 'FontWeight', 'bold');
    
    axis tight;
    
    % Add legend
    legend('Location', 'best', 'FontSize', 10);
    
    % Add some padding
    ylim([min([point, Fourier_synthesis])-0.1, max([point, Fourier_synthesis])+0.1]);
end 