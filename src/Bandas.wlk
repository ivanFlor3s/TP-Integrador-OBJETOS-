import Canciones.*
import Artistas.*

class InterpretacionException inherits Exception {}

class Banda{
	var integrantes = #{}
	var representante 
	var quimica
	constructor(unRepresentante,tipoDeQuimica){
		representante = unRepresentante
		quimica = tipoDeQuimica
	}
	
	method miembros() = integrantes
	method nuevoIntegrante(unMusico){
		integrantes.add(unMusico)
	}
	method discosEditados(){
		integrantes.map({integ=>integ.discosMusico()})
	}
	method interpretanBien(unaCancion) = integrantes.all({int=>int.interpretaBien(unaCancion)})
	
	method tocar(unaCancion){
		if(self.interpretanBien(unaCancion).negate()) throw new InterpretacionException("Un catante no ejecuta bien la cancion") 
	}
	method habilidadBanda(){
		return integrantes.sum({i=>i.habilidad()}) * (1 + quimica.bonus(self))
	}
	method cobraBanda(unaPresentacion){
		return integrantes.sum({i=>i.cobra(unaPresentacion)}) + representante.cobra(unaPresentacion)	
	}
	method representanteBanda() = representante
}

class Representante{

	var cuantoCobra
	constructor(unaCantidad){
		cuantoCobra = unaCantidad
	}
	method cobra(unaPresentacion) = cuantoCobra
	method habilidad() = 0
}

object buenaQuimica{
	method bonus(unaBanda) = 0.1
}
object noHayQuimica{
	method bonus(unaBanda) = 0
}