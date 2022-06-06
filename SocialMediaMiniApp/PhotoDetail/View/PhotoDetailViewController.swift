//
//  PhotoDetailViewController.swift
//  SocialMediaMiniApp
//
//  Created by Administrator on 05/06/22.
//

import UIKit

protocol PhotoDetailViewControllerInput: AnyObject {
    func setPhotoDetail(withData data: Photo)
}

class PhotoDetailViewController: UIViewController {
    
    // MARK: - Properties
    private var startingFrameZoomView: CGRect?
    private var backgroundZoomView: UIView?
    private var photoDetailZoom: UIImageView?
    
    // MARK: - Components
    lazy var titlePhotoLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupLayout()
    }
}

// MARK: - Setup
private extension PhotoDetailViewController {
    func setupViews() {

        title = Wording.titlePhotoDetailPage
        view.backgroundColor = Color.grayCustomBackground
        
        view.addSubview(titlePhotoLabel)
        view.addSubview(separatorView)
        view.addSubview(photoImageView)
        
        photoImageView.layer.cornerRadius = 10
        photoImageView.layer.borderWidth = 2
        photoImageView.layer.borderColor = UIColor.white.cgColor
        photoImageView.layer.masksToBounds = true
        
    }
    
    func setupLayout() {
        
        NSLayoutConstraint.activate([
            titlePhotoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin.maximumMargin),
            titlePhotoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.mainMargin),
            titlePhotoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin.mainMargin)
        ])
        
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: titlePhotoLabel.bottomAnchor, constant: Margin.minimumMargin),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: Margin.maximumMargin),
            photoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Margin.maximumMargin),
            photoImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - Margin.maximumMargin)
        ])
    }
    
    func setupPhotoDetail(dataPhoto: Photo) {
        titlePhotoLabel.text = dataPhoto.title
        ImageDownloader.shared.setupImage(urlImage: dataPhoto.url, imageView: photoImageView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionTapGestureImage(_:)))
        photoImageView.isUserInteractionEnabled = true
        photoImageView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - Setup Photo Detail For Zoom In & Zoom Out
extension PhotoDetailViewController {
    @objc
    func actionTapGestureImage(_ sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else {
            return
        }
        setupOpenDetailImagecard(imageView: imageView)
    }
    
    func setupOpenDetailImagecard(imageView: UIImageView) {
        guard let imageViewFrame = imageView.superview?.convert(imageView.frame, to: nil) else {
            return
        }
        
        self.startingFrameZoomView = imageViewFrame
        
        let zoomImageCard = setupImageCardForZoom(frame: imageViewFrame)
        zoomImageCard.image = imageView.image
        self.photoDetailZoom = zoomImageCard
        
        let newWindow = setupGetKeyWindow()
     
        if let window = newWindow {
            
            let scroolViewackground = setupScrollViewBackground(window: window)
            self.backgroundZoomView = scroolViewackground
            
            window.addSubview(scroolViewackground)
            scroolViewackground.addSubview(zoomImageCard)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                let height = imageViewFrame.height / imageViewFrame.width * window.frame.width
                
                zoomImageCard.frame = CGRect(x: 0, y: 0, width: window.frame.width - 16, height: height)
                zoomImageCard.center = window.center
                
            }, completion: nil)
        }
    }
    
    func setupGetKeyWindow() -> UIWindow? {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        return keyWindow
    }
    
    func setupTransparantBackground(window: UIWindow) -> UIView {
        let transparantBackground = UIView(frame: window.frame)
        transparantBackground.backgroundColor = .black
        transparantBackground.alpha = 1
        
        return transparantBackground
    }
    
    func setupScrollViewBackground(window: UIWindow) -> UIScrollView {
        let scrollViewBackground = UIScrollView(frame: window.frame)
        scrollViewBackground.backgroundColor = .black
        scrollViewBackground.alpha = 1
        scrollViewBackground.minimumZoomScale = 1
        scrollViewBackground.maximumZoomScale = 4
        scrollViewBackground.delegate = self
        
        return scrollViewBackground
    }
    
    func setupImageCardForZoom(frame: CGRect) -> UIImageView {
        let zoomImageCard = UIImageView(frame: frame)
        zoomImageCard.backgroundColor = UIColor.red
        zoomImageCard.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(actionClosePhotoDetail(_:)))
        zoomImageCard.addGestureRecognizer(tapGesture)
        
        return zoomImageCard
    }
    
    @objc
    func actionClosePhotoDetail(_ sender: UITapGestureRecognizer) {
        guard let zoomOutImageCard = sender.view,
              let startingFrame = self.startingFrameZoomView,
              let transparantBackground = self.backgroundZoomView
        else {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut) {
            
            zoomOutImageCard.frame = startingFrame
            transparantBackground.alpha = 0
            
        } completion: { _ in
            zoomOutImageCard.removeFromSuperview()
            transparantBackground.removeFromSuperview()
        }
    }
}

// MARK: - UIScrollViewDelegate For Zoom In & Zoom Out
extension PhotoDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoDetailZoom
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > scrollView.maximumZoomScale {
            scrollView.zoomScale = scrollView.maximumZoomScale
        } else if scrollView.zoomScale < scrollView.minimumZoomScale {
            scrollView.zoomScale = scrollView.minimumZoomScale
        }
    }
}

// MARK: - PhotoDetailViewControllerInput
extension PhotoDetailViewController: PhotoDetailViewControllerInput {
    func setPhotoDetail(withData data: Photo) {
        setupPhotoDetail(dataPhoto: data)
    }
}
