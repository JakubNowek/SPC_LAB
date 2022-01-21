% a1=1;a2=3;b0=3;b1=2; % parametry theta
% theta = [a1;a2;b0;b1]
% n=1:1:10000; %10000 próbek
% Un = rand(1,size(n,2)); %wejściowy sygnał jednostajny n próbek;

%--------------------------------------------------------------------------
clear all;
clc
theta_r = [0.6;0.8;0.5;0.9];
N=10000;
U = rand(N,1)*20;
%t = 0:1:N-1;
%U = sin(t);
% figure
% plot(t,U);
P=eye(4);
theta = [0;0;0;0];
%Y=zeros(1,N)
Y=rand(N,1)*20;
a1 = zeros(1,N);
a2 = zeros(1,N);
b1 = zeros(1,N);
b2 = zeros(1,N);
phi = [0;0;0;0];
for n=2:1:N  
    phi = [Y(n);Y(n-1);U(n);U(n-1)];
    Y(n) = (phi')*theta_r+rand();%-0.5; %usrenianie szumu tym -0.5
    P = P-(P*phi*(phi')*P)/(1+(phi')*P*phi);
    theta = theta+P*phi*(Y(n)-(phi')*theta);
    a1(n) = theta(1);
    a2(n) = theta(2);
    b1(n) = theta(3);
    b2(n) = theta(4);
    %Y(n+1) = (phi')*theta_r+rand()-0.5;
end
theta'
% figure
% hold on;
% grid on;
% plot (1:N,a1);
% plot (1:N,a2);
% plot (1:N,b1);
% plot (1:N,b2);
%plot(1:N,Y);