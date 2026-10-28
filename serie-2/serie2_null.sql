--Ejercicio 1
--Devuelve 0 filas, aunque hay personas sin teléfono.
--NULL significa "valor desconocido": compararlo con = da UNKNOWN (ni verdadero ni falso),
--y el WHERE solo deja pasar las filas verdaderas. Para buscar nulos se usa IS NULL.
SELECT * FROM persona WHERE telefono = NULL;

--Ejercicio 2
--IS NULL → trae los vacíos.
--IS NOT NULL → trae los que tienen dato.
--Lo mismo que antes: nunca <> NULL, porque también da UNKNOWN y te devuelve 0 filas. (<> distinto de)
SELECT persona_id, apellido_nombre, telefono FROM persona WHERE telefono IS NULL;

--Ejercicio 3
SELECT persona_id, apellido_nombre,telefono
FROM persona
WHERE telefono IS NOT NULL

--Ejercicio 4
SELECT persona_id, ISNULL(apellido_nombre,'(Sin dato)') AS 'apellido_nombre', ISNULL(telefono,'(Sin dato)') AS 'telefono'
FROM persona

--Ejercicio 5
SELECT * FROM provincia WHERE provincia_id = 7

SELECT COALESCE(nombre , capital,'(Desconocido)') AS 'nombre'
FROM provincia

--Ejercicio 6
SELECT gasto_id, periodo, importe 
FROM gasto
WHERE importe IS NULL

--Ejercicio 7
--Los registros con importe NULL dan NULL en el cálculo:
--cualquier operación con NULL da NULL, porque no se puede calcular el 10% de un valor desconocido.
SELECT gasto_id, importe, importe * 0.10 AS 'diez_por_ciento'
FROM gasto;

--Ejercicio 8
SELECT gasto_id,ISNULL(importe,0), ISNULL(importe, 0) * 0.10 AS 'diez_por_ciento'
FROM gasto

--Ejercicio 9
SELECT AVG(importe) AS 'promedio_sin_nulos', AVG(ISNULL(importe,0)) AS 'promedio_con_ceros'
FROM gasto

--Ejercicio 10
SELECT COUNT(*) AS 'cantidad_total', COUNT(importe) AS 'cantidad_no_null'
FROM gasto
--COUNT(*) cuenta todas las filas (8000).
--COUNT(importe) no cuenta los NULL (7000). La diferencia son los 1000 gastos sin importe.



