USE PROYECTO;

-- 
-- 1. MUESTRA TODAS LAS PERSONAS QUE CONTENGAN EN SU NOMBRE MARIA Y SU APELLIDO EMPIEZE POR G Y ACABE EN Z.
-- 

SELECT nom_usuario, apellidos
FROM USUARIOS
WHERE nom_usuario LIKE "%María%"
AND( apellidos LIKE "G%"
OR apellidos LIKE "%o" );

-- 
-- 2. MUESTRA LAS TIENDAS QUE NO TENGAN MOVILES.
-- 

SELECT nom_tienda
FROM TIENDAS_VENDER_MOVILES
RIGHT JOIN TIENDAS
ON TIENDAS_VENDER_MOVILES.idtienda = TIENDAS.idtienda
WHERE TIENDAS_VENDER_MOVILES.idtienda IS NULL;

-- 
-- 3. MUESTRA LOS MOVILES QUE SEAN DE COLOR BLANCO Y NEGRO PERO CON MAS DE 5.0" y CON MENOS DE 6.0" PERO QUE HAYAN SIDO COMPRADOS.
-- 

SELECT nom_movil, color, pantalla
FROM MOVILES, TIENDAS_VENDER_MOVILES, COMPRAS
WHERE MOVILES.idmovil = TIENDAS_VENDER_MOVILES.idmovil
AND TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda
AND color IN ( "Blanco", "Negro" )
AND pantalla BETWEEN "5,0" AND "6,0";

-- 
-- 4. CUENTA EL NUMERO DE MOVILES POR COLOR. QUE TENGAN UNA PANTALLA SUPERIOR A 4.9".
-- QUE SEAN MAS BARATOS A 800€. Y QUE SOLAMENTE SEAN DE COLOR NEGRO.
-- PERO SI LA CUENTA ES INFERIOR A 3 QUE APAREZCA.
-- 

SELECT color, pantalla, precio, COUNT( color ) AS NUMERO_MOVILES
FROM MOVILES
WHERE precio < 800
AND pantalla > "4.9"
AND color = "Blanco"
GROUP BY color, pantalla
HAVING NUMERO_MOVILES < 3;

-- 
-- 5. CALCULA LA MEDIA DE TODOS LOS MOVILES RELACIONADOS.
-- 

SELECT ROUND( AVG( precio ), 2 ) AS MEDIA_PRECIO
FROM MOVILES
INNER JOIN MOVILESREL
ON MOVILES.idmovil = MOVILESREL.idmovil
OR MOVILES.idmovil = MOVILESREL.idmovil2;

-- 
-- 6. MUESTRA DE LOS MOVILES VENDIDOS EL DINERO OBTENIDO DE CADA UNO Y EL PRECIO TOTAL DE LAS VENTAS.
-- 

SELECT CASE WHEN nom_movil IS NULL
			THEN "TOTAL :"
			ELSE nom_movil
	    END AS nom_movil,
		SUM( precio ) AS OBTENIDO_POR_MODELO
FROM MOVILES, TIENDAS_VENDER_MOVILES, COMPRAS
WHERE MOVILES.idmovil = TIENDAS_VENDER_MOVILES.idmovil
AND TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda
GROUP BY nom_movil WITH ROLLUP;

-- 
-- 7. CUENTA CUANTOS MODELOS DIFERENTES SE HAN COMPRADO.
-- 

SELECT COUNT( DISTINCT nom_modelo ) AS MODELOS
FROM MODELOS, MOVILES, TIENDAS_VENDER_MOVILES, COMPRAS
WHERE MODELOS.idmodelo = MOVILES.idmodelo
AND MOVILES.idmovil = TIENDAS_VENDER_MOVILES.idmovil
AND TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda;

-- 
-- 8. MUESTRA LOS MOVILES QUE NO HAN SIDO COMPRADOS POR CADA TIENDA.
-- 

SELECT TIENDAS_VENDER_MOVILES.idtienda, nom_marca
FROM MARCAS_MODELOS
INNER JOIN MODELOS
ON MARCAS_MODELOS.idmarca = MODELOS.idmarca
INNER JOIN MOVILES
ON MODELOS.idmodelo = MOVILES.idmodelo
INNER JOIN TIENDAS_VENDER_MOVILES
ON MOVILES.idmovil = TIENDAS_VENDER_MOVILES.idmovil
LEFT JOIN COMPRAS
ON TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda
WHERE COMPRAS.idmovil IS NULL
ORDER BY TIENDAS_VENDER_MOVILES.idtienda;

--
-- 9. QUIERO SABER LAS TIENDAS QUE VENDAN LA MARCA APPLE PERO QUE NO HAYAN VENDIDO EN EL ULTIMO MES.
-- 

SELECT nom_tienda, nom_marca, fech_compra
FROM MARCAS_MODELOS
INNER JOIN MODELOS
ON MARCAS_MODELOS.idmarca = MODELOS.idmarca
INNER JOIN MOVILES
ON MODELOS.idmodelo = MOVILES.idmodelo
INNER JOIN TIENDAS_VENDER_MOVILES
ON MOVILES.idmovil = TIENDAS_VENDER_MOVILES.idmovil
INNER JOIN TIENDAS
ON TIENDAS.idtienda = TIENDAS_VENDER_MOVILES.idtienda
INNER JOIN COMPRAS
ON TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda
WHERE nom_marca = "Apple"
AND DATEDIFF( CURDATE(), fech_compra ) >= 31;

-- 
-- 10. MUESTRA LAS MARCAS QUE VENDE CADA TIENDA.
-- 

SELECT nom_tienda, nom_marca
FROM TIENDAS
INNER JOIN TIENDAS_VENDER_MOVILES
ON TIENDAS.idtienda = TIENDAS_VENDER_MOVILES.idtienda
LEFT JOIN COMPRAS
ON TIENDAS_VENDER_MOVILES.idmovil = COMPRAS.idmovil
AND TIENDAS_VENDER_MOVILES.idtienda = COMPRAS.idtienda
INNER JOIN MOVILES
ON COMPRAS.idmovil = MOVILES.idmovil
INNER JOIN MODELOS
ON MOVILES.idmodelo = MODELOS.idmodelo
INNER JOIN MARCAS_MODELOS
ON MODELOS.idmarca = MARCAS_MODELOS.idmarca
GROUP BY nom_tienda, nom_marca
ORDER BY nom_tienda;

-- 
-- 11. QUIERO SABER QUE MOVILES HAN SIDO COMPRADOS, QUE TENGAN UNA MEMORIA RAM DE ENTRE 8 Y 64 GB, Y QUE SU NUCLEO SEA DE TIPO QUADCORE.
-- 

SELECT MOVILES.idmovil, TIENDAS_VENDER_MOVILES.idtienda, nom_movil, capacidadRAM, nucleo
FROM COMPRAS, TIENDAS_VENDER_MOVILES, MOVILES, MOVILES_ELEGIR_CAPACIDAD, MEMORIASRAM, MOVILES_TIENEN_HARDWARE, HARDWARE
WHERE COMPRAS.idmovil = TIENDAS_VENDER_MOVILES.idmovil
AND COMPRAS.idtienda = TIENDAS_VENDER_MOVILES.idtienda
AND TIENDAS_VENDER_MOVILES.idmovil = MOVILES.idmovil
AND MOVILES.idmovil = MOVILES_ELEGIR_CAPACIDAD.idmovil
AND MOVILES_ELEGIR_CAPACIDAD.idmemoriaRAM = MEMORIASRAM.idmemoriaRAM
AND MOVILES.idmovil = MOVILES_TIENEN_HARDWARE.idmovil
AND MOVILES_TIENEN_HARDWARE.idhardware = HARDWARE.idhardware
AND capacidadRAM BETWEEN 8 AND 64
AND nucleo = "Quadcore"
GROUP BY nom_movil;

-- 
-- 12. MUESTRA EL MOVIL MAS BARATO QUE TENGA 12MP DE CAMARA.
-- 

SELECT nom_movil, MIN( precio ) AS PRECIO_MAS_BARATO
FROM MOVILES
WHERE camara = 12
AND precio IN ( SELECT MIN( precio ) AS PRECIO_MAS_BARATO
				FROM MOVILES
				WHERE camara = 12 )
GROUP BY nom_movil;

-- 
-- 13. MUESTRA EL NOMBRE DEL MOVIL MAS CARO DE CADA MARCA.
-- 

SELECT nom_marca, nom_movil, precio
FROM MOVILES
INNER JOIN MODELOS
ON MOVILES.idmodelo = MODELOS.idmodelo
INNER JOIN MARCAS_MODELOS
ON MODELOS.idmarca = MARCAS_MODELOS.idmarca
WHERE precio IN ( SELECT MAX( precio ) AS MOVIL_MAS_CARO
					FROM MOVILES
					INNER JOIN MODELOS
					ON MOVILES.idmodelo = MODELOS.idmodelo
					INNER JOIN MARCAS_MODELOS
					ON MODELOS.idmarca = MARCAS_MODELOS.idmarca
					GROUP BY nom_marca )
GROUP BY nom_marca, nom_movil; 

-- 
-- 14. MUESTRA LOS MOVILES QUE ESTAN RELACIONADOS CON OTROS.
-- 

SELECT nom_movil MOVIL, ( SELECT nom_movil
							FROM MOVILES, MOVILESREL T2
							WHERE MOVILES.idmovil = T2.idmovil2
							AND T1.idmovil = T2.idmovil
							AND T1.idmovil2 = T2.idmovil2 ) AS RELACIONADO
FROM MOVILES, MOVILESREL T1
WHERE MOVILES.idmovil = T1.idmovil;

-- 
-- 15. QUIERO SABER LAS TIENDAS QUE NO HAN VENDIDO NINGUN MOVIL DE LAS MARCAS QUE ELLAS VENDAN REALIZADAS EN EL ULTIMO MES.
-- 

SELECT nom_tienda, nom_marca
FROM MARCAS_MODELOS
INNER JOIN MODELOS
ON MARCAS_MODELOS.idmarca = MODELOS.idmarca
INNER JOIN MOVILES
ON MODELOS.idmodelo = MOVILES.idmodelo
INNER JOIN TIENDAS_VENDER_MOVILES T1
ON MOVILES.idmovil = T1.idmovil
INNER JOIN TIENDAS
ON T1.idtienda = TIENDAS.idtienda 
WHERE MARCAS_MODELOS.idmarca NOT IN ( SELECT MARCAS_MODELOS.idmarca
										FROM MARCAS_MODELOS
										INNER JOIN MODELOS
										ON MARCAS_MODELOS.idmarca = MODELOS.idmarca
										INNER JOIN MOVILES
										ON MODELOS.idmodelo = MOVILES.idmodelo
										INNER JOIN TIENDAS_VENDER_MOVILES T2
										ON MOVILES.idmovil = T2.idmovil
										INNER JOIN COMPRAS
										ON T2.idmovil = COMPRAS.idmovil
										AND T2.idtienda = COMPRAS.idtienda
										WHERE T1.idtienda = T2.idtienda
                                   		AND DATEDIFF( CURDATE(), fech_compra ) <= 31 ) 
GROUP BY nom_tienda, nom_marca;

-- 
-- 16. MUESTRA SOLAMENTE EL SEGUNDO PRECIO MAS CARO. 
-- 

WITH T1 AS ( SELECT *
				FROM MOVILES
				WHERE precio != ( SELECT MAX( precio )
									FROM MOVILES ) )
SELECT nom_movil, MAX( precio ) 
FROM T1 
WHERE precio = ( SELECT MAX( precio )
					FROM T1 )
GROUP BY idmovil;

-- 
-- 17. MUESTRA EL TERCER PRECIO MAS CARO Y EL SEGUNDO PRECIO MAS BARATO DE CADA MARCA QUE HAYA SIDO COMPRADO POR UN USUARIO EN LA TIENDA 2.
-- 



