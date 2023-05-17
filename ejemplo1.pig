-- Leer datos
datos = LOAD 'texto.txt' USING PigStorage(',') AS (nombre:chararray, edad:int, ciudad:chararray);

-- Agrupar datos por ciudad
datos_ciudad = GROUP datos BY  ciudad;

-- Calcular la edad promedio de cada ciudad
datos_ciudad_2 = FOREACH datos_ciudad GENERATE group AS ciudad, AVG(datos.edad) AS edad_promedio;

-- Filtrar por edades
datos_filtrados = FILTER datos_ciudad_2 BY edad_promedio>28.0;

-- Mostrar el resultado
dump datos_filtrados;
