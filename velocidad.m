function geom=velocidad(geom)
  n=geom.n; dx=geom.dx;dy=geom.dy;
  fila=(1:n)'.*ones(n); columna=(1:n).*ones(n);
  nodosb=[fila(geom.borde.nodos),columna(geom.borde.nodos)]; %nodos en bordes
  %nodosc=[fila(geom.difz==0),columna(geom.difz==0)]; %nodos centrales
  nodosc=[fila(logical((geom.difz==0).*(geom.borde.nodos==0))),columna(logical((geom.difz==0).*(geom.borde.nodos==0)))]; %nodos centrales 

  
  u0=geom.u.valoresc;
  nccu=geom.u.nodos;
  v0=geom.v.valoresc;
  nccv=geom.v.nodos;
  
  p=geom.p;
   for i=1:max(size(nodosb)) %derivadas en bordes
    f=nodosb(i,1);c=nodosb(i,2);
    
    if geom.borde.dx(f,c)==0
     u(f,c)=0.5*(p(f,c+1)-p(f,c-1))/dx;
    elseif geom.borde.dx(f,c)==1
     u(f,c)=(p(f,c+1)-p(f,c))/dx;
     %u(f,c)=0;
    elseif geom.borde.dx(f,c)==-1
     u(f,c)=(p(f,c)-p(f,c-1))/dx;
     %u(f,c)=0;
    end
  
    if geom.borde.dy(f,c)==0
      v(f,c)=0.5*(p(f+1,c)-p(f-1,c))/dy;
    elseif geom.borde.dy(f,c)==1
      v(f,c)=(p(f+1,c)-p(f,c))/dy;
      %v(f,c)=0;
    elseif geom.borde.dy(f,c)==-1
      v(f,c)=(p(f,c)-p(f-1,c))/dy;
      %v(f,c)=0;
    end
    end
  for i=1:max(size(nodosc)) %derivadas en puntos centrales
    f=nodosc(i,1);c=nodosc(i,2);
    u(f,c)=0.5*(p(f,c+1)-p(f,c-1))/dx;
    v(f,c)=0.5*(p(f+1,c)-p(f-1,c))/dy;
  end
  
  u=u+(u0-u).*nccu; geom.u.valores=u;
  v=v+(v0-v).*nccv; geom.v.valores=-v;
  
  
   end
