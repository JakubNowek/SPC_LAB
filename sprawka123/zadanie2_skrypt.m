A = 2;
sys = tf(1,[A,1]);
datacursormode on %żeby można było klikać sobie na wykres i widzieć dane
w=[1,pi/2,2,pi,5,2*pi,10,20,25,30];
% pętla do plotowania wykresów dla różnych omeg
for w=[1,pi/2,2,pi,5,2*pi,10,20,25,30]    
sim('zadanie2.slx');
figure;
plot(ans.sinus) 
grid(gca,'minor')
grid on;
hold on;
plot(ans.odpowiedz)
title(w);
hold off;
end
% char. amp-faz (Nyquist) obiektu i dorysowanie na niej punktów
figure;
grid on;
nyquist(sys);
hold on;
w=[1,pi/2,2,pi,5,2*pi,10,20,25,30];
nyquist(sys,'*',w);
[re,im,waus]=nyquist(sys,'*',w);
zespolona=complex(re,im);
kont=angle(zespolona)*180/pi; % kolejne kąty wzięte z nyquista (w stopniach)
%amplituda
amplituda=abs(zespolona);
wynik=[kont,amplituda]