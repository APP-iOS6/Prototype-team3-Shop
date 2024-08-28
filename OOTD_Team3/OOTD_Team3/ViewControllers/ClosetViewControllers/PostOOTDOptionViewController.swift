//
//  PostOOTDViewController.swift
//  OOTD_Team3
//
//  Created by Hyeonjeong Sim on 8/28/24.
//

import UIKit

class PostOOTDOptionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 사진 옵션 버튼
        let photoButton = UIButton(type: .system)
        photoButton.setTitle("📷 사진 올리기", for: .normal)
        photoButton.tintColor = .black
        photoButton.addTarget(self, action: #selector(photoOptionSelected), for: .touchUpInside)
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 동영상 옵션 버튼
        let videoButton = UIButton(type: .system)
        videoButton.setTitle("🎞️ 동영상 올리기", for: .normal)
        videoButton.tintColor = .black
        videoButton.addTarget(self, action: #selector(videoOptionSelected), for: .touchUpInside)
        videoButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(photoButton)
        view.addSubview(videoButton)
        
        NSLayoutConstraint.activate([
            photoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            photoButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            videoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoButton.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 10)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 모달 시트 크기 설정
        if let sheet = self.sheetPresentationController {
            // 화면 높이의 1/4로 설정하는 custom detent 추가
            sheet.detents = [.custom { context in
                return context.maximumDetentValue * 0.1  // 화면 높이의 1/4로 설정
            }]
            sheet.prefersGrabberVisible = true // 상단 손잡이 표시
        }
    }
    
    @objc private func photoOptionSelected() {
        openImagePicker(for: .photoLibrary, mediaTypes: ["public.image"])
    }
    
    @objc private func videoOptionSelected() {
        openImagePicker(for: .photoLibrary, mediaTypes: ["public.movie"])
    }
    
    private func openImagePicker(for sourceType: UIImagePickerController.SourceType, mediaTypes: [String]) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.mediaTypes = mediaTypes
        picker.delegate = self
        picker.allowsEditing = false
        
        present(picker, animated: true, completion: nil)
    }
    
    // UIImagePickerControllerDelegate 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 선택된 미디어 처리
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 취소 시 처리
        picker.dismiss(animated: true, completion: nil)
    }
}

#Preview {
    PostOOTDOptionViewController()
}

