function [f, ppy, phase] = CaluFFT(point, SampleFreq, log_format=0, calcu_length=-1)
    % Calculate DFT (Discrete Fourier Transform)
    %   [f, ppy, phase] = CaluFFT(point, SampleFreq, log_format, calcu_length)
    % 
    % INPUT PARAMETERS
    %   'point' - The array of input signals
    %   'SampleFreq' - Sample Frequency
    %   'log_format' - The format of amplitude
    %         -  0 primary (default)
    %         -  1 db
    %   'calcu_length' - The calculation length of DFT (optional)
    % 
    % OUTPUT PARAMETERS
    %   'f' - Real Frequency Domain
    %   'ppy' - Amplitude of corresponding frequency 
    %   'phase' - Phase of corresponding frequency

    % Check input parameters
    if (nargin < 2)
        error('Please input two parameters at least!');
    end
    
    if (calcu_length == -1)
        calcu_length = length(point);
    end

    % FFT calculation
    N = length(point);
    Yf = fft(point, calcu_length);
    
    % Frequency domain processing
    fm = floor(N/2);
    f = (0:fm) * SampleFreq/N;
    
    % Amplitude calculation
    ppy = abs(Yf) / (N/2);
    ppy(1) = ppy(1)/2;  % DC component
    
    % Handle even length
    if (rem(N,2) == 0)
        ppy(end) = ppy(end)/2;
    end
    
    % Phase calculation
    phase = angle(Yf);
    
    % Log scale if requested
    if (log_format == 1)
        ppy = 20*log10(ppy);
    end
    
    % Return only positive frequencies
    ppy = ppy(1:fm+1);
    phase = phase(1:fm+1);
end