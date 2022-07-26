function []=grafica(geom)
   hold off
  it=geom.niter;
  niter=it;
  err=geom.error;

  
  subplot (2, 2, 1)
  mesh(geom.x,geom.y,-geom.p);    
  shading interp

  title({'Distribucion de presion';['{\it Numero de iteraciones} = ',num2str(it)]})
  xlabel('Direccion X \rightarrow')
  ylabel('{\leftarrow} Direccion Y')
  zlabel('presion (P) \rightarrow')

  subplot (2, 2, 2)
  loglog(min(floor(niter*1/4),10):niter,err(min(floor(niter*1/4),10):niter))
  title('Error de convergencia')
  xlabel('Numero de iteraciones')
  ylabel('Error')
  grid on

  subplot (2, 2, 3)
  pcolor(geom.x,geom.y,geom.p)
  colorbar
  title({'Distribucion de presion';['{\it Numero de iteraciones} = ',num2str(it)]})
  xlabel('Direccion X \rightarrow')
  ylabel('Direccion Y \rightarrow')
  
  subplot (2, 2, 4)
  pcolor(geom.x,geom.y,geom.auto-1)
  title({'Auto en el tunel'})
  xlabel('Direccion X \rightarrow')
  ylabel('Direccion Y \rightarrow')
end