import SwiftUI

struct EditorTempoView: View {
    @Bindable var modelo: PomodoroModel
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack(spacing: 28) {
            HStack {
                Text("Tempo")
                    .font(.system(size: 24, weight: .semibold, design: .serif))
                    .foregroundStyle(.black)
                Spacer()
                Button("Pronto") { dismiss() }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundStyle(.black)
            }

            Stepper(value: $modelo.duracaoFocoMin, in: 1...90, step: 5) {
                HStack {
                    Text("Foco")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                    Spacer()
                    Text("\(modelo.duracaoFocoMin) min")
                        .font(.system(size: 17, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.black.opacity(0.7))
                }
            }

            Stepper(value: $modelo.duracaoPausaMin, in: 1...30, step: 1) {
                HStack {
                    Text("Pausa")
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                    Spacer()
                    Text("\(modelo.duracaoPausaMin) min")
                        .font(.system(size: 17, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.black.opacity(0.7))
                }
            }

            Spacer()
        }
        .padding(28)
        .presentationDetents([.height(300)])
        .presentationDragIndicator(.visible)
        .onChange(of: modelo.duracaoFocoMin) { _, _ in
            if modelo.tipoSessao == .foco && !modelo.rodando {
                modelo.segundosRestantes = modelo.duracaoFocoMin * 60
            }
        }
        .onChange(of: modelo.duracaoPausaMin) { _, _ in
            if modelo.tipoSessao == .pausa && !modelo.rodando {
                modelo.segundosRestantes = modelo.duracaoPausaMin * 60
            }
        }
    }
}
