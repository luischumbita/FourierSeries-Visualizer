function [point, t, f, ppy, phase, period] = Init_AimFunction_Enhanced(Select_AimFunction, sample_seq, SampleFreq, new_point_string = "", freq_param = 5, amp_param = 1)
    % Enhanced function initialization with many more predefined functions
    % Parameters:
    %   Select_AimFunction: Function selection index
    %   sample_seq: Sampling sequence
    %   SampleFreq: Sampling frequency
    %   new_point_string: Custom function string (if applicable)
    %   freq_param: Frequency parameter for some functions
    %   amp_param: Amplitude parameter for some functions
    
    period = 2;
    t = -period : 1/SampleFreq : period - 1/SampleFreq;
    
    if isempty(new_point_string)
        point = zeros(1, length(sample_seq));
        
        switch Select_AimFunction
            case 1 % Onda Cuadrada
                point(1:floor(length(sample_seq)*0.5)) = amp_param;
                
            case 2 % Onda Triangular
                point = amp_param * sawtooth(2*pi*freq_param*sample_seq, 0.5);
                
            case 3 % Diente de Sierra
                point = amp_param * sawtooth(2*pi*freq_param*sample_seq, 1.0);
                
            case 4 % Onda Escalonada (Heaviside)
                point = amp_param * double(sample_seq >= 0.5);
                
            case 5 % Tren de Pulsos (Dirac Comb)
                point = zeros(1, length(sample_seq));
                pulse_spacing = round(length(sample_seq)/(8*freq_param));
                if pulse_spacing > 0
                    point(1:pulse_spacing:end) = amp_param;
                end
                
            case 6 % Onda Trapezoidal
                ramp_length = floor(length(sample_seq)/(8*freq_param));
                plateau_length = floor(length(sample_seq)/(4*freq_param));
                if ramp_length > 0 && plateau_length > 0
                    ramp = linspace(0, amp_param, ramp_length);
                    plateau = amp_param * ones(1, plateau_length);
                    trapezoid = [ramp plateau fliplr(ramp) zeros(1, length(sample_seq)-2*length(ramp)-length(plateau))];
                    point = repmat(trapezoid, 1, ceil(length(sample_seq)/length(trapezoid)));
                    point = point(1:length(sample_seq));
                end
                
            case 7 % Rampa Lineal
                point = amp_param * sample_seq;
                
            case 8 % Onda Senoidal Recortada
                s = amp_param * sin(2*pi*freq_param*sample_seq);
                point = min(max(s, -amp_param/2), amp_param/2);
                
            case 9 % Exponencial Amortiguada
                alpha = 2;
                point = amp_param * exp(-alpha*sample_seq).*cos(2*pi*freq_param*sample_seq);
                
            case 10 % Onda Modulada AM (Amplitud Modulada)
                carrier_freq = freq_param;
                mod_freq = freq_param/4;
                mod_depth = 0.5;
                point = amp_param * (1 + mod_depth*cos(2*pi*mod_freq*sample_seq)) .* cos(2*pi*carrier_freq*sample_seq);
                
            case 11 % Onda Modulada FM (Frecuencia Modulada)
                carrier_freq = freq_param;
                mod_freq = freq_param/8;
                mod_index = 2;
                point = amp_param * cos(2*pi*carrier_freq*sample_seq + mod_index*sin(2*pi*mod_freq*sample_seq));
                
            case 12 % Señal Chirp (frecuencia variable)
                start_freq = freq_param/2;
                end_freq = freq_param*2;
                chirp_duration = 1;
                t_chirp = sample_seq;
                freq_inst = start_freq + (end_freq - start_freq) * t_chirp / chirp_duration;
                point = amp_param * sin(2*pi * freq_inst .* t_chirp);
                
            case 13 % Función de Ventana
                window_type = mod(freq_param, 4) + 1; % 4 tipos de ventana
                switch window_type
                    case 1 % Hamming
                        point = amp_param * hamming(length(sample_seq))';
                    case 2 % Hanning
                        point = amp_param * hanning(length(sample_seq))';
                    case 3 % Blackman
                        point = amp_param * blackman(length(sample_seq))';
                    case 4 % Kaiser
                        point = amp_param * kaiser(length(sample_seq), 3)';
                end
                
            case 14 % Onda Cuadrada Asimétrica
                duty_cycle = 0.3; % 30% duty cycle
                point = amp_param * double(sample_seq < duty_cycle);
                
            case 15 % Onda Triangular Asimétrica
                point = amp_param * sawtooth(2*pi*freq_param*sample_seq, 0.3);
                
            case 16 % Pulso Gaussiano
                sigma = 0.1;
                center = 0.5;
                point = amp_param * exp(-((sample_seq - center).^2) / (2*sigma^2));
                
            case 17 % Onda Senoidal Compleja
                point = amp_param * (sin(2*pi*freq_param*sample_seq) + 0.5*sin(2*pi*2*freq_param*sample_seq) + 0.25*sin(2*pi*3*freq_param*sample_seq));
                
            case 18 % Función Sinc
                point = amp_param * sinc(2*pi*freq_param*(sample_seq - 0.5));
                
            case 19 % Onda Cuadrada con Ruido
                clean_square = amp_param * double(sample_seq < 0.5);
                noise_level = 0.1;
                noise = noise_level * amp_param * (2*rand(1, length(sample_seq)) - 1);
                point = clean_square + noise;
                
            case 20 % Onda Triangular con Ruido
                clean_tri = amp_param * sawtooth(2*pi*freq_param*sample_seq, 0.5);
                noise_level = 0.1;
                noise = noise_level * amp_param * (2*rand(1, length(sample_seq)) - 1);
                point = clean_tri + noise;
                
            otherwise
                % Default to square wave
                point(1:floor(length(sample_seq)*0.5)) = amp_param;
        end
    else
        % Custom function
        x = sample_seq;
        try
            point = eval(new_point_string);
        catch
            errordlg(['Expresión de función no válida: ' new_point_string], 'Error de Sintaxis');
            point = zeros(1, length(sample_seq));
        end
    end
    
    % Ensure point is a row vector
    if size(point, 1) > 1
        point = point(:)';
    end
    
    % Calculate FFT
    [f, ppy, phase] = CaluFFT(point, SampleFreq, 0);
    
    % Create periodic extension
    point_period = repmat(point, 1, period * 2);
    point = point_period;
end 