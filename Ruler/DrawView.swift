import SwiftUI

struct DrawView: View {
    @ObservedObject var data: Data
    
    var w = UIScreen.main.bounds.width
    var h = UIScreen.main.bounds.height
    
    var body: some View {
        ZStack {
            Path {path in
                path.addRect(CGRect(x: 0, y: 0, width: w / 2, height: h))
            }
            .fill(data.color_back_mm)
            
            Path {path in
                path.addRect(CGRect(x: w / 2, y: 0, width: w / 2, height: h))
            }
            .fill(data.color_back_in)
            
            ForEach(data.top() ..< data.btm(), id: \.self) {index in
                let ly = data.ctr + CGFloat(index) * data.pmm
                if (index % 10 == 0) {
                    Path {path in
                        path.move(to: CGPoint(x: 0, y: ly))
                        path.addLine(to: CGPoint(x: w / 4, y: ly))
                    }
                    .stroke(data.color_line_mm, lineWidth: 1.4)
                    
                    Text(String(format: "%3d mm", index))
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundColor(data.color_line_mm)
                        .position(x: w / 4 + w / 8, y: ly)
                }
                else if (index % 5 == 0) {
                    Path {path in
                        path.move(to: CGPoint(x: 0, y: ly))
                        path.addLine(to: CGPoint(x: w / 5, y: ly))
                    }
                    .stroke(data.color_line_mm, lineWidth: 1.2)
                }
                else {
                    Path {path in
                        path.move(to: CGPoint(x: 0, y: ly))
                        path.addLine(to: CGPoint(x: w / 6, y: ly))
                    }
                    .stroke(data.color_line_mm, lineWidth: 1.0)
                }
            }

            ForEach(data.top_in() ..< data.btm_in(), id: \.self) {index in
                let ly = data.ctr + CGFloat(index) * data.pin
                if (index % 10 == 0) {
                    Path {path in
                        path.move(to: CGPoint(x: w, y: ly))
                        path.addLine(to: CGPoint(x: w / 4 * 3, y: ly))
                    }
                    .stroke(data.color_line_in, lineWidth: 1.4)
                    
                    Text(String(format: "%2d inch", index / 10))
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundColor(data.color_line_in)
                        .position(x: w / 4 * 3 - w / 8, y: ly)
                }
                else if (index % 5 == 0) {
                    Path {path in
                        path.move(to: CGPoint(x: w, y: ly))
                        path.addLine(to: CGPoint(x: w / 5 * 4, y: ly))
                    }
                    .stroke(data.color_line_in, lineWidth: 1.2)
                }
                else {
                    Path {path in
                        path.move(to: CGPoint(x: w, y: ly))
                        path.addLine(to: CGPoint(x: w / 6 * 5, y: ly))
                    }
                    .stroke(data.color_line_in, lineWidth: 1.0)
                }
            }

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView(data: Data())
    }
}
