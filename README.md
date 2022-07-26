# CFD240722
Este paquete es capaz de generar la geometría aproximada de distintos autos. Ubica el auto en la malla e identifica los nodos interiores y el borde del auto. 
Tambien caracteriza los tipos de bordes para así adaptar el esquema dederivación al nodo en cuestion. Se intenta resolver el laplaciano del flujo potencial en el volumen de control, sin embargo 
el esquema seleccionado carece de la precision requerida para este problema, se recomienda modificar la funcion calculap2.m para utilizar un esquema de orden superior.
