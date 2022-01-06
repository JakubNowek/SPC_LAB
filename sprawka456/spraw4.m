clear;
clc;
Ts = 0.1; % sample time
Ts_list = [0.001, 0.005, 0.01, 0.05, 0.1, 0.2, 0.5, 1,3]; % sample time list
sys_c = tf(1,[1,3,3,1]);  % continuous transfer fcn for object
%sys_d = c2d(sys_c,Ts); % discrete transfer fcn for object
% extracting numerators and denominators
[c_numerator, c_denominator] = tfdata(sys_c, 'v');
%[d_numerator, d_denominator] = tfdata(sys_d, 'v');

kp=3;
ki=0.48; % earlier estabilished minimum value of ki

%-------------plot for different sample times---------------%
% figure
% hold on;
% grid on;
% h=stepplot(sys_c);
% h.Response(1).Name = 'Continuous';
% for j=1:size(Ts_list,2)
%     
%    sys_d = c2d(sys_c,Ts_list(j)); % discrete transfer fcn for object
%    txt = ['Ts = ',num2str(Ts_list(j))]; % changing nuber to char to display it in legend
%    h = stepplot(sys_d,14);
%    h.Response(j+1).Name = txt; % naming a step response
%    grid on;
% end
% title("Step response for continuous and discrete transfer fcn");
% legend;
%---------------------------END-----------------------------%

figure;
%-------------Q(kp,ki) depending on sample time-------------%
for j= 1:size(Ts_list,2)
Ts = Ts_list(j)

sys_d = c2d(sys_c,Ts); % discrete transfer fcn for object
% extracting numerators and denominators
[d_numerator, d_denominator] = tfdata(sys_d, 'v');

sim('z4_discPI.slx','StopTime','400');
txt = ['Ts = ',num2str(Ts)];
hold on
grid on
plot(ans.uchyb2,'DisplayName',txt); 
end 
legend;