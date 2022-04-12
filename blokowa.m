%J.Bartczak

function x = blokowa(B, C, b)
  n1 = size(B,1);
  n2 = size(B,2);
  m1 = size(C,1);
  m2 = size(C,2);
  
  if ((n1~=n2) || (m2~=3*n1))
    msg = "nieodpowiednie macierze";
    error(msg)
  endif
  n = n1;
  m = m1;
  
  
  b1 = b(1:n);
  b2 = b((n+1): (2*n));
  b3 = b((2*n+1):(3*n));
  b4 = b((3*n+1):(3*n+m));
  
  C1 = C(:,1:n);
  C2 = C(:,(n+1):2*n);
  C3 = C(:,(2*n+1):3*n);
  
  %kroki 1-3
  LT = chol(B);
  H1 = LT\(LT'\C1');
  H2 = LT\(LT'\C2');
  H3 = LT\(LT'\C3');
  
  %krok 4
  J1 = LT\(LT'\b1);
  J2 = LT\(LT'\b2);
  J3 = LT\(LT'\b3);
  
  %krok 5
  M = -C1*H1-C2*H2-C3*H3;
  Mdod = -M;
  v = b4-C1*J1-C2*J2-C3*J3;
  
  %krok 6
  KT = chol(Mdod);
  x4 = -KT\(KT'\v);
  
  %krok 7
  x1 = LT\(LT'\(b1-C1'*x4));
  x2 = LT\(LT'\(b2-C2'*x4));
  x3 = LT\(LT'\(b3-C3'*x4));
  
  x = [x1;x2;x3;x4]
 
endfunction
  
  
  
  