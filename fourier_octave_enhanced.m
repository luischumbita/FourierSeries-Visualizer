## Fourier Series Visualization Tool for GNU Octave - Enhanced Version
## Version 3.0 - Adapted from original MATLAB code by 知乎@电工李达康
## Enhanced for Octave with additional functions and features

function fourier_octave_enhanced()

  ## --------------------------------------------------------------------------
  ## Main setup and variable initialization
  ## --------------------------------------------------------------------------
  pkg load signal; % Ensure signal processing package is loaded

  % Set sampling frequency
  SampleFreq = 2048; % Increased for better resolution
  % Generate sampling sequence
  sample_seq = 0 : 1/SampleFreq : 1 - 1/SampleFreq;

  % Generate the initial function (default to square wave)
  Select_AimFunction = 1;
  [point, t, f, ppy, phase, period] = Init_AimFunction_Enhanced(Select_AimFunction, sample_seq, SampleFreq);

  ## --------------------------------------------------------------------------
  ## Enhanced GUI Design
  ## --------------------------------------------------------------------------

  % Create the main figure with better styling
  main_fig = figure('Name', 'Visualización de Series de Fourier V3.0 - Simplificada (Octave)', 'NumberTitle', 'off', ...
                    'Position', [100, 100, 1600, 1000], 'Color', [0.94, 0.94, 0.94]);

  % --- Axes with better positioning ---
  h_axes_3d = axes('Parent', main_fig, 'Position', [0.05, 0.45, 0.50, 0.50]);
  h_axes_f = axes('Parent', main_fig, 'Position', [0.05, 0.05, 0.20, 0.25]);
  h_axes_nh = axes('Parent', main_fig, 'Position', [0.75, 0.05, 0.20, 0.25]);
  h_axes_zz = axes('Parent', main_fig, 'Position', [0.30, 0.05, 0.20, 0.25]);

  % --- Panel de controles principal ---
  control_x = 0.62;
  control_w = 0.33;
  y = 0.85;
  dy = 0.06;

  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'CONTROLES PRINCIPALES', ...
            'FontSize', 14, 'FontWeight', 'bold', 'Units', 'normalized', ...
            'Position', [control_x, y, control_w, dy], 'HorizontalAlignment', 'center', ...
            'BackgroundColor', [0.9, 0.8, 1.0], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy - 0.01;

  % --- Selección de función mejorada ---
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Seleccione la función de dominio de tiempo:', ...
            'FontSize', 11, 'FontWeight', 'bold', 'Units', 'normalized', ...
            'Position', [control_x, y, control_w, dy-0.01], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy;

  % Colores mejorados para los radio buttons
  radio_bg_predef = [0.2, 0.6, 1.0];  % Azul para funciones predefinidas
  radio_fg_predef = [1, 1, 1];        % Texto blanco
  radio_bg_personal = [0.8, 0.4, 0.8]; % Morado para funciones personalizadas
  radio_fg_personal = [1, 1, 1];      % Texto blanco
  radio_font = 10;

  hradio_point_one = uicontrol('Parent', main_fig, 'Style', 'radiobutton', 'String', 'Funciones Predefinidas:', ...
                               'Units', 'normalized', 'Position', [control_x, y, 0.15, dy-0.01], 'Value', 1, ...
                               'FontSize', radio_font, 'BackgroundColor', radio_bg_predef, 'ForegroundColor', radio_fg_predef, ...
                               'CData', []);
  
  % Enhanced function list with more options
  function_list = ['Onda Cuadrada|Onda Triangular|Diente de Sierra|Onda Escalonada|Tren de Pulsos|Onda Trapezoidal|Rampa Lineal|Onda Senoidal Recortada|Exponencial Amortiguada|Onda Modulada AM|Onda Modulada FM|Señal Chirp|Función de Ventana|Onda Cuadrada Asimétrica|Onda Triangular Asimétrica|Pulso Gaussiano|Onda Senoidal Compleja|Función Sinc|Onda Cuadrada con Ruido|Onda Triangular con Ruido'];
  
  hpop_point = uicontrol('Parent', main_fig, 'Style', 'popupmenu', ...
                        'String', function_list, ...
                        'Units', 'normalized', 'Position', [control_x+0.16, y, 0.17, dy-0.01], ...
                        'FontSize', 10, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy;

  hradio_point_two = uicontrol('Parent', main_fig, 'Style', 'radiobutton', 'String', 'Función Personalizada: f(x)=', ...
                               'Units', 'normalized', 'Position', [control_x, y, 0.15, dy-0.01], 'Value', 0, ...
                               'FontSize', radio_font, 'BackgroundColor', radio_bg_personal, 'ForegroundColor', radio_fg_personal, ...
                               'CData', []);
  hedit_point = uicontrol('Parent', main_fig, 'Style', 'edit', 'String', 'sin(2*pi*x)', ...
                          'Units', 'normalized', 'Position', [control_x+0.16, y, 0.17, dy-0.01], ...
                          'FontSize', 10, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy + 0.01;
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Ejemplos: sin(2*pi*x), exp(-x), x^2, sinc(x)', ...
            'Units', 'normalized', 'Position', [control_x+0.16, y, 0.17, 0.025], 'HorizontalAlignment', 'left', 'FontSize', 9, ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.5, 0.5, 0.5]);
  y = y - dy + 0.01;

  % --- Parámetros adicionales para funciones especiales ---
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Parámetros adicionales (si aplica):', ...
            'FontSize', 10, 'FontWeight', 'bold', 'Units', 'normalized', ...
            'Position', [control_x, y, control_w, dy-0.01], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy;
  
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Frecuencia:', 'Units', 'normalized', ...
            'Position', [control_x, y, 0.08, dy-0.01], 'FontSize', 9, 'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  hfreq_edit = uicontrol('Parent', main_fig, 'Style', 'edit', 'String', '5', ...
                         'Units', 'normalized', 'Position', [control_x+0.09, y, 0.06, dy-0.01], ...
                         'FontSize', 9, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2]);
  
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Amplitud:', 'Units', 'normalized', ...
            'Position', [control_x+0.18, y, 0.08, dy-0.01], 'FontSize', 9, 'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  hamp_edit = uicontrol('Parent', main_fig, 'Style', 'edit', 'String', '1', ...
                        'Units', 'normalized', 'Position', [control_x+0.27, y, 0.06, dy-0.01], ...
                        'FontSize', 9, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy;

  % --- Selección de armónicos mejorada ---
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Seleccione el número de armónicos:', ...
            'FontSize', 11, 'FontWeight', 'bold', 'Units', 'normalized', ...
            'Position', [control_x, y, control_w, dy-0.01], 'HorizontalAlignment', 'left', ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy;
  hradio_one = uicontrol('Parent', main_fig, 'Style', 'radiobutton', 'String', 'Seleccionar # de Armónicos:', ...
                         'Units', 'normalized', 'Position', [control_x, y, 0.18, dy-0.01], 'Value', 1, ...
                         'FontSize', radio_font, 'BackgroundColor', radio_bg_predef, 'ForegroundColor', radio_fg_predef, ...
                         'CData', []);
  hpop = uicontrol('Parent', main_fig, 'Style', 'popupmenu', 'String', '3|5|9|12|15|22|50|100', ...
                   'Units', 'normalized', 'Position', [control_x+0.19, y, 0.09, dy-0.01], ...
                   'FontSize', 10, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2], 'Value', 4);
  y = y - dy;
  hradio_two = uicontrol('Parent', main_fig, 'Style', 'radiobutton', 'String', 'Personalizado:', ...
                         'Units', 'normalized', 'Position', [control_x, y, 0.13, dy-0.01], 'Value', 0, ...
                         'FontSize', radio_font, 'BackgroundColor', radio_bg_personal, 'ForegroundColor', radio_fg_personal, ...
                         'CData', []);
  hedit = uicontrol('Parent', main_fig, 'Style', 'edit', 'String', '12', ...
                    'Units', 'normalized', 'Position', [control_x+0.14, y, 0.07, dy-0.01], ...
                    'FontSize', 10, 'BackgroundColor', [1, 1, 1], 'ForegroundColor', [0.2, 0.2, 0.2]);
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'armónicos', 'Units', 'normalized', ...
            'Position', [control_x+0.22, y, 0.08, dy-0.01], 'FontSize', 10, ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.2, 0.2, 0.2]);
  y = y - dy + 0.01;
  uicontrol('Parent', main_fig, 'Style', 'text', 'String', 'Ejemplo: 12', ...
            'Units', 'normalized', 'Position', [control_x+0.14, y, 0.15, 0.025], 'HorizontalAlignment', 'left', 'FontSize', 9, ...
            'BackgroundColor', [0.94, 0.94, 0.94], 'ForegroundColor', [0.5, 0.5, 0.5]);
  y = y - dy;

  % --- Botones adicionales eliminados para simplificar la interfaz ---
  % Se mantiene solo el bloque de ajuste con 12 armónicos por defecto

  % --- Menús con mejor estilo ---
  H_file = uimenu(main_fig, 'Label', 'Archivo');
  H_save = uimenu(H_file, 'Label', 'Guardar Imagen');
  uimenu(H_save, 'Label', 'Imagen 3D', 'Callback', {@filesave, h_axes_3d});
  uimenu(H_save, 'Label', 'Imagen Amplitud-Frecuencia', 'Callback', {@filesave, h_axes_f});
  uimenu(H_save, 'Label', 'Imagen Fase', 'Callback', {@filesave, h_axes_zz});
  uimenu(H_save, 'Label', 'Imagen de Ajuste', 'Callback', {@filesave, h_axes_nh});
  uimenu(H_file, 'Label', 'Salir', 'Callback', 'close(gcf)');

  H_about = uimenu(main_fig, 'Label', 'Acerca de');
  uimenu(H_about, 'Label', 'Contexto del Proyecto', 'Callback', @show_background);
  uimenu(H_about, 'Label', 'Información del Autor', 'Callback', @show_author_info);
  uimenu(H_about, 'Label', 'Nuevas Funciones', 'Callback', @show_new_functions);

  % --- Set Callbacks ---
  % We create a shared callback for all controls that change the plot
  shared_callback_handle = @(src, event) shared_callback();
  set(hpop, 'Callback', shared_callback_handle);
  set(hedit, 'Callback', shared_callback_handle);
  set(hpop_point, 'Callback', shared_callback_handle);
  set(hedit_point, 'Callback', shared_callback_handle);
  set(hfreq_edit, 'Callback', shared_callback_handle);
  set(hamp_edit, 'Callback', shared_callback_handle);

  % Radio button callbacks
  set(hradio_one, 'Callback', @radio_one_Callback);
  set(hradio_two, 'Callback', @radio_two_Callback);
  set(hradio_point_one, 'Callback', @radio_point_one_Callback);
  set(hradio_point_two, 'Callback', @radio_point_two_Callback);

  % --- Inicializar controles correctamente ---
  update_function_controls();
  update_harmonic_controls();

  % --- Initial Draw ---
  draw_all_enhanced(12, point, t, f, ppy, phase, period, h_axes_3d, h_axes_f, h_axes_nh, h_axes_zz);

  ## --------------------------------------------------------------------------
  ## Enhanced Callback Functions
  ## --------------------------------------------------------------------------

  function shared_callback()
      % Get values from function selection
      vpop_point = get(hpop_point, 'value');
      new_point_string = get(hedit_point, 'string');
      is_common_function = get(hradio_point_one, 'value');
      freq_param = str2double(get(hfreq_edit, 'string'));
      amp_param = str2double(get(hamp_edit, 'string'));

      if is_common_function
          [point, t, f, ppy, phase, period] = Init_AimFunction_Enhanced(vpop_point, sample_seq, SampleFreq, "", freq_param, amp_param);
      else
          % Función personalizada más robusta
          x = sample_seq;
          try
              point = eval(new_point_string); % El usuario debe usar 'x' como variable
              if ~isvector(point) || length(point) ~= length(sample_seq)
                  error('La función debe devolver un vector del mismo tamaño que x.');
              end
          catch
              errordlg(['Expresión de función no válida o error de sintaxis.\nUse x como variable. Ejemplo: sin(2*pi*x)'], 'Error de Sintaxis');
              point = zeros(1, length(sample_seq));
          end
          [f, ppy, phase] = CaluFFT(point, SampleFreq, 0);
          period = 1; % Período más simple para funciones personalizadas
          t = -period : 1/SampleFreq : period - 1/SampleFreq;
          point_period = repmat(point, 1, period * 2);
          point = point_period;
      end

      % Get values from harmonics selection
      is_selection_mode = get(hradio_one, 'value');
      ct = get(hedit, 'string');
      vpop = get(hpop, 'value');
      pop_values = [3, 5, 9, 12, 15, 22, 50, 100];

      if is_selection_mode
          m = pop_values(vpop);
      else
          cct = str2double(ct);
          if isnan(cct) || cct <= 0 || cct > 0.5 * SampleFreq
              errordlg(['Por favor, ingrese un número positivo menor que ' num2str(0.5*SampleFreq)], 'Error de Entrada');
              m = 3; % Valor por defecto
          else
              m = cct;
          end
      end
      
      draw_all_enhanced(m, point, t, f, ppy, phase, period, h_axes_3d, h_axes_f, h_axes_nh, h_axes_zz);
  end

  % Función dynamic_process_callback eliminada para simplificar la interfaz

  % Funciones callback adicionales eliminadas para simplificar la interfaz

  % --- Resto de callbacks ---
  function radio_one_Callback(src, event)
      set(hradio_one, 'value', 1);
      set(hradio_two, 'value', 0);
      update_harmonic_controls();
      shared_callback();
  end

  function radio_two_Callback(src, event)
      set(hradio_one, 'value', 0);
      set(hradio_two, 'value', 1);
      update_harmonic_controls();
      shared_callback();
  end

  function radio_point_one_Callback(src, event)
      set(hradio_point_one, 'value', 1);
      set(hradio_point_two, 'value', 0);
      update_function_controls();
      shared_callback();
  end

  function radio_point_two_Callback(src, event)
      set(hradio_point_one, 'value', 0);
      set(hradio_point_two, 'value', 1);
      update_function_controls();
      shared_callback();
  end

  % --- Funciones auxiliares para habilitar/deshabilitar controles ---
  function update_function_controls()
      if get(hradio_point_one, 'value')
          set(hpop_point, 'Enable', 'on');
          set(hedit_point, 'Enable', 'off');
          set(hfreq_edit, 'Enable', 'on');
          set(hamp_edit, 'Enable', 'on');
      else
          set(hpop_point, 'Enable', 'off');
          set(hedit_point, 'Enable', 'on');
          set(hfreq_edit, 'Enable', 'off');
          set(hamp_edit, 'Enable', 'off');
      end
  end

  function update_harmonic_controls()
      if get(hradio_one, 'value')
          set(hpop, 'Enable', 'on');
          set(hedit, 'Enable', 'off');
      else
          set(hpop, 'Enable', 'off');
          set(hedit, 'Enable', 'on');
      end
  end

  function show_background(src, event)
      msgbox(background_words(), 'Contexto del Proyecto');
  end

  function show_author_info(src, event)
      msgbox({'HECHO POR 知乎@电工李达康'; 'Versión 3.0 Enhanced'; 'Email: qizhenkang@sina.com'; 'Mejorado para Octave con funciones adicionales'}, 'Información del Autor');
  end

  function show_new_functions(src, event)
      new_funcs = {'NUEVAS FUNCIONES AGREGADAS:'; ''; ...
                   '• Onda Modulada AM (Amplitud Modulada)'; ...
                   '• Onda Modulada FM (Frecuencia Modulada)'; ...
                   '• Señal Chirp (frecuencia variable)'; ...
                   '• Función de Ventana (Hamming, Hanning, etc.)'; ...
                   '• Onda Cuadrada Asimétrica'; ...
                   '• Onda Triangular Asimétrica'; ...
                   '• Pulso Gaussiano'; ...
                   '• Onda Senoidal Compleja'; ...
                   '• Función Sinc'; ...
                   '• Ondas con Ruido Simulado'; ...
                   ''; ...
                   'PARÁMETROS ADICIONALES:'; ...
                   '• Control de frecuencia'; ...
                   '• Control de amplitud'; ...
                   '• Mejor resolución de muestreo'};
      msgbox(new_funcs, 'Nuevas Funciones Disponibles');
  end

end 