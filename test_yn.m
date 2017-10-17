% Jeff Arata, 10/3/17

% This script tests utilizes my_yn.m to test if the sound files say yes or
% no. 

clear;
clc;

% First some plotting of the PSD of a yes and a no wave file

figure(1)

filename = ['speech_training_files\yes', '1', '.wav'];  % the 'yes'
[x, fs] = audioread(filename);  

X1 = abs(fft(x))';       % FFT
N1 = length(x);         

psdX1 = (1 / (fs*N1)) * (X1(1:floor(N1/2+1)) .^ 2);    % PSD
psdX1(2:end-1) = 2*psdX1(2:end-1);              % Correct PSD

freq = linspace(0, fs/2, floor(N1/2 + 1));             % Frequency axis
plot( freq , 10*log10(psdX1), 'r' )             % PSD in log scale
hold on

filename = ['speech_training_files\no', '1', '.wav'];   % the 'no'
[x, fs] = audioread(filename);  

X2 = abs(fft(x));                               % FFT
N2 = length(x);

psdX2 = (1 / (fs*N2)) * (X2(1:floor(N2/2+1)) .^ 2);    % PSD
psdX2(2:end-1) = 2*psdX2(2:end-1);              % correct PSD

freq = linspace(0, fs/2, N2/2 + 1);             % Frequency axis
plot( freq , 10*log10(psdX2), 'b')              % PSD in log scale
hold off


N = 25;          % number of each word, yes and no
correct = 0;     % Initialization   
mid_freq = 5000; % Frequency to stop at for ratio between lower and upper frequencies
thresh = 12;     % Threshold value to separate yes and no by ratio value


% First load up each yes file from the training set and test it using 
% the function my_yn.wav

for ii = 1:N
    filename = ['speech_training_files\yes', int2str(ii), '.wav'];
    [x, fs] = audioread(filename);   
    out = my_yn(x, fs, mid_freq, thresh);       % test for 'yes' or 'no
    if strcmpi(out, 'yes')
        correct = correct + 1;
    end
end

% Next load up the no files in the training set to test them using the
% my_yn function.

for ii = 1:N
    filename = ['speech_training_files\no', int2str(ii), '.wav'];
    [x, fs] = audioread(filename);
    out = my_yn(x, fs, mid_freq, thresh);       % test for 'yes' or 'no'
    if strcmpi(out, 'no')   
        correct = correct + 1;
    end
end


fprintf('Your speech recognition algorithm got %d out of %d words correct in the training set.\n', correct, 2*N)


% Now to use the yes files from the test set.

correct = 0;        % Reinitialize

for ii = 1:N
    filename = ['speech_test_files\yes', int2str(ii), '.wav'];
    [x, fs] = audioread(filename);   
    out = my_yn(x, fs, mid_freq, thresh);       % test for 'yes' or 'no
    if strcmpi(out, 'yes')
        correct = correct + 1;
    end
end

% And finally the no files from the test set.

for ii = 1:N
    filename = ['speech_test_files\no', int2str(ii), '.wav'];
    [x, fs] = audioread(filename);
    out = my_yn(x, fs, mid_freq, thresh);       % test for 'yes' or 'no'
    if strcmpi(out, 'no')   
        correct = correct + 1;
    end
end

fprintf('Your speech recognition algorithm got %d out of %d words correct in the testing set.\n', correct, 2*N)

