T = 5;
N = 2;
P = 3;
M = 6;

A = 1.8;
Q = .6;
C = [1 1 1];
R = [.4 .1 .2];
Pi = 0.4;

Field = zeros(T,N);
p = nchoosek(T,P);
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

combos2 = nchoosek(1:T,P);
Length = size(combos2);
sensor = zeros(T,1);
one_sensor = zeros(T,Length(1));

for i = 1:Length(1)
    Stra_temp = sensor;
    for j = 1:P
        Stra_temp(combos2(i,j)) = 1;
    end
    one_sensor(:,i) = Stra_temp;
end

Defender = zeros(T,N,Length(1));

counter = 1;
for i = 1:Length(1)
    for j = 1:Length(1)
        Defender(:,1,counter) = one_sensor(:,i);
        Defender(:,2,counter) = one_sensor(:,j);
        counter = counter+1;
    end
end

Payoff = zeros(counter-1,q);

for i = 1:counter-1
    for j = 1:q
        test_d = Defender(:,:,i);
        test_a = Attacker(:,:,j);
        result = test_d.*(1-test_a);
        Payoff(i,j) = objective_2(result,A,C,Q,R,Pi);
    end
end

