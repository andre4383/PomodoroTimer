import SwiftUI

struct ContentView: View {
    @State private var modelo = PomodoroModel()

    var body: some View {
        ZStack {
            Color(red: 0.98, green: 0.95, blue: 0.88)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Pomodoro")
                        .font(.system(size: 56, weight: .regular, design: .serif))
                        .foregroundStyle(.black)

                    Text(dataDeHoje())
                        .font(.system(size: 16, weight: .regular, design: .rounded))
                        .foregroundStyle(.black.opacity(0.5))
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack(spacing: 24) {
                    Text("Foco")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundStyle(.black.opacity(0.6))

                    Text(formatarTempo(modelo.segundosRestantes))
                        .font(.system(size: 72, weight: .semibold, design: .monospaced))
                        .foregroundStyle(.black)

                    Button {
                        if modelo.rodando { modelo.pausar() } else { modelo.iniciar() }
                    } label: {
                        Image(systemName: modelo.rodando ? "pause.fill" : "play.fill")
                            .font(.system(size: 22))
                            .foregroundStyle(.white)
                            .frame(width: 64, height: 64)
                            .background(.black)
                            .clipShape(Circle())
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 48)
                .background(modelo.rodando
                            ? Color(red:0.95, green: 0.74, blue: 0.42)
                            : Color(red:0.68, green: 0.82, blue: 0.93))
                .clipShape(RoundedRectangle(cornerRadius: 32, style: .continuous))
                .animation(.easeInOut(duration: 0.4), value:modelo.rodando)

                Spacer()
            }
            .padding(.horizontal, 28)
            .padding(.top, 80)
        }
    }

    func formatarTempo(_ segundos: Int) -> String {
        let min = segundos / 60
        let seg = segundos % 60
        return String(format: "%02d:%02d", min, seg)
    }

    func dataDeHoje() -> String {
        let f = DateFormatter()
        f.locale = Locale(identifier: "pt_BR")
        f.dateFormat = "EEEE, d 'de' MMMM"
        let texto = f.string(from: Date())
        return texto.prefix(1).uppercased() + texto.dropFirst()
    }
}

#Preview {
    ContentView()
}
