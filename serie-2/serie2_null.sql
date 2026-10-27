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