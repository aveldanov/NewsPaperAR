//
//  ViewController.swift
//  NewsPaperAR
//
//  Created by Veldanov, Anton on 4/23/20.
//  Copyright © 2020 Anton Veldanov. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
  
  @IBOutlet var sceneView: ARSCNView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Set the view's delegate
    sceneView.delegate = self
    
    // Show statistics such as fps and timing information
    sceneView.showsStatistics = true
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Create a session configuration
    let configuration = ARWorldTrackingConfiguration()
    
    if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main){
      configuration.detectionImages = imageToTrack
      configuration.maximumNumberOfTrackedImages = 1
      print("Images recognized")
    }
    
    
    
    // Run the view's session
    sceneView.session.run(configuration)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Pause the view's session
    sceneView.session.pause()
  }
  
  // MARK: - ARSCNViewDelegate
  
  
  // Override to create and configure nodes for anchors added to the view's session.
  func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
    let node = SCNNode()
    
    // check anchor type
    if let imageAnchor = anchor as? ARImageAnchor{
      
      let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
      plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.7)
      
      
      let planeNode = SCNNode(geometry: plane)
      
      planeNode.eulerAngles.x = -.pi/2
      
      node.addChildNode(planeNode)
      
    }
    
    
    return node
  }
  
  
  
}
