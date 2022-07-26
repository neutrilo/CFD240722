function p=autoset(p,pos,graf)
  if nargin==1
    pos=[0;0];
  end
  if p.clase~='auto' 
    display('esta funcion solo trabaja con objetos tipo auto, generados con autogen')
    return
  end
  if size(pos)~=[1 1]
    display('"pos" debe ser un par xy')
    return
  else
    pos=pos(:);
    if p.modelo=='con deposito'
      p.vertices=pos+[0,0,0.5*(p.long.base-p.long.ventanas),0.5*(p.long.base-p.long.ventanas),...
          p.long.base-0.5*(p.long.base-p.long.ventanas),...
      p.long.base-0.5*(p.long.base-p.long.ventanas),p.long.base,p.long.base;...
      0,p.altura.base,p.altura.base,p.altura.base+p.altura.ventanas,...
      p.altura.base+p.altura.ventanas, p.altura.base, p.altura.base,0];
    end
    if p.modelo=='sin deposito'
      p.vertices=pos+[0,0,(p.long.base-p.long.ventanas),...
      (p.long.base-p.long.ventanas),p.long.base,...
      p.long.base,p.long.base,p.long.base;...
      0,p.altura.base,p.altura.base,p.altura.base+p.altura.ventanas,...
      p.altura.base+p.altura.ventanas,...
      p.altura.base, p.altura.base,0];
    end
    if graf==1
      dat=[p.vertices,p.vertices(:,1)];
      plot(dat(1,:),dat(2,:))
      axis ([0 1 0 1])
      title('Contorno del auto')
      xlabel('eje X')
      ylabel('eje y')
    end
  end
end