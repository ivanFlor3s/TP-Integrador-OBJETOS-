object laTrastienda {
	var capacidad = 400
	
	method esSabado(unDia) {
		return unDia.dayOfWeek() == 6
	}
	method capacidad(unDia) {
		return if (self.esSabado(unDia))  capacidad + 300 else capacidad
	}
	method concurrido(unDia) {
		return self.capacidad(unDia) > 5000
	}
}

object lunaPark{
	var capacidad = 9290
	method capacidad(unDia){
 		return capacidad 	
	}
	method concurrido(unDia){
		return self.capacidad(unDia) >5000
	}
}


class Lugar{
	var capacidad
	constructor(unaCapacidad){
		capacidad = unaCapacidad
	}
	method capacidad(unDia) = capacidad
}
