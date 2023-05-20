clc
clear
close all
global firsttime
firsttime=1;
v = 8;
A=1;
fs=8000;
W=3900;
N0=1e-16;
D=3;
r=fs*v;
beta = r/2;
B = 2*fs*v;
fs_rec=44100;
T=1;
SPF=floor(T*fs_rec); %SamplesPerFrame
recDuration = T;
recObj = audiorecorder(fs_rec,16,1); 
audio_writer=audioDeviceWriter('SampleRate',fs_rec);

%%
k=1;

record(recObj);
disp('Start!')
pause(max(2*T,1))
x = getaudiodata(recObj);
fs = fs_rec/(floor(fs_rec/fs));
while(1)
tic
x_d = adc(x((k-1)*SPF+1:k*SPF),v,fs_rec,fs);
x_l = linecoder_realtime(x_d,beta,r,A,D);
x_c = channel(x_l,B,N0,D*r);
x_ld = linedecoder(x_c,D);
y = dac(x_ld,v,fs,fs_rec,W)';
step(audio_writer,y);
while toc < T
end
x = getaudiodata(recObj);
k=k+1;
length(x)
end
