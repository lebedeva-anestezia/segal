clc
clear

method = 1;

a = 0;
b = 20;

% tmax = 10;
% xcount = 200;
% tcount = 5000;

tmax = 10;
xcount = 200;
tcount = 5000;


u = 1;
kappa = 0; 

dt = tmax / tcount;
dx = (b - a) / xcount;

%s = u * dt / dx
s = 0
r = 0.7
%r = kappa * dt / (dx ^ 2)

T = zeros(xcount, 1);
Ox = a + dx:dx:b;
for i = 1 : xcount / 10
    T(i) = 100;
end
T00 = T;

for n = 1 : tcount
    T0 = T;
    T = nextLayer(r, s, method, T00, xcount);
    if method > 4
        if (method == 5 || method == 7)
            T = T + T00;
        end
        T00 = T0;
    else
        T00 = T;
    end
    if mod(n, 100) == 1
        plot(Ox, T)
        ylim([0 100]);
        xlim([a b]);
        refreshdata;
        drawnow;
    end
end

%Ox = dx:dx:xmax;
%plot(Ox, T)

