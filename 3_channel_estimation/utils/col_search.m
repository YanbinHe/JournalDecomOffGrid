function [h,posi] = col_search(range,t,diagSig,prob)

l = range(1);
r = range(2);

d = (r-l)/20;
cons = linspace(l+d,r-d,10)';
H = generate_colFuncs(prob,cons);
[~,posi] = min(real(t*H)+diagSig*vecnorm(H).^2);

for i = 1:9
    r = cons(posi)+d;l = cons(posi)-d;
    d = (r-l)/4;
    cons = linspace(l+d,r-d,2)';
    H = generate_colFuncs(prob,cons);
    [~,posi] = min(real(t*H)+diagSig*vecnorm(H).^2);
end
h = H(:,posi);
posi = cons(posi);
end