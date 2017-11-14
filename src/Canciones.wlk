class Album {
	var listaDeCanciones = #{}
	var titulo
	var fechaLanzamiento
	var unidades
	var unidadesVendidas

	constructor(tituloDisco,dia,mes,anio, unidadesQueSalieron, unidadesQueSeVendieron) {
		fechaLanzamiento = new Date(dia,mes,anio)
		 titulo = tituloDisco
		unidades = unidadesQueSalieron
		unidadesVendidas = unidadesQueSeVendieron
	}
	method listaCanciones()= listaDeCanciones.join()
	
	
	method agregarCancion(cancion){
		listaDeCanciones.add(cancion)
	}

	method esDeDuracionCorta() {
		return listaDeCanciones.all({ cancion => cancion.esCorta() })
	}
	method duracionMasLarga() {
		return listaDeCanciones.max({ cancion => cancion.longitud() })
	}
	method buenasVentas() = unidadesVendidas >= 0.75 * unidades
	
	method queCancionesContienen(palabra) {
		return listaDeCanciones.filter({ cancion => cancion.contiene(palabra) })
	}
	method duracionTotal() {
		return listaDeCanciones.sum({ cancion => cancion.duracion() })
	}
	method compararCanciones(unCriterio){
		return unCriterio.comparar(listaDeCanciones)
	}
	method tieneLa(cancion){
		return listaDeCanciones.contains(cancion)
	}
	method cantCanciones() = listaDeCanciones.size()
}


class Cancion {
	var nombre
	var duracion
	var letra

	constructor(nombreCancion, duracionCancion, letraCancion) {
		nombre = nombreCancion duracion = duracionCancion letra = letraCancion
	}
	method duracion()= duracion
	
	method letra()= letra
	
	method titulo() = nombre
	
	method contiene(palabra) = letra.contains(palabra)
	
	method longitud()= letra.size()
	
	method esCorta()= duracion < 180
	
	method cancionMas(criterio,otraCancion)= criterio
	
	method duraMasQue(otraCancion)= duracion > otraCancion.duracion()
	
	method tieneMasLetrasQue(otraCancion)= self.longitud() > otraCancion.longitud()
	
	method tituloMasLargoQue(otraCancion)= self.titulo().size() > otraCancion.titulo().size()
	
	method tieneLaPalabra(unaPalabra) = letra.contains(unaPalabra)
	
	method duraMasDe(unaDuracion) = duracion > unaDuracion
	
	method suDuracionEsImpar() = duracion.odd() 
}

class Remix inherits Cancion {
	constructor(unaCancion) = super(unaCancion.titulo(), unaCancion.duracion()*3,"mueve tu cuelpo baby "+unaCancion.letra()+" yeah oh yeah" ) {}
}

class Mashup inherits Cancion{                            //max({...}) mal?
	constructor(unasCanciones) = super(null,unasCanciones.map({c=>c.duracion()}).max(), unasCanciones.map({c=>c.letra()}).join(" ")){ }	
}

object porLetra{
	method comparar(lista)= lista.max({c=>c.longitud()}).titulo()
	
}
object porDuracion{
	method comparar(lista)= lista.max({c=>c.duracion()}).titulo()
	
}

object porTitulo{
	method comparar(lista)= lista.max({c=>c.titulo().size()}).titulo()
	
}
