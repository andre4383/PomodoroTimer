import SwiftUI

struct ContentView: View {
    @State private var modelo = PomodoroModel()

    var body: some View {
        VStack() {
            Text("Pomodoro")
                .font(.system(size: 50))
                .bold()

            Text(formatarTempo(modelo.segundosRestantes))
                .font(.system(size: 100, weight: .semibold, design: .monospaced))

            Button {
                if modelo.rodando {
                    modelo.pausar()
                } else {
                    modelo.iniciar()
                }
            } label: {
                Image(systemName: modelo.rodando ? "pause.fill" : "play.fill")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.black)
                    .clipShape(Circle())
            }
        }
        .padding()
    }

    func formatarTempo(_ segundos: Int) -> String {
        let min = segundos / 60
        let seg = segundos % 60
        return String(format: "%02d:%02d", min, seg)
    }
}

#Preview {
    ContentView()
}
