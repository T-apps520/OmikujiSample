//
//  ContentView.swift
//  OmikujiSample
//
//  Created by Tomoya Watanabe on 2024/08/26.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    let omikuji = Omikuji() // Omikujiクラスを生成
    @State var isRunning = false //@stateを付けると値が変化した時にSwiftUIの表示が更新されるようになる
    @State var angle = 0.0
    @State var opacity = 1.0
    
    var body: some View {
        VStack { // 縦方向に並べる
            // タイトルテキストの追加
            Text("おみくじ").padding().font(.largeTitle)
            ZStack { // 奥行き方向に並べる
                Image("omikuji_box") // 画像追加
                    .resizable() // 画像サイズを変更できる設定
                    .aspectRatio(contentMode: .fit) // 縦横比は変えない設定
                    .frame(height: 200) // 画像の縦サイズを設定
                    .rotationEffect(.degrees(angle))
                    .opacity(opacity) // 画像の透過率を設定
                Image(omikuji.result()) // おみくじの結果画像を表示
                    .resizable() // 画像サイズを変更できる設定
                    .aspectRatio(contentMode: .fit) // 縦横比は変えない設定
                    .frame(height: 200) // 画像の縦サイズを設定
                    .background(omikuji.resultColor()) // 背景色を設定
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/) // 画像を丸く切り抜き
                    .opacity(1.0 - opacity) // 画像の透過率を設定
            }
            HStack { // 水平に並べる
                Button("おみくじを引く"){ // ボタンの追加
                isRunning = true
                    omikuji.select() // おみくじを引く処理を実行
                    withAnimation{ // 画像の回転アニメーション
                        angle = 180
                    } completion: { //　回転アニメーションが終了
                        withAnimation{ //　画像の透過アニメーション
                            opacity = 0
                        }
                    }
                }.disabled(isRunning) // ボタンの状態を設定
                Button("もう一回"){ // ボタンの追加
                    isRunning = false
                    angle = 0 // 画像の回転と透過率をリセット
                    opacity = 1.0
                }.disabled(!isRunning)// ボタンの状態を設定
            }.padding()
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
