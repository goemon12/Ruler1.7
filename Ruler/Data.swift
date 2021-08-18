import Foundation
import SwiftUI

class Data: ObservableObject {
    @Published var siz: CGFloat
    @Published var ctr: CGFloat
    @Published var pmm: CGFloat
    @Published var pin: CGFloat
    
    @Published var color_back_mm: Color
    @Published var color_line_mm: Color
    @Published var color_back_in: Color
    @Published var color_line_in: Color

    init() {
        var siz: CGFloat = 0
        switch UIScreen.main.nativeBounds.height {
        case 2778:
            //2020 12pro max
            siz = 6.7
            
        case 2532:
            //2020 12pro, 12
            siz = 6.1
            
        case 2340:
            //2020 12mini
            siz = 5.4

        case 2688:
            //2019 11pro max
            //2018 xs max
            siz = 6.5

        case 1792:
            //2019 11
            //2018 xr
            siz = 6.1

        case 2436:
            //2019 11pro
            //2018 xs
            //2017 x new
            siz = 5.8

        case 1920:
            //2017 8+
            //2016 7+
            siz = 5.5
            
        case 1334:
            //2020 se2
            //2017 8
            //2016 7
            siz = 4.7
            
        case 1136://SE1
            siz = 4.0
            
        default:
            siz = 3.5
        }
        
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        self.siz = siz
        self.pmm = sqrt(w * w + h * h) / (siz * 25.4)
        self.pin = sqrt(w * w + h * h) / (siz * 10.0)
        self.ctr = h / 2
        
        self.color_back_mm = Color(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
        self.color_line_mm = Color(CGColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        self.color_back_in = Color(CGColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0))
        self.color_line_in = Color(CGColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0))
    }
    
    func top() -> Int {
        return Int((0 - self.ctr) / pmm)
    }
    
    func btm() -> Int {
        return Int((UIScreen.main.bounds.height - self.ctr) / pmm)
    }
    
    func top_in() -> Int {
        return Int((0 - self.ctr) / pin)
    }
    
    func btm_in() -> Int {
        return Int((UIScreen.main.bounds.height - self.ctr) / pin)
    }
}
