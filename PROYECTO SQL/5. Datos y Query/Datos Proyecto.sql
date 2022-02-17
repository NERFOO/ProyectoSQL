USE PROYECTO;

INSERT INTO USUARIOS 
	( dni, nom_usuario, apellidos )
VALUES 
	( "1234J", "Juan", "Calderón Acero" ),
	( "1235J", "Pepe", "Vazquez Cortés" ),
	( "1236J", "Laura", "Sanchez Cortes" ),
	( "1237J", "María", "Gonzalez Acero" ),
	( "1238J", "María Eugenia", "Garcia Ruiz" ),
	( "1239J", "Alba María", "Gomez Perez" );

INSERT INTO TIENDAS 
	( idtienda, nom_tienda, direccion )
VALUES 
	( NULL, "Movistar", "Avda/ de los pajares" ),
	( NULL, "Vodafone", "C/ La tomatera" ),
	( NULL, "Orange", "C/ Alfredo Suarez" ),
	( NULL, "Yoigo", "C/ Juan Benito" ),
	( NULL, "Amena", "Avda/ Reyes Católicos" );

INSERT INTO MEMORIASRAM
	( idmemoriaRAM, capacidadRAM )
VALUES 
	( NULL, 4 ),
	( NULL, 2 ),
	( NULL, 8 ),
	( NULL, 126 ),
	( NULL, 64 ),
	( NULL, 32 ),
	( NULL, 16 );
	
INSERT INTO MEMORIASROM
	( idmemoriaROM, capacidadROM )
VALUES 
	( NULL, 1 ),
	( NULL, 2 ),
	( NULL, 3 ),
	( NULL, 4 );

INSERT INTO MARCAS_MODELOS
	( idmarca, nom_marca )
VALUES 
	( NULL, "Samsung" ),
	( NULL, "Apple" ),
	( NULL, "Huawei" ),
	( NULL, "BQ" );

INSERT INTO MARCAS_HARDWARE
	( idmarca2, tipo )
VALUES 
	( NULL, "Exynos" ),
	( NULL, "ARM" ),
	( NULL, "Kirin" );

INSERT INTO COMPONENTES
	( idcomponente, nom_componente )
VALUES 
	( NULL, "Pantalla Externa" ),
	( NULL, "Batería" ),
	( NULL, "Carcasa" ),
	( NULL, "Pantalla Interna" ),
	( NULL, "Cargador" ),
	( NULL, "Funda" );
	
INSERT INTO TIENDAS_CONTIENEN_COMPONENTES
	( idtienda, idcomponente )
VALUES 
	( 1, 1 ),
	( 1, 4 ),
	( 2, 2 ),
	( 2, 3 ),
	( 2, 5 ),
	( 2, 6 );

INSERT INTO MODELOS
	( idmodelo, nom_modelo, idmarca )
VALUES 
	( NULL, "Galaxy S9", 1 ),
	( NULL, "Galaxy S7", 1 ),
	( NULL, "iPhone XR", 2 ),
	( NULL, "iPhone X", 2 ),
	( NULL, "iPhone 6s", 2 ),
	( NULL, "iPhone 5s", 2 ),
	( NULL, "P20", 3),
	( NULL, "P20 PRO", 3),
	( NULL, "P10", 3),
	( NULL, "P10 PLUS", 3),
	( NULL, "Galaxy J7 2017", 1 ),
	( NULL, "Galaxy J7", 1 );

INSERT INTO MOVILES
	( idmovil, nom_movil, precio, pantalla, sistema_ope, camara, bateria, color, imagen, idmodelo )
VALUES 
	( NULL, "Samsung Galaxy J7 2017", 349, "5,5", "Android", 13, 3600, "Blanco", "falta imagen", 11 ),
	( NULL, "Samsung Galaxy J7", 239, "5,5", "Android", 13, 3000, "Blanco", "falta imagen", 12 ),
	( NULL, "Samsung Galaxy S9", 849, "5,8", "Android", 12, 3000, "Negro", "falta imagen", 1 ),
	( NULL, "Samsung Galaxy S7", 719, "5,1", "Android", 12, 3000, "Negro", "falta imagen", 2 ),
	( NULL, "Apple iPhone 6S", 749, "4,7", "IOS", 12, 1715, "Rojo", "falta imagen", 5 ),
	( NULL, "Apple iPhone 5S", 699, "4,0", "IOS", 8, 1560, "Blanco", "falta imagen", 6 ),
	( NULL, "Apple iPhone X", 1159, "5,8", "IOS", 12, 2716, "Rojo", "falta imagen", 4 ),
	( NULL, "Apple iPhone XR", 859, "6,1", "IOS", 12, 3000, "Blanco", "falta imagen", 3 ),
	( NULL, "Huawei P20", 649, "5,8", "Android", 12, 3400, "Negro", "falta imagen", 7 ),
	( NULL, "Huawei P20 PRO", 899, "6,1", "Android", 40, 4000, "Negro", "falta imagen", 8 ),
	( NULL, "Huawei P10", 649, "5,1", "Android", 20, 3200, "Rojo", "falta imagen", 9 );

INSERT INTO TIENDAS_VENDER_MOVILES
	( idtienda, idmovil )
VALUES 
	( 1, 1 ),
	( 2, 2 ),
	( 2, 3 ),
	( 2, 4 ),
	( 3, 5 ),
	( 1, 6 ),
	( 1, 7 ),
	( 2, 8 ),
	( 2, 9 ),
	( 2, 10 ),
	( 3, 11 );

INSERT INTO MOVILESREL
	( idmovil, idmovil2 )
VALUES 
	( 8, 2 ),
	( 1, 4 ),
	( 11, 6 ),
	( 7, 2 ),
	( 4, 11 ),
	( 3, 5 );

INSERT INTO MOVILES_ELEGIR_CAPACIDAD
	( idmovil, idmemoriaRAM, idmemoriaROM )
VALUES 
	( 5, 7, 2 ),
	( 3, 2, 3 ),
	( 7, 1, 3 ),
	( 1, 3, 1 ),
	( 8, 5, 2 ),
	( 11, 6, 1 );

INSERT INTO HARDWARE
	( idhardware, nucleo, idmarca2 )
VALUES 
	( NULL, "Octacore", 1 ), 
	( NULL, "Quadcore", 1 ),
	( NULL, "Quadcore", 1 ),
	( NULL, "Quadcore", 1 ),
	( NULL, "Quadcore", 1 ),
	( NULL, "Quadcore", 1 ),
	( NULL, "Quadcore", 1 ),
	( NULL, "Hexacore", 2 ),
	( NULL, "Quadcore", 2 ),
	( NULL, "Hexacore", 2 ),
	( NULL, "Hexacore", 2 ),
	( NULL, "Quadcore", 3 ),
	( NULL, "Quadcore", 3 ),
	( NULL, "Quadcore", 3 ),
	( NULL, "Quadcore", 3 ),
	( NULL, "Quadcore", 3 ),
	( NULL, "Quadcore", 3 );

INSERT INTO COMPRAS
	( idtienda, idmovil, dni, fech_compra )
VALUES 
	( 2, 3, "1235J", "2015/08/11" ),
	( 3, 11, "1236J", "2017/01/11" ),
	( 2, 4, "1234J", "2020/01/10" ),
	( 2, 8, "1236J", "2020/01/05" ),
	( 1, 7, "1234J", "2015/05/13" ),
	( 3, 11, "1237J", "2019/01/11" ),
	( 2, 4, "1235J", "2018/02/10" ),
	( 2, 8, "1234J", "2020/01/01" ),
	( 1, 7, "1236J", "2015/9/13" ),
	( 2, 10, "1234J", "2017/10/10" );
	
INSERT INTO MOVILES_TIENEN_HARDWARE
	( idmovil, idhardware, cpu, vel_cpu )
VALUES 
	( 1, 1, 1, 1.60 ),
	( 3, 2, 1, 1.40 ),
	( 3, 3, 2, 1.00 ),
	( 11, 16, 1, 2.36 ),
	( 11, 17, 2, 1.84 ),
	( 8, 11, 1, 2.40 ),
	( 5, 8, 2, 1.60 );

