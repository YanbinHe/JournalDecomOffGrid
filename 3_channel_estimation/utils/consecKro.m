function b = consecKro(a)
%   CONSECKRO
%   compute the kronecker product of a sequence

if nargin < 1
    b = 1;
    return
end

I = length(a);
b = 1;
for i = 1:I
    b = kron(b, a{i});
end

end