% Estymacja online
clear;
clc;

% Zmienne
final = 3000;
start = 10;
u_n = rand();
u_n1 = 0;
y_n = rand();
phi_n = [u_n; u_n1];
P = [1000 0; 0 1000];
theta_n = [0; 0];
theta_ra = 0.7;
theta_rb = 1.5;
theta_r = [theta_ra theta_rb];

y = zeros(1,final+1);
z = randn(1,final+1);
theta_a = zeros(1,final+1);
theta_b = zeros(1,final+1);

for x = linspace(2, final+1, final)
    phi_n(1) = u_n;
    phi_n(2) = u_n1;
    y_n = theta_r*phi_n + z(x);
    
    P = P - (P*phi_n*phi_n'*P) / (1+phi_n'*P*phi_n); %OK
    theta_n = theta_n + P*phi_n*(y_n-phi_n'*theta_n); %OK

    theta_a(x) = theta_n(1);
    theta_b(x) = theta_n(2);

    u_n1 = u_n;
    u_n = rand();
    y(x) = y_n;

%     if x>=1000
%         theta_r(1) = 1.5;
%     end
end

figure(1)
hold on; grid on;
plot(linspace(start, final+1, final+2-start), theta_a(start:final+1));
plot(linspace(start, final+1, final+2-start), theta_b(start:final+1));
legend('a', 'b');
