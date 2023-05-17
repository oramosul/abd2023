-- OBJETIVO: Encontrar los nombres de las mejores peliculas mas
-- antiguas (con puntaje mayor a 4)

-- PARTE 1
-- =======

-- Cargar datos de peliculas
puntajes = LOAD 'u.data' AS (IDusuario:int, IDpelicula:int, puntaje:int, tiempoPuntaje:int);

-- Agrupar segun ID de pelicula
puntajesPorPelicula = GROUP puntajes by IDpelicula;

-- Calcular el promedio del puntaje para cada pelicula
puntajesPromedio = FOREACH puntajesPorPelicula GENERATE group AS IDpelicula, AVG(puntajes.puntaje) AS puntajePromedio;

-- Filtrar peliculas cuyo promedio sea mayor que 4
mejoresPeliculas = FILTER puntajesPromedio BY puntajePromedio>4.0;
-- dump mejoresPeliculas;


-- PARTE 2
-- =======

-- Cargar metadata de las peliculas
metadata = LOAD 'u.item' USING PigStorage('|') AS (IDpelicula:int, nombrePelicula:chararray, fecha:chararray, resto:chararray);

-- Convertir la fecha en formato de tiempo Unix (segundos desde el 1 enero 1970)
metadata2 = FOREACH metadata GENERATE IDpelicula, nombrePelicula, ToUnixTime(ToDate(fecha, 'dd-MMM-yyyy')) AS fecha_seg;


-- PARTE 3
-- =======

-- Hacer un "join" usando los IDs de las peliculas
mejoresPeliculasFechas = JOIN mejoresPeliculas BY IDpelicula, metadata2 BY IDpelicula;

-- Ordenar las peliculas por fecha
mejoresPeliculasOrdenadas = ORDER mejoresPeliculasFechas BY metadata2::fecha_seg;

-- Mantener solo nombre de la pelicula y su puntaje
mejoresPeliculaOrdenadas2 = FOREACH mejoresPeliculasOrdenadas GENERATE metadata2::nombrePelicula, mejoresPeliculas::puntajePromedio;

-- Obtener solo las 10 preliculas mas antiguas
mejoresPeliculasAntiguas = LIMIT mejoresPeliculaOrdenadas2 10;

DUMP mejoresPeliculasAntiguas;

-- Almacenar contenido (se almacena en el directorio salida_peliculas)
STORE mejoresPeliculasAntiguas INTO 'salida_peliculas' USING PigStorage(',');
