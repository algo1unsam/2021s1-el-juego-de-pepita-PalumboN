import extras.*
import wollok.game.*

object pepita {

	var property energia = 100
	var property position = game.at(0,0.min(5))

	//method position() = game.at(self.coordenadaX(), self.coordenadaY())

	method coordenadaX() {
		return 0.max(2)
	}

	method coordenadaY() {
		return 0.max(2)
	}

	method image() {
		return if (self.estaEnElNido()) "pepita-grande.png" 
				else if (self.atrapadaPorSilvestre()) "pepita-gris.png" 
				else if (self.estaCansada()) "pepita-gris.png" else "pepita.png"
	}

	method come(comida) {
		energia = energia + comida.energiaQueOtorga()
		game.removeVisual(comida)
	}

	method comeSiPuede() {
	}

	method agarrar() {
		game.colliders(self).forEach({ elem => elem.fueAgarrado()})
		
		}
	method vola(kms) {
		energia = energia - kms * 9
	}

	method irA(nuevaPosicion) {
		if(self.limites(nuevaPosicion)) {
		self.vola(position.distance(nuevaPosicion))
		position = nuevaPosicion
			
		}
	}

	method estaCansada() {
		return energia <= 0
	}

	method estaEnElNido() {
		return position == nido.position()
	}

	method caerSiEstasVolando() {
		if (not self.estaEnElSuelo()) {
			position = position.down(1)
		}
	}

	method estaEnElSuelo() {
		return position.y() == 0
	}

	method atrapadaPorSilvestre() {
		return position == silvestre.position()
	}
	
	method limites(nuevaPosicion) = (nuevaPosicion.x() <= 9) and (nuevaPosicion.y() <=9)

}

