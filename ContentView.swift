import SwiftUI
import Combine // 导入 Combine 框架

struct ContentView: View {
    @State private var apkLink = ""
    @State private var isConverting = false
    @State private var isConverted = false
    @State private var progress: Double = 0

    var body: some View {
        if isConverted {
            SecondScreen()
        } else {
            VStack(spacing: 20) {
                Text("apk 转 ipa")
                   .font(.largeTitle)
                   .fontWeight(.bold)

                TextField("填入 apk 链接", text: $apkLink)
                   .textFieldStyle(RoundedBorderTextFieldStyle())
                   .padding()

                Button("转换") {
                    startConversion()
                }
               .padding()
               .background(Color.blue)
               .foregroundColor(.white)
               .cornerRadius(8)

                if isConverting {
                    VStack {
                        Text("转换中")
                        ProgressView(value: progress)
                           .progressViewStyle(LinearProgressViewStyle())
                           .frame(maxWidth: .infinity)
                           .padding()
                    }
                }
            }
           .padding()
        }
    }

    private func startConversion() {
        isConverting = true
        var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
        var elapsedTime = 0.0

        let totalTime = 10.0

        let cancellable = timer.sink { _ in
            DispatchQueue.main.async {
                elapsedTime += 0.1
                progress = elapsedTime / totalTime

                if elapsedTime >= totalTime {
                    timer.upstream.connect().cancel()
                    isConverting = false
                    isConverted = true
                }
            }
        }
        _ = cancellable // 避免警告
    }
}
struct SecondScreen: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("SB")
               .resizable()
               .aspectRatio(contentMode: .fit)
               .frame(width: 200, height: 200)
               .padding()

            Text("🤣大傻逼就是你🫵")
               .font(.title)
               .foregroundColor(.red)
        }
       .padding()
    }
}

#Preview {
    ContentView()
}
