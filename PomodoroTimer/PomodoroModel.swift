//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by andre on 16/06/26.
//

import Foundation

enum TipoSessao {
    case foco
    case pausa

    var titulo: String {
        switch self {
        case .foco: return "Foco"
        case .pausa: return "Pausa"
        }
    }
}

@Observable
final class PomodoroModel {
    var duracaoFocoMin: Int = 25
    var duracaoPausaMin: Int = 5
    var segundosRestantes: Int = 25 * 60
    var rodando: Bool = false
    var tipoSessao: TipoSessao = .foco
    var ciclosCompletos: Int = 0
    private var timer: Timer?

    func iniciar() {
        guard !rodando else { return }
        rodando = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            if self.segundosRestantes > 0 {
                self.segundosRestantes -= 1
            } else {
                self.finalizarSessao()
            }
        }
    }

    func pausar() {
        rodando = false
        timer?.invalidate()
        timer = nil
    }

    func resetar() {
        pausar()
        segundosRestantes = duracaoEmSegundos(para: tipoSessao)
    }

    func trocarTipo(_ novo: TipoSessao) {
        pausar()
        tipoSessao = novo
        segundosRestantes = duracaoEmSegundos(para: novo)
    }

    private func finalizarSessao() {
        pausar()
        if tipoSessao == .foco {
            ciclosCompletos += 1
            trocarTipo(.pausa)
        } else {
            trocarTipo(.foco)
        }
    }

    private func duracaoEmSegundos(para tipo: TipoSessao) -> Int {
        switch tipo {
        case .foco: return duracaoFocoMin * 60
        case .pausa: return duracaoPausaMin * 60
        }
    }
}
