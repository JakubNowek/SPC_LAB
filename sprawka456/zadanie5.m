% a1=1;a2=3;b0=3;b1=2; % parametry theta
% theta = [a1;a2;b0;b1]
% n=1:1:10000; %10000 próbek
% Un = rand(1,size(n,2)); %wejściowy sygnał jednostajny n próbek;

%--------------------------------------------------------------------------
clear all;

theta_r = [0.6;0.8;0.5;0.9];
N=10000;
U = rand(N,1)*20;
P=eye(4);
theta = [0;0;0;0];
Y=zeros(N,1);

for i=2:1:N
    phi = [Y(i);Y(i-1);U(i-1);U(i)] 
    Y(i) = (phi')*theta_r+rand()-0.5;
    P = P-(P*phi*(phi')*P)/(1+(phi')*P*phi);
    theta = theta+P*phi*(Y(i)-(phi')*theta);
end
theta'