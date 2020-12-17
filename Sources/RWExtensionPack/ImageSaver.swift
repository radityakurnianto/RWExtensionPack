//
//  ImageSaver.swift
//  RWExtensionPack
//
//  Created by Raditya Kurnianto on 12/17/20.
//

import Foundation
import Photos

class ImageSaver {
    static func checkAuthorization(_ completion: @escaping(Bool)->Void) -> Void {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                completion(true)
                break
            default :
                completion(false)
                break
            }
        }
    }
    
    static func saveImage(image: UIImage, completion: @escaping(Bool, Error?)->Void) -> Void {
        self.getAlbum(name: "CNBC Indonesia") { (album) in
            DispatchQueue.global(qos: .background).async {
                do {
                    try PHPhotoLibrary.shared().performChangesAndWait {
                        let assetRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
                        let assets = assetRequest.placeholderForCreatedAsset
                            .map { [$0] as NSArray }
                        
                        if let assetCollection = assets {
                            let albumChangeRequest = album.flatMap { PHAssetCollectionChangeRequest(for: $0) }
                            albumChangeRequest?.addAssets(assetCollection)
                            completion(true, nil)
                            return
                        }
                        completion(false, nil)
                    }
                } catch let error {
                    completion(false, error)
                }
            }
        }
    }
    
    static func getAlbum(name: String, completion: @escaping (PHAssetCollection?)->Void) -> Void {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", name)
            
            let collection = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions)
            
            guard let album = collection.firstObject else {
                self?.createAlbum(name: name, completion: { (album) in
                    completion(album)
                })
                return
            }
            completion(album)
        }
    }
    
    static func createAlbum(name: String, completion: @escaping (PHAssetCollection?)->Void) -> Void {
        DispatchQueue.global(qos: .background).async {
            var placeholder: PHObjectPlaceholder?
            
            PHPhotoLibrary.shared().performChanges({
                let createAlbumRequest = PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: name)
                placeholder = createAlbumRequest.placeholderForCreatedAssetCollection
            }) { (success, error) in
                if success {
                    let collectionFetchResult = placeholder.map { PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [$0.localIdentifier], options: nil) }
                    completion(collectionFetchResult?.firstObject)
                } else {
                    completion(nil)
                }
            }
        }
    }
}
