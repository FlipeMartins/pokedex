//
//  PKMDSImage.swift
//  Pokedex
//
//  Created by Felipe Martins on 30/05/25.
//

import UIKit
import Kingfisher

public enum PKMDSImage: Equatable {
    case asset(name: String)
    case image(image: UIImage)
    case remote(remote: Remote)

    public struct Remote: Equatable {
        public enum Placeholder: Equatable {
            case asset(name: String?)
            case image(image: UIImage)
        }

        public let url: String
        public let placeholder: Placeholder?

        public init(url: String, placeholder: Placeholder? = nil){
            self.url = url
            self.placeholder = placeholder
        }
    }

    public static func == (lhs: PKMDSImage, rhs: PKMDSImage) -> Bool {
        switch (lhs, rhs) {
        case (.asset(let leftImage), .asset(let rightImage)):
            return leftImage == rightImage
        case (.image(let leftImage), .image(let rightImage)):
            return leftImage == rightImage
        case (.remote(let leftRemote), .remote(let rightRemote)):
            return leftRemote == rightRemote
        default:
            return false
        }
    }
}

extension UIImageView {
    
    
    private func assetImage(named: String?) -> UIImage? {
        return nil
    }
    
    private func assetImage(named: String) -> UIImage? {
        if let image = UIImage(named: named, in: Bundle.main, compatibleWith: nil) {
            return image
        }

        return nil
    }
    
    public func setPKMDSImage(_ imageType: PKMDSImage?) {
        guard let imageType = imageType else {
            self.image = nil
            return
        }

        switch imageType {
        case .asset(let name):
            self.image = assetImage(named: name)
        case .image(let image):
            self.image = image
        case .remote(let remoteImage):
            var placeholder: UIImage?

            switch remoteImage.placeholder {
            case .image(let image):
                placeholder = image
            case .asset(let name):
                placeholder = assetImage(named: name)
            case .none:
                placeholder = nil
            }
            
            let resource = URL(string: remoteImage.url)
            self.kf.setImage(with: resource, placeholder: placeholder, options: nil) { result in
                if case let .failure(error) = result {
                    print("[UIImageView] Kingfisher image loading error: placeholder(\(String(describing: remoteImage.placeholder))), url(\(remoteImage.url)) - \(error.localizedDescription)")
                }
            }
        }
    }
    
    public func cancelImageDownload() {
        self.kf.cancelDownloadTask()
        self.image = nil
    }
}
