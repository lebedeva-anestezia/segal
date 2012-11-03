function T = nextLayer( r, s, method, T0, xcount )
    T = T0();
    switch method
        case 1 % forward explicit
            T(1) = T0(1) * (1 + s - r) + (r - s) * T0(2);
            T(xcount) = T0(xcount) * (1 - r) + r * T0(xcount - 1);
            for k = 2 : xcount - 1
                T(k) = (1 + s - 2 * r) * T(k) + (r - s) * T(k + 1) + r * T(k - 1);
            end
        case 2 % backward explicit
            T(1) = T0(1) * (1 - r) + r * T0(2);
            T(xcount) = T0(xcount) * (1 - s - r) + (s + r) * T0(xcount - 1);
            for k = 2 : xcount - 1
                T(k) = T0(k) * (1 - s - 2 * r) + (s + r) * T0(k - 1) + r * T0(k + 1);
            end
        case 3 % forward implicit
            M = createTriMatr(-r, 2 * r - s + 1, s - r, xcount);
            T = linsolve(M, T0);
        case 4 %backward implicit
            M = createTriMatr(-s - r, s + 2 * r + 1, -r, xcount);
            T = linsolve(M, T0);
        case 5
            T(1) = T0(1) * (s - r) + (r - s) * T0(2);
            T(xcount) = (s - r) * T(xcount) + r * T(xcount - 1);
            for k = 2 : xcount - 1
                T(k) = (s - 2 * r) * T(k) + (r - s) * T(k + 1) + r * T(k - 1);
            end
            T = T * 2;
        case 6
            M = createTriMatr(-2 * r, 1 - 2 * s + 4 * r, 2 *s - 2 * r, xcount);
            T = linsolve(M, T0);
        case 7
            T(1) = T0(1) * (- r) + r * T0(2);
            T(xcount) = T0(xcount) * (- s - r) + (s + r) * T0(xcount - 1);
            for k = 2 : xcount - 1
                T(k) = T0(k) * (- s - 2 * r) + (s + r) * T0(k - 1) + r * T0(k + 1);
            end
            T = T * 2;
        case 8
            M = createTriMatr(-2 * s - 2 * r, 2 * s + 4 * r + 1, -2 * r, xcount);
            T = linsolve(M, T0);
    end
end

function M = createTriMatr(a, b, c, n)
    M = zeros(n);
    for i = 1 : n - 1
        M(i, i) = b;
        M(i + 1, i) = a;
        M(i, i + 1) = c;
    end
    M(n, n) = b + c;
    M(1, 1) = a + b;
end