import golosinas.*

object mariano {
	const golosinas = []
	 
	method comprar(_golosina) { 
		if (golosinas.contains(_golosina)){
			self.error("La golosina ingresada ya se encuentra en posesion de Mariano")
		}
		golosinas.add(_golosina) 
	}

	method comprarVarias(_listaGolosina) {
		if (_listaGolosina.any({golo =>golosinas.contains(golo)})) {
			self.error("Las golosinas ingresadas no deben estar en posesion de mariano")
		}

		if (_listaGolosina.any({golo => _listaGolosina.occurrencesOf(golo) > 1})) {
			self.error("No debe ingresar mas de una vez una misma golosina")
		}
		golosinas.addAll(_listaGolosina)
	}

	method baniar(_golosina) {
		if (_golosina.esBaniada()) {
			self.error("Debe ser una Golosina no bañada")
		}
		
		const nuevaGolosina = new GolosinaBaniada(golosinaInterior=_golosina)
		self.comprar(nuevaGolosina)
		if (golosinas.contains(_golosina)) {
			self.desechar(_golosina)
		}
	}
	
	method desechar (_golosina) { golosinas.remove(_golosina) }
	
	method golosinas() { return golosinas }
	method primerGolosina() { return golosinas.first() }
	method ultimaGolosina() { return golosinas.last() }
	
	method pesoGolosinas() { 
		return golosinas.sum({ golo => golo.peso() })
	}
	
	method probarGolosinas() {
		golosinas.forEach( {_golosina => _golosina.mordisco() } )
	}
	
	method golosinaMasPesada() { 
		return golosinas.max({ golo => golo.peso() })
	}
	
	method hayGolosinaSinTACC() {
		return golosinas.any({ _golosina => _golosina.libreGluten()}) 
	}
	
	method preciosCuidados() {
		return golosinas.all({ _golosina => _golosina.precio() < 10}) 
	}
	
	method golosinaDeSabor(_sabor) {
		return golosinas.find({ golosina => golosina.sabor() == _sabor })
	}
	
	method golosinasDeSabor(_sabor) {
		return golosinas.filter({ golosina => golosina.sabor() == _sabor })
	}
	
	method sabores() {
		return golosinas.map({ golosina => golosina.sabor() }).asSet()
	}

	method golosinaMasCara() {
		return golosinas.max( { _golosina => _golosina.precio() } )
	}

	method golosinasFaltantes(golosinasDeseadas) {
		return golosinasDeseadas.difference(golosinas)	
	}


	method saboresFaltantes(_saboresDeseados) {
		return _saboresDeseados.filter({_saborDeseado => ! self.tieneGolosinaDeSabor(_saborDeseado)})	
	}
	
	method tieneGolosinaDeSabor(_sabor) {
		return golosinas.any({_golosina => _golosina.sabor() == _sabor})
	}
}