## Crear catalogo de Alumnos
El objetivo de este documento es tener registro de como crear catalogos para integrar en desarrollos especiales a SAIT.

#### Alumnos Dbf
    - ID
    - Nombre
    - Apellidos
    - Grado
    - Grupo
    - Matricula
    - Fecha Naciemiento

1. Lo primero que se debe hacer es crear un proyecto ya sea meadiante comandos dentro del entorno de VFP o mediante el asistente de VFP.

```
    crea proj alumnos 
```

2. El siguiente paso es crear las formas que seran utilizadas en el modulo de estudiantes
    - Forma para el catalogo 
    - Forma para el CRUD del catalogo
    - Forma para hacer busqueda

Para crear la forma del catalogo se hace usando la clase catmsl de la libreria msllib60.vcx
```
    crea form alumnoscat as catmsl from f:\pedro\msllib60\msllib60.vcx
```
Para el catalogo no es necesario cambiar el diseño solo se agrega el siguiente codigo
```
*
*	init()
*

*
* 	OpenDbf
* Params
*	@ALumnos: Tabla
*	@ID: Indice
* Returns	
*	Si puede abrir la tabla retorna un .t. de lo contrario .f.
*

if not OpenDbf('Alumnos', 'ID')
    return .F. 
EndIf

*
* Params
*	@cAlias = Tabla que usara el grid
*	@cCatName = Nombre del catalogo
*	@FomaCatalogo = Forma para CRUD
*	@FormaBusqueda = Forma para buscar
*	@cAnchos = Anchos de las columnas del grid, se pasa como String separado por "|"
*	@cTitulo = Son los encabezados de las columnas del grid
*	@cExprs = Los campos que se mostraran en el grid
*

this.cAlias = 'Alumnos'
this.cCatName = 'alumnoscat'
this.FormaCatalogo = 'alumnosdat'
this.FormaBusqueda = 'ListAlu'
this.cAnchos = '50|100|100|50|50|80|100'
this.cTitulos = 'Clave|Nombre|Apellidos|Grado|Grupo|Matricula|Fecha nacimiento'
this.cExprs = 'Alumnos.ID|Alumnos.NOMBRE|Alumnos.APELLIDOS|Alumnos.GRADO|Alumnos.GRUPO|Alumnos.MATRICULA|Alumnos.FECHANAC'
```


Tambien es necesario crear una forma con la clase Formamsl para crear la ventana para el CRUD.\
```
    crea form alumnosdat as Formamsl from f:\pedro\msllib60\msllib60.vcx
```
Se agregan los campos requeridos a la interfaz y dos metodos y una propiedad

- SaveInfo: se usa para guardar o modificar registros
- CargarInfor: se usa para mostrar la info en el grid
- nModo: le indica a la ventana del CRUD en que modo mostrarse

Codigo de SaveInfo 
```
*
*	SaveInfo()
*	

with thisform
	select Alumnos
	replace ID 			with .txtClave.Value,;
			NOMBRE 		with Allt(.txtNombre.Value),;
			APELLIDOS 	with Allt(.txtApellidos.Value),;
			GRADO 		with Allt(.txtGrado.Value),;
			GRUPO 		with Allt(.txtGrupo.Value),;
			MATRICULA 	with Allt(.txtMatricula.Value),;
			FECHANAC 	with .txtFechaNac.dValue
endwith

```

Codigo de CargarInfo
```
    *
*	CargarInfo()
*

* Params
*	@Clave = Identificador de la tabla
*	@Nombre = Nombre del alumno
*	@Apellidos = Apelldios del alumno
*	@Grado = maximo un caracter ejemplo: 1, 2 o 3
*	@Grupo = maximo un caracter ejemplo: A, B o C
*	@Matricula = numero de expediente del alumno
*	@FechaNac = Fecha de nacimiento
*

with thisform
	.txtClave.Value = Alumnos.ID
	.txtNombre.Value = Alumnos.NOMBRE
	.txtApellidos.Value = Alumnos.APELLIDOS
	.txtGrado.Value = Alumnos.GRADO
	.txtGrupo.Value = Alumnos.GRUPO
	.txtMatricula.Value = Alumnos.MATRICULA
	.txtFechaNac.Value = Alumnos.FECHANAC
endwith

```

nModo 1.
![Ventana para agregar alumnos](./img/nModo1.png)

nModo 2.
![Ventana para actualizar alumnos](./img/nModo2.png)

nModo 3.
![Ventana para eliminar alumnos](./img/nModo3.png)




Para crear la ventana de busqueda es necesario crear una forma usando la clase busqueda
```
    crea form ListAlum as Busqueda from f:\pedro\msllib60\msllib60.vcx
```

Una vez creada la ventana es necesario colocar este codigo en el evento init
```
* 
*	busqueda.init ()
*

with thisform
	.cAnchos = '50,75,100'
	.cCamposBuscar = 'NOMBRE'
	.cCamposSelect = '*'
	.cExprs = 'ID, NOMBRE, APELLIDOS'
	.cFromTable = 'Alumnos'
	.cOrderBy = 'NOMBRE'
	.cRetVal = 'ID'
	.cSql = ''
endwith
```


3. Lo siguiente es crear un archivo PRG para copiar la aplicacion en SAIT y que se ejecute como modulo adicional.

codigo de make.prg

```
set safety off

build app alumnos from alumnos
copy file alumnos.app to F:\pedro\demo\alumnos.app

```

4. El codigo anterior compila lo que se desarrolló y lo coloca en la carpeta de SAIT

5. Lo siguiente es ver los resultado en SAIT

![Resultado](./img/resultado.png)


#### 