import Artistas.*
import Presentaciones.*
import lugares.*
import Canciones.*

class RequisitoCancionException inherits Exception{}
class RequisitoHabilidadException inherits Exception{}
class RequisitoCancionesCompuestasException inherits Exception{}

class RestriccionHabilidad{
	
	var habilidadMin
	constructor (unaHabilidad){
		habilidadMin = unaHabilidad
	}
	
	method validarA(unMusico){
		if (unMusico.habilidad() < habilidadMin) throw new RequisitoHabilidadException("Su habilidad no es suficiente")
	} 
}

class RestriccionCancion{
	var cancionAejec
	constructor (unaCancion){
		cancionAejec = unaCancion
	}
	method validarA(unMusico) { 
		if (unMusico.interpretaBien(cancionAejec).negate()) throw new RequisitoCancionException("No puede ejecutar bien la cancion que se pide")
	}
	
}
class RestriccionCancPublic{
	var cancionesCompMin
	constructor (cancionesCompuestas){
		cancionesCompMin = cancionesCompuestas
	}
	method validarA(unMusico) {
		if (unMusico.cantidadDeCancionesCompuestas()  < cancionesCompMin )throw new RequisitoCancionesCompuestasException("No tiene la cantidad de canciones compuestas minimas")
		}
}


class PresentacionConRestricciones inherits Presentacion{
	var listaRestricciones 
	constructor (lugar,fecha,listRestr) = super (lugar,fecha){
		listaRestricciones =listRestr
	}//tiENE mas sentido method agregar restriciones y ueg instanciarlos
	override method agregarCantante(unMusico){
		listaRestricciones.forEach({restriccion => restriccion.validarA(unMusico)})
		super(unMusico)
	}
}

