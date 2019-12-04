//
//  TestView.swift
//  bluetooth_connect_plugin
//
//  Created by Ning Li on 2019/12/3.
//

import UIKit

class TestView: NSObject, FlutterPlatformView {
    
    private var content: ContentView!
    private var viewId: Int64 = 0
    private var event: FlutterEventSink?
    
    private var channel: FlutterBasicMessageChannel?
    
    init(frame: CGRect, viewId: Int64, arguments: Any?, messenger: FlutterBinaryMessenger) {
        super.init()
        var newFrame = frame
        if frame.width == 0 {
            newFrame = CGRect(origin: frame.origin, size: UIScreen.main.bounds.size)
        }
        content = ContentView(frame: newFrame, image: nil)
        content.backgroundColor = UIColor.white
        self.viewId = viewId
        
        if let args = arguments as? [String: Any],
            let imageBase64 = args["image"] as? String,
            let imageData = Data(base64Encoded: imageBase64),
            let image = UIImage(data: imageData) {
            content.set(image: image)
        }
        
        // 注册通信通道
        channel = FlutterBasicMessageChannel(name: "com.test/get_image", binaryMessenger: messenger)

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapClick))
        content.addGestureRecognizer(tap)
    }
    
    @objc private func tapClick() {
        let imageData = UIImageJPEGRepresentation(content.imageView.image!, 0.8)
        let imageBase64 = imageData?.base64EncodedString() ?? ""
        channel?.sendMessage(imageBase64)
    }
    
    func view() -> UIView {
        return content
    }
}

/// ContentView
fileprivate class ContentView: UIView {
    
    lazy var imageView = UIImageView()
    
    convenience init(frame: CGRect, image: UIImage?) {
        self.init(frame: frame)
        imageView.image = image
        setupUI()
    }
    
    func set(image: UIImage) {
        imageView.image = image
    }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        clipsToBounds = true
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: bounds.width, height: bounds.height))
    }
}
