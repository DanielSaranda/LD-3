clear all
clc
close all

x = 0.1:1/22:1;
y = (1 + 0.6*sin(2*pi*x/0.7) + 0.3*sin(2*pi*x)) / 2;

%%%%%%%%3 laboras
[ExtremumeY, ExtremumeX] = findpeaks(y, x,'MinPeakDistance', 0.4);
Taskas_1=[ExtremumeX(1),ExtremumeY(1)];
Taskas_2=[ExtremumeX(2),ExtremumeY(2)];

% Duomenys  
r1 = 0.2; % pirmo apskritimo spindulys
r2 = 0.2; % antro apskritimo spindulys
c1 = [Taskas_1(1), Taskas_1(2)-r1]; % pirmo apskritimo centras
c2 = [Taskas_2(1), Taskas_2(2)-r2]; % antro apskritimo centras

%%%Apkritimu skaiciavimas
% Sukurkite kampų vektorių nuo 0 iki 2*pi
theta = linspace(0, 2*pi, 100);

% Pirmo apskritimo taškai
xCircle1 = c1(1) + r1 * cos(theta); % apskritimo x koordinates
yCircle1 = c1(2) + r1 * sin(theta); % apskritimo y koordinates

% Antro apskritimo taškai
xCircle2 = c2(1) + r2 * cos(theta); % apskritimo x koordinates
yCircle2 = c2(2) + r2 * sin(theta); % apskritimo y koordinates

% Brėžkite grafike
figure(3)
plot(x, y);
hold on
plot(xCircle1, yCircle1, 'r-', 'LineWidth', 2); % pirmas apskritimas
plot(xCircle2, yCircle2, 'r-', 'LineWidth', 2); % antras apskritimas
hold off
axis equal; % kad apskritimai būtų apvalūs


w0 = randn(1);
w1 = randn(1);
w2 = randn(1);
step = 0.1;
r1 = 0.2;
r2 = 0.2;
cx1 = Taskas_1(1);
cx2 = Taskas_2(1);

for k=1:20000
    for n=1:20
      F1=exp(-((x(n)-cx1)^2)/(2*(r1^2)));
      F2=exp(-((x(n)-cx2)^2)/(2*(r2^2)));

      ynew(n) = F1*w1+F2*w2+w0;
      % nuokrypis nuo norimos funkcijos
      delta = y(n)-ynew(n);

      w1 = w1 + step * delta * F1;
      w2 = w2 + step * delta * F2;
      w0 = w0 + step * delta;
    end
end
%%% Test
xt = linspace(0.1, 1, 200); %daugiau zigsniu
yTarget_Test = ((1 + 0.6*sin(2*pi*xt/0.7)) + 0.3*sin(2*pi*xt))/2;
for m = 1:200
    F1=exp(-((xt(m)-cx1)^2)/(2*(r1^2)));
    F2=exp(-((xt(m)-cx2)^2)/(2*(r2^2)));
    yt(m) = F1*w1+F2*w2+w0;
end

figure(2)
plot(x, y,"b", xt,yt, "r")
legend('Target', 'Calculated')


