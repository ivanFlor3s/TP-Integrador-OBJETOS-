import Guitarras.*
import Canciones.*
import Bandas.*
class Musico {
	var habilidadGeneral
	var listaAlbumes = #{} 
	var estilo = object {method seAdecuaA(x)=false} //definir un objeto otra forma
	var formaDeCobrar = object {method aplicaA(x)=0} // otra solucion en el constructor usar la fornade cobrar, otra 2 constructores
	constructor(cuantaHabilidad) {
		habilidadGeneral = cuantaHabilidad 
	}
	constructor(cuantaHabilidad,unEstilo,unaFormaDeCobrar){
		habilidadGeneral = cuantaHabilidad
		estilo = unEstilo
		formaDeCobrar = unaFormaDeCobrar
	} 
	method agregarAlbumPublicado(album){
		listaAlbumes.add(album)
	}
	method esMinimalista() {
		return listaAlbumes.all({ album => album.esDeDuracionCorta()})
	}
	method discosMusico(){
		listaAlbumes.map({album=>album.listaCanciones()}).join()
	}
	method contieneLaPalabra(palabra) {
		return listaAlbumes.flatMap({ album => album.queCancionesContienen(palabra)})
	}
	method duracionObra() {
		return listaAlbumes.sum({ album => album.duracionTotal() })
	}
	method laPego() {
		return listaAlbumes.all({ album => album.buenasVentas() })
	}
	method agregarAlbum(listaDeAlbumesAAgregar) {
		listaAlbumes.add(listaDeAlbumesAAgregar)
	}
	method interpretaBien(cancion){
		return self.esdesuautoria(cancion) || self.habilidad() > 60 || estilo.seAdecuaA(cancion)
	}
	method esdesuautoria(unaCancion){
		return listaAlbumes.any{album=>album.tieneLa(unaCancion)}
	}
	method cobra(unaPresentacion){
		return formaDeCobrar.aplicaA(unaPresentacion)
	}
	method cantidadDeCancionesCompuestas(){
		return listaAlbumes.sum({a=>a.cantCanciones()})
	}
	method hacerse(unEstilo){
		estilo = unEstilo
	}
	method cobrarDeUnaForma(unaForma){
		formaDeCobrar = unaForma
	}
	method habilidad() = habilidadGeneral
	
	method cualesPuedeInterpretar(unasCanciones){
		return unasCanciones.filter({unaCancion=>self.interpretaBien(unaCancion)})
	}
	}


class Habilidad{
	var cantDeHab
	constructor(unaCant){
		cantDeHab = unaCant
	}
	method aumentarUnaCant(unaCant){
		cantDeHab += unaCant
	}
	method restarUnaCant(unaCant){
		cantDeHab -= unaCant
	}
	method cantidadHab()=cantDeHab
}

class MusicoDeGrupo inherits Musico {
	var habilidadParticular 
	var habilidadActual = 0
	constructor(habGeneral,habParticular) = super ( habGeneral) {
		habilidadParticular = habParticular
	}
	
	override method interpretaBien(unaCancion) {
		return unaCancion.duraMasDe(300) || super(unaCancion)
	} 

	method hacerseSolista(){
		var habilidadAux = new Habilidad(habilidadGeneral)
		habilidadActual = habilidadAux.cantidadHab()
		
	}
	method entrarEnGrupo(){
		var habilidadAux = new Habilidad(habilidadGeneral)
		habilidadAux.aumentarUnaCant(habilidadParticular)
		habilidadActual = habilidadAux.cantidadHab()
	}
	method aumentarHab(unaCant){
		habilidadGeneral += unaCant
	}
	override method habilidad() = habilidadActual
}

class VocalistaPopular inherits Musico {
	var habilidadActual = 0
	
	method entrarEnGrupo(){
		var habilidadAux = new Habilidad(habilidadGeneral)
		habilidadAux.restarUnaCant(20)
		habilidadActual = habilidadAux.cantidadHab()
	}
	method hacerseSolista(){
		var habilidadAux = new Habilidad(habilidadGeneral)
		habilidadActual = habilidadAux.cantidadHab()
	}
	override method habilidad() = habilidadActual
}


class Guitarrista inherits Musico{
	var guitarra
	
	constructor(habGeneral,unaGuitarra)= super(habGeneral){
		guitarra=unaGuitarra
	}
	
	override method habilidad() {
		return 100.min(guitarra.unidades() * 8)
	}
	override method interpretaBien(cancion) = true
	
	override method cobra(presentacion) {
		return if (presentacion.esAntesDeSeptiembre2017()) 1200 
		else 1000 
	}

	method guitarra(unaGuitarra) {
		guitarra = unaGuitarra
	}
}

class Palabrero {
	var palabra
	constructor (palabra1){
		palabra= palabra1
	}
	method seAdecuaA(unaCancion)= unaCancion.tieneLaPalabra(palabra)
	
}

class Larguero {
	var duracion
	constructor (palabra1){
		duracion= palabra1
	}
	method seAdecuaA(unaCancion) = unaCancion.duraMasDe(duracion)
	
}

class Imparero {
	method seAdecuaA(unaCancion) = unaCancion.suDuracionEsImpar()
}


class SegunTocaSolo{
	var cantidadOriginal
	constructor(unaCantidad){
		cantidadOriginal = unaCantidad
	}
	method aplicaA(unaPresentacion) {
		return if(unaPresentacion.hayMasDeUnArtista() || unaPresentacion.actuaConSuBanda(self))  cantidadOriginal/2
		else cantidadOriginal
	}
}

class SegunCapac{
	var cantidad
	var capacidadMin
	constructor(unaCant,unaCapacidad){
		cantidad = unaCant
		capacidadMin = unaCapacidad
	}
	method aplicaA(unaPresentacion){
		return if(unaPresentacion.lugarConCapacidadMayorA(capacidadMin)) cantidad
		else cantidad - 100
	}
}

class SegunInflacion{
	var cantidad
	var fechaLimite
	var porcentajeExtra
	constructor(unaCantidad,unaFecha,unPorcentaje){
		cantidad = unaCantidad
		fechaLimite = unaFecha
		porcentajeExtra = unPorcentaje
	}
	method aplicaA(unaPresentacion){
		return if(unaPresentacion.antesDe(fechaLimite)) cantidad
		else cantidad*(1 + porcentajeExtra/100)
	}
}

