//
//  PomodoroModel.swift
//  PomodoroTimer
//
//  Created by andre on 16/06/26.
//

import Foundation

@Observable
final class PomodoroModel {
    var segundosRestantes: Int = 25 * 60
    var rodando: Bool = false
    private var timer: Timer?
    
    func iniciar(){
        guard !rodando else { return }
        rodando = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
        guard let self else { return }
            
            if self.segundosRestantes > 0 {
                self.segundosRestantes -= 1
            } else {
                self.pausar()
            }
        }
    }
    func pausar(){
        rodando = false
        timer?.invalidate()
        timer = nil
    }
}
