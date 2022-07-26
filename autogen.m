function auto=autogen(modelo)
  if modelo==1
    auto.clase='auto';
    auto.modelo='con deposito';
    auto.altura.base=0.2;
    auto.altura.ventanas=0.2;
    auto.long.base=0.6;
    auto.long.ventanas=0.3;
  elseif modelo==2
    auto.clase='auto';
    auto.modelo='sin deposito';
    auto.altura.base=0.2;
    auto.altura.ventanas=0.2;
    auto.long.base=0.6;
    auto.long.ventanas=0.45;
  endif
endfunction
