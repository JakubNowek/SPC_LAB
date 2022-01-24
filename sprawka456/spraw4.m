% uncomment the section you re interrested in or uncomment all and add
% breakpoints
clear;
clc;
Ts = 0.1; % sample time
Ts_list = [0.001, 0.005, 0.01, 0.05, 0.1, 0.2, 0.5, 1]; % sample time list
%Ts_list=[2,3,3.7,5,8];
% for Ts about 3.8 sys becomes unstable
sys_c = tf(1,[1,3,3,1]);  % continuous transfer fcn for object
sys_d = c2d(sys_c,Ts); % discrete transfer fcn for object
% extracting numerators and denominators
[c_numerator, c_denominator] = tfdata(sys_c, 'v');
[d_numerator, d_denominator] = tfdata(sys_d, 'v');

kp=3; % any value from (-1,8) works
ki=0.48; % earlier estabilished minimum value of ki

%-------------plot for different sample times---------------%
figure
hold on;
grid on;
%impulse(sys_c);
h=stepplot(sys_c);
h.Response(1).Name = 'Continuous';
for j=1:size(Ts_list,2)
    
   sys_d = c2d(sys_c,Ts_list(j)); % discrete transfer fcn for object
   txt = ['Ts = ',num2str(Ts_list(j))]; % changing nuber to char to display it in legend
   h = stepplot(sys_d,14);
   h.Response(j+1).Name = txt; % naming a step response
   %impulse(sys_d,14);
   grid on;
end
title("Step response for continuous and discrete transfer fcn");
legend;
% title and legend for impuls response  
 %title("Impuls response for continuous and discrete transfer fcn");
 legend('Continuous','Ts=0.001', 'Ts=0.005', 'Ts=0.01', 'Ts=0.05', 'Ts=0.1', 'Ts=0.2', 'Ts=0.5', 'Ts=1');
%---------------------------END-----------------------------%

% %-------------Q(kp,ki) depending on sample time-------------%
figure;
for j= 1:size(Ts_list,2)
Ts = Ts_list(j)

sys_d = c2d(sys_c,Ts); % discrete transfer fcn for object

% extracting numerators and denominators (for different Ts)
[d_numerator, d_denominator] = tfdata(sys_d, 'v');

sim('z4_discPI.slx','StopTime','400');
txt = ['Ts = ',num2str(Ts)];
hold on
grid on
plot(ans.uchyb2,'DisplayName',txt); 
end 
legend;
title('Q(kp=3,ki=0.48) depending on sample time')
xlabel('time')
ylabel('Q')
% %---------------------END--------------------------------%

%-----------------------MAIN TASK------------------------%
%-for different sample times and const kp=3, plot Q(ki)--%

%for this to work properly you need to change uchyb2 block from Timeseries
%to array

ki_list=0.4:0.01:0.8; %range of ki
% ki_list=0.35:0.01:0.6; %range of ki for only one chosen Ts 
w=zeros(size(ki_list,2),2); %array of final values of integral of square error
figure;
for i= 1:size(Ts_list,2)
    
Ts = Ts_list(i)
sys_d = c2d(sys_c,Ts); % discrete transfer fcn for object
% extracting numerators and denominators
[d_numerator, d_denominator] = tfdata(sys_d, 'v');

%------------Q(ki) with kp and Ts as parameter-----------%
figure;

for j= 1:size(ki_list,2)
ki=ki_list(j);
sim('z4_discPI.slx');
%txt = ['ki = ',num2str(ki)]; 
hold on
grid on
%plot(ans.uchyb2,'DisplayName',txt); %error plots depending on ki
w(j,1)=ans.uchyb2(end,1);
w(j,2)=ki;
end 
% xlim([49.7 50])% limiting x axis
% legend show;
% hold off;
[y,x]= min(w)
minimum = [w(x(1),2),y(1)] % smallest value of x
txt = ['Ts = ',num2str(Ts),', min = ',num2str(minimum(2))];
plot(w(:,2),w(:,1),'-*','DisplayName',txt); % plot function 
point = plot(minimum(1),minimum(2),'x'); % mark on the plot the min points
hold on;
grid on
xlabel('ki')
ylabel('Q(ki)')
point.Annotation.LegendInformation.IconDisplayStyle = 'off';
legend;

%w(:,1) - first column of vector w (y coordinates)
%w(:,2) - seond column of vector w (x coordinates)


%---------------------------END--------------------------%

end

%---------------------------END--------------------------%