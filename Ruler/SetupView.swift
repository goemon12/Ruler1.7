//
//  SetupView.swift
//  Ruler
//
//  Created by Tadahiro Kato on 2021/08/15.
//

import SwiftUI
import UIKit

struct SetupView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var data: Data
    @State var alertSave = false
    @State var alertCancel = false

    var body: some View {
        ZStack {
            DrawView(data: data)
            VStack {
                HStack {
                    Button(action: {
                        let tmp1 = data.color_back_mm.cgColor?.components
                        let tmp2 = data.color_line_mm.cgColor?.components
                        let tmp3 = data.color_back_in.cgColor?.components
                        let tmp4 = data.color_line_in.cgColor?.components
                        if (tmp1 != nil)
                            && (tmp2 != nil)
                            && (tmp3 != nil)
                            && (tmp4 != nil) {
                            UserDefaults.standard.set(tmp1, forKey: "TMP1")
                            UserDefaults.standard.set(tmp2, forKey: "TMP2")
                            UserDefaults.standard.set(tmp3, forKey: "TMP3")
                            UserDefaults.standard.set(tmp4, forKey: "TMP4")
                        }
                        alertSave = true
                    }) {
                        Text("戻る")
                    }
                    .alert(isPresented: $alertSave) {
                        Alert(title: Text("保存しました"), dismissButton: .default(Text("OK"), action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }))
                    }

                    Spacer()
                    Button(action: {
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
                            data.color_back_mm = Color(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
                            data.color_line_mm = Color(CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
                            data.color_back_in = Color(CGColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0))
                            data.color_line_in = Color(CGColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0))
                        }
                        alertCancel = true
                    }) {
                        Text("設定の取消")
                    }
                    .alert(isPresented: $alertCancel) {
                        Alert(title: Text("取消しました"), dismissButton: .default(Text("OK")))
                    }
                }
                .padding()
                .background(Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .font(.system(size: 20, weight: .regular, design: .monospaced))

                Spacer()
                    .frame(height: 20)
                
                VStack(spacing: 20.0) {
                    Text("色の変更")
                    ColorPicker("背景色 mm", selection: $data.color_back_mm)
                    ColorPicker("寸法線 mm", selection: $data.color_line_mm)
                    ColorPicker("背景色 inch", selection: $data.color_back_in)
                    ColorPicker("寸法線 inch", selection: $data.color_line_in)
                }
                .padding()
                .background(Color(UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                .font(.system(size: 25, weight: .regular, design: .monospaced))

                Spacer()
            }
        }
        
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(data: Data())
    }
}
