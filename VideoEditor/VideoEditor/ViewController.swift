//
//  ViewController.swift
//  VideoEditor
//
//  Created by Khoa Pham on 22/08/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIVideoEditorControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  // MARK: - Image Picker

  @IBAction func imagePickerTouched(sender: UIButton) {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .SavedPhotosAlbum
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    imagePicker.mediaTypes = [String(kUTTypeMovie)]

    presentViewController(imagePicker, animated: true, completion: nil)
  }

  // MARK: UIImagePickerControllerDelegate

  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    print(info)
  }

  func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
    print(image)
    print(editingInfo)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {

  }

  // MARK: - Video Editor

  func showVideoEditor() {
    let videoEditor = UIVideoEditorController()
    videoEditor.delegate = self

    presentViewController(videoEditor, animated: true, completion: nil)
  }

  // MARK: - UIVideoEditorControllerDelegate

  func videoEditorControllerDidCancel(editor: UIVideoEditorController) {

  }

  func videoEditorController(editor: UIVideoEditorController, didFailWithError error: NSError) {

  }

  func videoEditorController(editor: UIVideoEditorController, didSaveEditedVideoToPath editedVideoPath: String) {
    
  }
}

