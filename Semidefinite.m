T = 3;
N = 2;

M = 4;
I = eye(2);
a = 1.8;
a_2 = a^2;
Q = .6;
sigma = 1000000;
C = [1 1];
C_2 = C.^2;
R = [.4 .1];
R_In = R.^-1;
H = (C.*sqrt(R_In))';
Pi = 0.4;
oney = ones(2,1);
onez = ones(3,1);

G = [1  1; 1 1; 1 1];

cvx_begin quiet
    variables eta(T,N) X(T)
    expressions Gamma(T,N,N) Gamma2(T,N,N)

    z = (1-eta);
    for i = 1:T
        Gamma(i,:,:) = diag(z(i,:));
    end
    for i = 1:T
        Gamma2(i,:,:) = reshape(Gamma(i,:,:),N,N) + sigma*(I-reshape(Gamma(i,:,:),N,N));
    end
    
    maximize( sum(X) )
    subject to
        h =  a_2*Pi + Q;
        test = [h-X(1) h*H'; H*h H*h*H' + reshape(Gamma2(1,:,:),N,N)];
        test >= 0;

        for i = 1:T-1
            h =  a*X(i)*a + Q;
            test = [h-X(i+1) h*H'; H*h H*h*H' + reshape(Gamma2(i+1,:,:),N,N)];
            test >= 0;
        end

        eta <= 1;
        eta >= 0;
        onez'*eta*oney == M;
cvx_end