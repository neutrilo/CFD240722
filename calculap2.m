function geom=calculap2(geom)
  n=geom.n; dx=geom.dx;dy=geom.dy;
  fila=(1:n)'.*ones(n); columna=(1:n).*ones(n);
  nodosb=[fila(geom.borde.nodos),columna(geom.borde.nodos)]; %nodos en bordes
  nodosc=[fila(logical((geom.difz==0).*(geom.borde.nodos==0))),columna(logical((geom.difz==0).*(geom.borde.nodos==0)))]; %nodos centrales 
  p=geom.p; pn=p;
  for a=1:max(size(nodosc)) %derivadas en puntos centrales
    i=nodosc(a,1);j=nodosc(a,2);
    p(i,j)=((dy^2*(pn(i+1,j)+pn(i-1,j)))+(dx^2*(pn(i,j+1)+pn(i,j-1))))/(2*(dx^2+dy^2));
  end
  for i=1:max(size(nodosb)) %derivadas en bordes
    i=nodosb(i,1);j=nodosb(i,2);
    if geom.borde.dx(i,j)==1
      p(i,j)=pn(i,j+1);
    elseif geom.borde.dx(i,j)==-1
      p(i,j)=pn(i,j-1);
    end
    
    if geom.borde.dy(i,j)==1
      p(i,j)=pn(i+1,j);
    elseif geom.borde.dy(i,j)==-1
      p(i,j)=pn(i-1,j);
    end
      
  end
  
    p(:,1)=p(:,2)-dx;
    p(:,n)=p(:,n-1)+dx;
    p(1,:)=p(2,:);                   %Neumann conditions
    p(n,:)=p(n-1,:);
    
    geom.p=p;
  end
