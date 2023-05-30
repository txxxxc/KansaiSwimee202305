//
//  ViewController.swift
//  MayKansaiSwimee
//
//  Created by Tomoya Tanaka on 2023/05/17.
//

import UIKit
import AVFoundation

let ratio = 33
class ViewController: UIViewController {


    var count: Int = 0
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    var audioPlayers = [AVAudioPlayer?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        button.setTitle("🏳️‍🌈", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 48)

    }

    @IBAction func plus() {
        let audioPlayer: AVAudioPlayer? = try! AVAudioPlayer(data: NSDataAsset(name: "po")!.data)
        audioPlayers.append(audioPlayer)
        audioPlayer?.play()
        count += 1
        label.text = String(count)
        updateUI()
        generateLabel()
    }

    func createGradientLayer(frame: CGRect, colors: [CGColor]) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 2, y: 0)
        view.layer.insertSublayer(gradientLayer, at: 0)

        return gradientLayer
    }

    func updateUI() {
        let color = UIColor.createYumekawaColor(CGFloat(count % ratio))
        view.backgroundColor = color
    }

    func generateLabel() {
        let randomX = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width - 50)))
        let movingView = UILabel(frame: CGRect(x: randomX, y: self.view.frame.size.height, width: 50, height: 50))
        movingView.font = UIFont.systemFont(ofSize: 32)
        movingView.text = randomText()
        view.addSubview(movingView)

        // 揺れるパスを作成する
        let path = UIBezierPath()
        path.move(to: movingView.center)

        // ランダムな制御点を生成
        let randomControlPoint1X = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))
        let randomControlPoint2X = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))

        // ランダムな終点のX座標を生成
        let randomEndX = CGFloat(arc4random_uniform(UInt32(self.view.frame.size.width)))

        path.addCurve(to: CGPoint(x: randomEndX, y: 0),
                      controlPoint1: CGPoint(x: randomControlPoint1X, y: self.view.frame.size.height * 0.5),
                      controlPoint2: CGPoint(x: randomControlPoint2X, y: self.view.frame.size.height * 0.25))

        // パスに沿って移動するアニメーションを作成する
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 2.0

        // 透明度を0にするアニメーションを作成する
        let fadeAnimation = CABasicAnimation(keyPath: "opacity")
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.duration = 2.0

        // 2つのアニメーションをグループ化する
        let group = CAAnimationGroup()
        group.animations = [animation, fadeAnimation]
        group.duration = 2.0
        group.fillMode = .forwards
        group.isRemovedOnCompletion = false

        // アニメーションをビューに追加する
        movingView.layer.add(group, forKey: nil)

    }

}

