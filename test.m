%J.Bartczak

function test
  format long
  n = randi(4)+1;
  m = randi(5);
  B1 = rand(n,n);
  B = B1*B1';
  B = B+n*eye(n);
  C = rand(m, m)*rand(m, 3*n);
  b = rand(3*n+m,1);
  x = blokowa(B,C,b);
  
  %rozwi¹zanie uk³adu równañ skryptem Octave'a
  C1 = C(:,1:n);
  C2 = C(:,(n+1):2*n);
  C3 = C(:,(2*n+1):3*n);
  Zn = zeros(n);
  Zm = zeros(m);
  M = [B,Zn,Zn,C1';Zn,B,Zn,C2';Zn,Zn,B,C3';C1,C2,C3,Zm];
  
  %porównanie rozwi¹zañ
  oct = M\b
  blad_wzgledny = (oct-x)/(norm(x))
  
endfunction