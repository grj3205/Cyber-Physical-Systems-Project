% Griffin Rule
% Strategy generation

T = 3;
N = 2;
M = 4;

A = 1.8;
Q = .6;
C = [1 1 1];
R = [.4 .1 .2];
Pi = 0.4;

Field = zeros(T,N);
Defender = zeros(T,N,N^T);
q = nchoosek(T*N,M);
Attacker = zeros(T,N,q);
combos = nchoosek(1:N*T,M);

for i = 1:q
    Att_temp = zeros(1,T*N);
    for j = 1:M
        Att_temp(1,combos(i,j)) = 1;
    end
    Stra_temp = reshape(Att_temp,[T N]);
    Attacker(:,:,i) = Stra_temp;
end

Deff = permn(1:N,T);

for i = 1:N^T
    Stra_temp = Field;
    for j = 1:T
        Stra_temp(j,Deff(i,j)) = 1;
    end
    Defender(:,:,i) = Stra_temp;
end

Payoff = zeros(N^T,q);

for i = 1:N^T
    for j = 1:q
        test_d = Defender(:,:,i);
        test_a = Attacker(:,:,j);
        result = test_d.*(1-test_a);
        Payoff(i,j) = objective_2(result,A,C,Q,R,Pi);
    end
end


