clear all;
clc
theta_r = [0.6;0.8;0.5;0.9]; %rzeczywiste theta
lambda = .98;
N=15000; %liczba probek
U = rand(N,1)*20;
%t = 0:1:N-1;
%U = sin(t);
% figure
% plot(t,U);
P=eye(4);
theta = [0;0;0;0]; %estymowana theta
Y=rand(N,1)*20;
a1 = zeros(1,N);
a2 = zeros(1,N);
b1 = zeros(1,N);
b2 = zeros(1,N);
phi = [0;0;0;0];
a1_error = zeros(1,N);
noise = normrnd(0,1,[1,N]);
for n=2:1:N
     if n==1000 %po pewnym czasie zmienia sie parametr a1
         theta_r(1)=theta_r(1)+0.2;
     end
    phi = [Y(n);Y(n-1);U(n);U(n-1)];
    %Y(n) = (phi')*theta_r+noise(n); %normrnd(0,1) to szum o rozkladzie normalnym [NIEskorelowany]
    Y(n) = (phi')*theta_r+0.4*noise(n)+0.6*noise(n-1); %normrnd(0,1) to szum o rozkladzie normalnym [skorelowany]
    P = (P-(P*phi*(phi')*P)/(lambda+(phi')*P*phi))/lambda;
    theta = theta+P*phi*(Y(n)-(phi')*theta);
    a1(n) = theta(1);
    a2(n) = theta(2);
    b1(n) = theta(3);
    b2(n) = theta(4);
    a1_error(n) = abs(theta(1)-theta_r(1));
end
theta'
% figure
% hold on;
% grid on;
% plot (1:N,a1);
% plot (1:N,a2);
% plot (1:N,b1);
% plot (1:N,b2);
% txt = ['Theta estimated with ',num2str(N),' samples']; % changing nuber to char to display it in legend
% a1=['a1*=0.6, estimated a1=',num2str(a1(n))];
% a2=['a2*=0.8, estimated a2=',num2str(a2(n))];
% b1=['b1*=0.5, estimated b1=',num2str(b1(n))];
% b2=['b2*=0.9, estimated b2=',num2str(b2(n))];
% legend(a1,a2,b1,b2,'Location','SE')
% title(txt);
%------------------obliczanie bledu theta_r-theta-----------------%
figure
hold on;
grid on;
plot (1:N,a1_error);
%plot (1:N,abs(a2-theta_r(2)));
%plot (1:N,abs(b1-theta_r(3)));
%plot (1:N,abs(b2-theta_r(4)));
txt = ['Theta estimated with ',num2str(N),' samples']; % changing nuber to char to display it in legend
a1=['a1*=0.6->0.8, estimation error =',num2str(a1_error(n))];
a2=['a2*=0.8, estimation error =',num2str(abs(a2(n)-0.8))];
b1=['b1*=0.5, estimation error =',num2str(abs(b1(n)-0.5))];
b2=['b2*=0.9, estimation error =',num2str(abs(b2(n)-0.9))];
legend(a1,a2,b1,b2,'Location','NE')
title(txt);