object casa {
    var suciedad = 0
    var cuidador = tom
    var quilombero = noQuilombero

    method suciedad() = suciedad
    method cuidador() = cuidador
    method quilombero() = quilombero

    method asignarCuidador(nuevoCuidador) { cuidador = nuevoCuidador }
    method recibirInvasion(nuevoQuilombero) { quilombero = nuevoQuilombero }

    method ensuciar(cantidad) { suciedad += cantidad }
    
    method recibirLimpieza(cantidad) { suciedad = 0.max(suciedad - cantidad) }
    
    method limpiarPorCompleto() { suciedad = 0 }

    method pasarElDia() {
        cuidador.limpiar(self)
        if (cuidador.puedeAtrapar(quilombero)) {
            quilombero = noQuilombero
        }
    }

    method pasarLaNoche() {
        cuidador.dormir()
            quilombero.hacerQuilombo(self)
    }
}

object tom {
    var energia = 100

    method energia() = energia
    method energia(nuevaEnergia) { energia = nuevaEnergia } 

    method limpiar(casa) {
        casa.recibirLimpieza(100) 
        energia = 0.max(energia - 40)
    }

    method velocidad() = 5 + (energia / 10)

    method puedeAtrapar(unQuilombero) = self.velocidad() > unQuilombero.velocidad()

    method dormir() { energia += 50 }

    method interrumpirSueno() { energia = 0.max(energia - 20) }
}

object robocat {
    method limpiar(casa) {
        casa.limpiarPorCompleto() 
    }

    method puedeAtrapar(unQuilombero) = true

    method dormir() { } 
    method interrumpirSueno() { } 
}

object mammy {
    var paciencia = 100
    
    method paciencia() = paciencia
    method paciencia(nuevaPaciencia) { paciencia = nuevaPaciencia } 

    method limpiar(casa) {
        casa.recibirLimpieza(200)
        paciencia -= 15
    }

    method puedeAtrapar(unQuilombero) = paciencia > 50

    method dormir() { paciencia = 100 }

    method interrumpirSueno() { paciencia -= 40 }
}

object jerry {
    var peso = 3

    method peso() = peso
    method peso(nuevoPeso) { peso = nuevoPeso } // Para tests

    method hacerQuilombo(casa) {
        casa.ensuciar(110)
        peso += 1
    }

    method velocidad() = 10 - peso
}

object tuffy {
    method velocidad() = 10

    method hacerQuilombo(casa) {
        casa.cuidador().interrumpirSueno()
    }
}

object pandilla {
    const miembros = []

    method agregarMiembro(miembro) { miembros.add(miembro) }
    
    method vaciar() { miembros.clear() }

    method hacerQuilombo(casa) {
        miembros.forEach({ miembro => miembro.hacerQuilombo(casa) })
        if (miembros.size() > 3) {
            casa.cuidador().interrumpirSueno()
        }
    }

    method velocidad() {
        if (miembros.isEmpty()) return 0
        return miembros.min({ miembro => miembro.velocidad() }).velocidad() / 2
    }
}

object patoQuacker {
    var panico = 0

    method panico() = panico
    method panico(nuevoPanico) { panico = nuevoPanico } // Para tests

    method hacerQuilombo(casa) {
        casa.ensuciar(50)
        panico += 10
    }

    method velocidad() = 8 + (panico / 5)
}

object noQuilombero {
  method hacerQuilombo(casa) { 
    }
    
    method velocidad() = 0
}