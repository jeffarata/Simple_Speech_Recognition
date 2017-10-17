% Jeff Arata
% 10/3/17

% This project and the associated files were provided by Joe Hoffbeck and
% are found in his paper "Enhance Your DSP Course With These Interesting
% Projects.pdf"

% Detects if an audio file is a recording of the word yes or no.

function [ outs ] = my_yn( x, fs, mid_freq, thresh )
% Inputs:   x - the signal
%           fs - the sampling rate
% Outputs:  outs - a string of 'yes' or 'no'
% 
    N = length(x);

    k1 = round(N*mid_freq/fs);      % Index of mid frequency
    k2 = round(N*(1/2)*fs/fs);      % Index of highest frequency, half the sampling rate

    X = abs(fft(x));                % FFT

    ratio = sum(X(1:k1)) / sum(X(k1:k2));       % Ratio between low and high frequencies

    if ratio >= thresh      % Check for each word based on ratio
        outs = 'no';        % 'no' should have a large ratio since it will have 
    else                    % lower high frequencies values
        outs = 'yes';       % 'yes' will have a lower ratio as the 's' will 
    end                     % yield more high frequency content

end