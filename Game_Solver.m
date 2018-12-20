% Testing Game Theory

A_game = Payoff;

%deffender
cvx_begin quiet
    variable y(size(A_game,1))
    minimize( max(y'*A_game) )
    subject to
        y >= 0
        sum(y) == 1
cvx_end

%attacker
cvx_begin quiet
    variable z(size(A_game',1))
    maximize( min(A_game*z) )
    subject to
        z >= 0;
        sum(z) == 1;
cvx_end

totald = zeros(T,N);
for i=1:size(y)
    totald = totald + y(i).*Defender(:,:,i);
end

totala = zeros(T,N);
for i=1:size(z)
    totala = totala + z(i).*Attacker(:,:,i);
end

Outcome = totald.*(1-totala);

objective_2(Outcome,A,C,Q,R,Pi)

