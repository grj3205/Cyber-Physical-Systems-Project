function [P_avg] = objective(Field,A,C,Q,R,Pi)

[T,N] = size(Field);

P = zeros(1,T+1);
P(1) = Pi;

for i = 1:T
    Pt_0 = A*P(i)*A' + Q;
    R_t = 0;
    for j = 1:N
       R_t = R_t + (Field(i,j)*C(j)*(R(j)^-1)*C(j)); 
    end
    P(i+1) = (Pt_0^-1 + R_t)^-1;
end

P_avg = (sum(P)-Pi)./T;
end

