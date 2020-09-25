% Modulacion  AM AUTOTUNE
% Si divido el tiempo de muestreo a la mitad o en algun factor entre 0 y 1, la senal
% suena mas rapido y dura menos. SI por elc ontrario lo multiplico, suena
% mas lento, dura mas, tengo efecto ballena, se ensancha.
% Si comprimo a la mitad, boto la mitad de muestras, es decir limito e
% contenido espectral
% Las recupero interpolando y decimando(es eliminar) quito.
% El espectro queda reducido al variar el fs mas pequeno
 
clear;
close all;
clc;
[y, fs] = audioread('./inputs/snare.wav');       % Lectura del archivo 
b = length(y);          % Tamano de arreglo
t = b/fs;               % Duracion en segundos
n = (t/100)*fs;         % Amplitud de ventana en muestras
c = b/n;                % Cantidad de ventanas total

% sound(y,fs);
% pause(t);
% sound(y,fs*2);

% Obtener transformada de fourier

Y = fft(y);
P2 = abs(Y/b);
P1 = P2(1:b/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(b/2))/b;
% plot(f,P1); 

rmsFFT = rms(P1);
rmsT = rms(y);
maxT = max(y);
maxFFT = max(P1);

%%  Se recorre la transformada positiva (P1) por ventana de  y se detecta la nota

a=1;
for i = 1:c-1
Y = fft(y(i*n:(i+1)*n,1));
P = abs(Y/b);

    [m, pos] = max(P);
    
    if m>10*rmsFFT
        maximos(a,1) = m;
        pos_max(a,1) = pos+(i*n);
    f_max(i,1) = f(pos+(i*n));
    a=a+1;
    end     
end

f_map = zeros(1,b);
q=1;
for i=1:b-1
if P(1,i) == f_max(q,1)
    f_map(1,i:end) = f_max(q,1);
    q=+1;
end
end

% Eliminar los ceros obtenidos en el vector de frecuencias
h=1;
for w=1:length(f_max)
if f_max(w,1)==0
else
f_final(h,1)=f_max(w,1);
h=h+1;
end
end






