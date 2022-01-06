
%----------------regulator_P--------------------%
% figure; 
% k = [-0.8,1,2,3,4,5,6,7,7.5]; %nasz wektor wzmocnień
% w=[size(k,2)];
% for i= 1:size(k,2)
% kp=k(i);
% sim('zadanie3.slx');
% txt = ['kp = ',num2str(kp)]; %zamiana liczby na tekst żeby wpisać do legendy
% hold on
% grid on
% plot(simout,'DisplayName',txt); 
% w(i)= getdatasamples(simout,80001)
% end 
% ylim([-2.5 2.5]) % ograniczenie osi y
% legend show
% figure;
% plot(k,w,'-x');
% grid on
%----------------regulator_PI-------------------%
figure;
kp_2 = 3;
%k_i=[-1:0.5:3]; 
k_i=[0.4:0.02:0.5];
for j= 1:size(k_i,2)
ki=k_i(j)
sim('zadanie3.slx');
txt = ['ki = ',num2str(ki)]; %zamiana liczby na tekst żeby wpisać do legendy
hold on
grid on
plot(uchyb2,'DisplayName',txt); 
end 
ylim([0 2.5]) % ograniczenie osi y
%xlim([40 50])% ograniczanie x dla uchybów w przynliżeniu
legend show
