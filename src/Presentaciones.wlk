import Bandas.*

class Presentacion{
	var lugar
	var cantantes = #{}
	var fechaDePresentacion
	var banda = object {method miembros()= #{}
		method cobraBanda(x) = 0
	}
	constructor(unLugar,unaFecha){
		lugar = unLugar
		fechaDePresentacion = unaFecha
	}
	method modificarFecha(unaFecha){
		fechaDePresentacion = unaFecha
	}
	method modificarLugar(nuevoLugar){
		lugar = nuevoLugar
	}
	method agregarCantante(cantante){
		cantantes.add(cantante)
	}
	method quitarCantante(unCantante){
		cantantes.remove(unCantante)
	}
	method esEnLugarConcurrido(){
		return lugar.concurrido(fechaDePresentacion)
	}
	method esAntesDeSeptiembre2017() {
		return fechaDePresentacion.month() >= 9 && fechaDePresentacion.year()==2017 
	}
	method meterUnaBanda(unaBanda){
		banda=unaBanda
	}
	method costo(){
		return cantantes.sum({cantante => cantante.cobra(self)}) + banda.cobraBanda(self)
	}
	method esEnSeptiembre(){
		return fechaDePresentacion.month() == 9
	}
	method fecha(){
		return fechaDePresentacion
	}
	method artistas()=cantantes
	
	method hayMasDeUnArtista() {
		 return cantantes.size() > 1 || banda != null
	}
	method lugarConCapacidadMayorA(unaCant) = lugar.conCapacidadMayorA(unaCant)
	
	method antesDe(unaFecha) = fechaDePresentacion < unaFecha
	
	method actuaConSuBanda(unMusico) = banda.miembros().contains(unMusico)
	method magia(){
		return cantantes.sum({c=>c.habilidad()}) + banda.habilidadBanda()
	}
}


