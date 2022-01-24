clear all;
close all;
clc;

m=1; % masa wahadla
M=5; % masa wozka
L=2; % dlugosc wahadla
g=-10; % przyspieszenie ziemskie
d=1; % wspolczynnik tarcia

A= [0 1 0 0;
    0 -d/M -m*g/M 0;
    0 0 0 1;
    0 -d/(M*L) -(m+M)*g/(M*L) 0]; % macierz stanu

B=[0; 1/M; 0; 1/(M*L)]; % macierz wejscia
C=diag([1 1 1 1]); % macierz jednostkowa
D=zeros(4,1); 

eig(A) % wlasnosci wlasne, dodatnie == niestabiny
rank(ctrb(A,B));

sys=ss(A,B,C,D);

Q=diag([100 1 1 1]); % jak zmienia sie system, gdy zmieniamy macierz Q oraz macierz R
R= 1; % kara, powinna byc duza
%


K= lqr(sys,Q,R);
x0= [0;0;0;1];
y0= [2;0;0;0];

out=sim('sim6_1.slx');
%plot
%figure('Renderer', 'painters', 'Position', [10 10 900 300]);
figure();
subplot(1,2,1);
plot(out.output.Time,out.output.Data(:,1)); hold on; grid on;
plot(out.output.Time,out.output.Data(:,2));
plot(out.output.Time,out.output.Data(:,3));
plot(out.output.Time,out.output.Data(:,4));
%title("Reakcja modelu na zadane wymuszenie dla różnych kosztów");
%xlabel("czas [s]");
%ylabel("Amplituda");
legend({'$x$','$\dot x$','$\theta$','$\dot \theta$'},'Interpreter','latex','FontSize',14);
subplot(1,2,2);
plot(out.input.Time, out.input.Data);
%title("Siła przyłożona do układu");
%xlabel("czas [s]");
%ylabel("Amplituda [N]");
grid on;







