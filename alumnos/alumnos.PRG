*
* Alumnos()
*

procedure alumnos
	addBar('Ventas','Alumnos','do doForm with "alumnoscat" in Alumnos.app')
	crearCampos()
return

*
* doForm()
*
procedure DoForm
lParameters formName,Par1,Par2,Par3,Par4,Par5,Par6,Par7,Par8,Par9

    do case
    case parameters()=1
        do form (formname) 
    case parameters()=2
        do form (formName) with m.Par1 
    case parameters()=3
        do form (formName) with m.Par1,m.Par2 
    case parameters()=4
        do form (formName) with m.Par1,m.Par2,m.Par3
    case parameters()=5
        do form (formName) with m.Par1,m.Par2,m.Par3,m.Par4 
    case parameters()=6
        do form (formName) with m.Par1,m.Par2,m.Par3,m.Par4,m.Par5 
    case parameters()=7
        do form (formName) with m.Par1,m.Par2,m.Par3,m.Par4,m.Par5,Par6
    case parameters()=8
        do form (formName) with m.Par1,m.Par2,m.Par3,m.Par4,m.Par5,Par6,Par7
    case parameters()=9
        do form (formName) with m.Par1,m.Par2,m.Par3,m.Par4,m.Par5,Par6,Par7,Par8
    endCase

return

*
*	CrearCampos()
*

procedure crearCampos
	if not file('alumnos.dbf')
		create table alumnos (;
				ID c(5),;
				NOMBRE c(50),;
				APELLIDOS c(50),;
				GRADO c(1),;
				GRUPO c(1),;
				MATRICULA c(20),;
				FECHANAC d(8) )
		select alumnos
		index on ID tag id
		use
		cKey = ;
			"delete tag all " + chr(13) +;
			"index on ID tag id" + chr(13)
		strtofile(cKey, 'alumnos.key')
	endif
	
	if not file('alumnos.dbf')
		alerta('No existe alumnos.dbf')
		quitit()
	endif
			
return

