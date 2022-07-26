clear
%-------------------------------------------------------------------------------
%--------------------Definimos el auto------------------------------------------
%-------------------------------------------------------------------------------
tipo_de_auto=1; %1 con baul, 2 sin baul
auto=autogen(tipo_de_auto); 
esquina_inf_izquierda=[0.2;0.2]; %coordenadas de la esquina_inf_izquierda
auto=autoset(auto,esquina_inf_izquierda,0);
%-------------------------------------------------------------------------------
%---------------------Armamos la malla------------------------------------------
%-------------------------------------------------------------------------------
n=20;
nx=n;
ny=n;
x=linspace(0,1,n).*ones(n);
y=linspace(0,1,n)'.*ones(n);
h=1/(n-1);
dy=h;
dx=h;
%-------------------------------------------------------------------------------
%---------------------Se introduce el auto en la malla--------------------------
%-------------------------------------------------------------------------------
uppercut=[[0;auto.vertices(2,1)],auto.vertices,[1;auto.vertices(2,end)]];
yc=zeros(1,n);
%yc=interp1(auto.vertices(1,:),auto.vertices(2,:),linspace(0,1,n)); %esta
%linea solo funciona en octave
if tipo_de_auto==2
  ysup=[0,auto.vertices(1,1),auto.vertices(1,3),auto.vertices(1,5),1;...
  auto.vertices(2,1),auto.vertices(2,2),auto.vertices(2,4),auto.vertices(2,8),auto.vertices(2,8)];
  yc=interp1(ysup(1,:),ysup(2,:),linspace(0,1,n),'previous');
end
if tipo_de_auto==1
  ysup=[0,auto.vertices(1,1),auto.vertices(1,3),auto.vertices(1,5),auto.vertices(1,7),1;...
auto.vertices(2,1),auto.vertices(2,2),auto.vertices(2,4),auto.vertices(2,6),auto.vertices(2,8),auto.vertices(2,1)];
yc=interp1(ysup(1,:),ysup(2,:),linspace(0,1,n),'previous');
end


z=(y<=yc).*(y>=auto.vertices(2,1));
dz=difusa(z);
%pcolor(x,y,z)
%-------------------------------------------------------------------------------
%---------------------Condiciones de contorno-----------------------------------
%-------------------------------------------------------------------------------
%Valores en la paredes
  uwest=1;
  vsouth=0;
  vnorth=0;
%matrices de tipo de borde, importante para el equema de derivacion
xlog=zeros(n);
ylog=zeros(n);
xlog(:,1)=1;
xlog(:,end)=-1;
ylog(1,:)=1;
ylog(n,:)=-1;
for i=2:n-1
  for j=2:n-1
    if z(i,j)==0
      if z(i+1,j)==1
        ylog(i,j)=-1;
      end 
      if z(i-1,j)==1
        ylog(i,j)=1;
      end
      if z(i,j+1)==1
        xlog(i,j)=-1;
      end 
      if z(i,j-1)==1
        xlog(i,j)=1;
      end
    end
  end
end
%matrices de condicion de contorno
ulog=abs([xlog(:,1:end-1),zeros(n,1)]); %nodos con condicion de contorno en u
vlog=abs(ylog);                         %nodos con condicion de contorno en v
u0=rand(n).*(ulog==0)+0*ulog;
u0(:,1)=uwest;
v0=rand(n).*(vlog==0)+0*(vlog~=0);
v0(1,:)=vnorth;
v0(n,:)=vsouth;
test=0; %probamos que el programa detecte el contorno del auto
if test==1
  pcolor(x,y,xlog+ylog)
  axis([0 1 0 1])
end
clear('test');
geom.x=x;
geom.y=y;
geom.auto=z;
geom.dx=dx;
geom.dy=dy;
geom.difz=dz;
geom.n=n;
geom.borde.nodos=(abs(xlog)+abs(ylog))~=0;
geom.borde.dx=xlog;
geom.borde.dy=ylog;
geom.u.nodos=ulog;
geom.u.valoresc=u0.*ulog;
geom.u.valores=u0;
geom.v.nodos=vlog;
geom.v.valoresc=v0.*vlog;
geom.v.valores=v0;
geom.p=zeros(n)+(x+rand(n)).*(dz==0);


%-------------------------------------------------------------------------------
%---------------Resolucion del problema-----------------------------------------
%-------------------------------------------------------------------------------
niter=400;
err=zeros(1,niter);
for it=1:niter
  p0=geom.p;
  geom=calculap2(geom);
  err(it)=sum(sum(abs(geom.p-p0)));
end
geom=velocidad(geom);
geom.p=geom.p/max(max(geom.p)); %normalizamos p
geom.error=err;
geom.niter=niter;

graf=1;
if graf==1;
  grafica(geom)
end