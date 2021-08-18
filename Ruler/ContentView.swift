//
//  ContentView.swift
//  Ruler
//
//  Created by goemon12 on 2021/08/13.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = Data()
    var w = UIScreen.main.bounds.width
    var h = UIScreen.main.bounds.height
    @State var y1: CGFloat = 0
    @State var y2: CGFloat = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                DrawView(data: data)

                NendView()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("定規(Ruler) V1.7")
                        Spacer()
                        NavigationLink(destination: SetupView(data: data)) {
                            Text("設定")
                        }
                    }
                    .padding()
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .background(Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)))
                    
                    Spacer()
                    
                    HStack {
                        Text("2021 Goemon Software")
                    }
                    .padding()
                    .font(.system(size: 20, weight: .regular, design: .monospaced))
                    .background(Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.7)))
                }
                
            }
            .gesture(
                DragGesture()
                    .onChanged {val in
                        y2 = y1
                        y1 = val.location.y
                        if (y2 > 0) {
                            let dy = y1 - y2
                            if (0 < data.ctr + dy) && (data.ctr + dy < h) {
                                data.ctr += dy
                            }
                        }
                    }
                    .onEnded {val in
                        y1 = 0
                        y2 = 0
                    }
            )
            
            .navigationBarHidden(true)
        }
        .onAppear {
            let tmp1 = UserDefaults.standard.array(forKey: "TMP1") as? [CGFloat]
            let tmp2 = UserDefaults.standard.array(forKey: "TMP2") as? [CGFloat]
            let tmp3 = UserDefaults.standard.array(forKey: "TMP3") as? [CGFloat]
            let tmp4 = UserDefaults.standard.array(forKey: "TMP4") as? [CGFloat]
            if (tmp1 != nil)
                && (tmp2 != nil)
                && (tmp3 != nil)
                && (tmp4 != nil) {
                data.color_back_mm = Color(CGColor(red: tmp1![0], green: tmp1![1], blue: tmp1![2], alpha: 1))
                data.color_line_mm = Color(CGColor(red: tmp2![0], green: tmp2![1], blue: tmp2![2], alpha: 1))
                data.color_back_in = Color(CGColor(red: tmp3![0], green: tmp3![1], blue: tmp3![2], alpha: 1))
                data.color_line_in = Color(CGColor(red: tmp4![0], green: tmp4![1], blue: tmp4![2], alpha: 1))
            }
            else {
                print("load error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
