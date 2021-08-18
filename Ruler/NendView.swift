import SwiftUI
import UIKit
import NendAd

class ViewController: UIViewController, NADViewDelegate {
    private var nadView: NADView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nadView = NADView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        nadView.setNendID(3172, apiKey: "a6eca9dd074372c898dd1df549301f277c53f2b9")
        nadView.delegate = self
        nadView.load()
        self.view.addSubview(nadView)

        nadView.center = CGPoint(
            x: self.view.bounds.width / 2,
            y: self.view.bounds.height + 50)
    }
    
    func nadViewDidFinishLoad(_ adView: NADView!) {
        UIView.animate(withDuration: 1.0, animations: {
            self.nadView.center = CGPoint(
                x: self.view.bounds.width / 2,
                y: self.view.bounds.height - self.view.safeAreaInsets.bottom - 100)
        })
    }
    
    func nadViewDidFail(toReceiveAd adView: NADView!) {
        UIView.animate(withDuration: 1.0, animations: {
            self.nadView.center = CGPoint(
                x: self.view.bounds.width / 2,
                y: self.view.bounds.height + 50)
        })
    }
}

struct NendView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ViewController {
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ViewController, context: Context) {
    }
}

struct NendView_Previews: PreviewProvider {
    static var previews: some View {
        NendView()
    }
}
