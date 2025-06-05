//sabores
object frutilla {
	method esSaborValido() = true
}
object chocolate {
	method esSaborValido() = true
}
object vainilla {
	method esSaborValido() = true
}
object naranja {
	method esSaborValido() = true
}
object limon {
	method esSaborValido() = true
}


/*
 * Golosinas
 */
class Bombon {
	var peso = 15
	
	//Metodos de consulta
	method precio() { return 5 }
	method peso() { return peso }
	method sabor() { return frutilla }
	method libreGluten() { return true }
	method esBaniada() = false

	//Metodos de indicacion
	method mordisco() { peso = peso * 0.8 - 1 }
}
// ^
// |
class BombonDuro inherits Bombon {
	method dureza() = if (peso > 12) 3 else if(peso < 12 and peso > 8) 2 else 1

	override method mordisco() {
		peso = 0.max(peso - 1)
	}
}

class Alfajor {
	var peso = 15
	
	method precio() { return 12 }
	method peso() { return peso }
	method mordisco() { peso = peso * 0.8 }
	method sabor() { return chocolate }
	method libreGluten() { return false }
	method esBaniada() = false
}

class Caramelo {
	var property sabor
	var peso = 5

	method initialize() {
		if (! sabor.esSaborValido()){
			self.error("Debes ingresar un valor de sabor valido")
		}
	}

	//Metodos de consulta
	method precio() { return 12 }
	method peso() { return peso }
	method sabor() { return sabor }
	method libreGluten() { return true }
	method esBaniada() = false

	//Metodos de indicacion
	method mordisco() { peso = peso - 1 }
}

class CarameloRelleno inherits Caramelo {
	//Metodos de consulta
	override method precio() = super() + 1

	//Metodos de indicacion
	override method mordisco() {
		super()
		self.sabor(chocolate)
	}
}

class Chupetin {
	var peso = 7
	
	//Metodos de consulta
	method precio() { return 2 }
	method peso() { return peso }
	method sabor() { return naranja }
	method libreGluten() { return true }
	method esBaniada() = false

	//Metodos de indicacion
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
}

class Oblea {
	var peso = 250
	
	//Metodos de consulta
	method precio() { return 5 }
	method peso() { return peso }
	method sabor() { return vainilla }
	method libreGluten() { return false }
	method esBaniada() = false

	//Metodos de indicacion
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
}

class ObleaCrujiente inherits Oblea {
	var mordiscosRecibidos = 0

	//Metodos de consulta
	method estaDebil() = mordiscosRecibidos > 3

	//metodos de indicacion
	method darMordisco() {mordiscosRecibidos += 1}

	override method mordisco() {
		super()
		if (not self.estaDebil()) {
			peso = 0.max(peso - 3)
		}
		self.darMordisco()
	}
}

class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0

	method initialize() {
		if(not pesoInicial.between(1,1000)) {
			self.error("Peso inicial debe ser un numero valido")
		}
	}
	
	//Metodos de consulta
	method pesoInicial(unPeso) { pesoInicial = unPeso }
	method precio() { return pesoInicial * 0.50 }
	method peso() { return (pesoInicial - comido).max(0) }
	method sabor() { return chocolate }
	method libreGluten() { return false }
	method esBaniada() = false

	method mordisco() { comido = comido + 2 }
}

class ChocolatinVip inherits Chocolatin {
	const humedad

	method initialize() {
		if(not humedad.between(0,1)) {
			self.error("Humedad debe ser un numero valido, entre 0 y 1")
		}
	}

	//Metodos de consulta
	method humedad() = humedad
	override method peso() = super() * (1 + self.humedad())
}

class ChocolatinPremium inherits ChocolatinVip {
	override method humedad() = super() * 0.5
}

class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	//Metodos de consulta
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method esBaniada() = true
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	

	//Metodos de indicacion
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0

	method initialize() {
		if(not libreDeGluten.kindname() == "a Bolean") {
			self.error("Libre de gluten debe ser un valor booleano")
		}
	}
	
	//Metodos de consulta
	method sabor() { return sabores.get(saborActual % 3) }	
	method esBaniada() = false
	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }

	//Metodos de indicacion
	method mordisco() { saborActual += 1 }
	method libreGluten(valor) { libreDeGluten = valor }
	
}