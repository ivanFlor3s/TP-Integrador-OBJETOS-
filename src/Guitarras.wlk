object gibson{
	
	var estaRota = false
	method unidades(){
		return if(estaRota) return 5 else 15
	}
	method cambiarARota(){
		estaRota = true
	}
	
	method cambiarASana(){
		estaRota = false
	}
}

object fender{
	method unidades()= 10
}
