
import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.session.run(configuration)
        self.sceneView.autoenablesDefaultLighting = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        let sun = SCNNode(geometry: SCNSphere(radius: 0.35))
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        sun.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Sun Diffuse")
        sun.position = SCNVector3(0,0,-1)
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2, 0, 0)
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
        let earth = planet(geometery:SCNSphere(radius: 0.2),
                           diffuse: UIImage(named: "Earth Day")! ,
                           specular:UIImage(named: "Earth Specular"),
                           emission:UIImage(named: "Earth Emission"),
                           normal:UIImage(named: "Earth Normal"),
                           position:SCNVector3(1.2, 0, 0))
        earthParent.addChildNode(earth)
        earthParent.addChildNode(moonParent)
        let earthMoon = planet(geometery:SCNSphere(radius: 0.05),
                          diffuse: UIImage(named: "Moon Surface")! ,
                          specular: nil,
                          emission: nil,
                          normal: nil,
                        position:SCNVector3(0, 0, -0.3))
        moonParent.addChildNode(earthMoon)
        let venus = planet(geometery:SCNSphere(radius: 0.1),
                          diffuse: UIImage(named: "Venus Surface")! ,
                          specular:nil,
                          emission:UIImage(named: "Venus Atmosphere"),
                          normal:nil,
                           position:SCNVector3(0.7, 0, 0))
        venusParent.addChildNode(venus)
        
        let sunText = SCNText(string: "Sun", extrusionDepth: 0.1)
        let venusText = SCNText(string: "Venus", extrusionDepth: 0.1)
        let earthText = SCNText(string: "Earth", extrusionDepth: 0.1)
        let moonText = SCNText(string: "Moon", extrusionDepth: 0.1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.black
        sunText.materials = [material]
        venusText.materials = [material]
        earthText.materials = [material]
        moonText.materials = [material]
        
        let sunNode = SCNNode()
        sunNode.position = SCNVector3(x:0, y:0.4, z:0)
        sunNode.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
        sunNode.geometry = sunText
        sun.addChildNode(sunNode)
        
        let venusNode = SCNNode()
        venusNode.position = SCNVector3(x:0, y:0.3, z:0)
        venusNode.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
        venusNode.geometry = venusText
        venus.addChildNode(venusNode)
        
        let earthNode = SCNNode()
        earthNode.position = SCNVector3(x:0, y:0.3, z:0)
        earthNode.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
        earthNode.geometry = earthText
        earth.addChildNode(earthNode)
        
        let moonNode = SCNNode()
        moonNode.position = SCNVector3(x:0, y:0.2, z:0)
        moonNode.scale = SCNVector3(x:0.01, y:0.01, z:0.01)
        moonNode.geometry = moonText
        earthMoon.addChildNode(moonNode)
        
        let sunAction = Rotation(time: 8)
        sun.runAction(sunAction)
        
        let earthParentRotaion = Rotation(time: 14)
        earthParent.runAction(earthParentRotaion)
        
        let venusParentRotaion = Rotation(time: 10)
        venusParent.runAction(venusParentRotaion)
        
        let earthRotation = Rotation(time: 8)
        earth.runAction(earthRotation)
        
        let venusRotation = Rotation(time: 8)
        venus.runAction(venusRotation)
        
        let moonParentRotation = Rotation(time: 5)
        moonParent.runAction(moonParentRotation)
        
//        earth.geometry = SCNSphere(radius: 0.2)
//        earth.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Earth Day")
//        earth.geometry?.firstMaterial?.specular.contents = UIImage(named: "Earth Specular")
//        earth.geometry?.firstMaterial?.emission.contents = UIImage(named: "Earth Emission")
//        earth.geometry?.firstMaterial?.normal.contents = UIImage(named: "Earth Normal")
//        earth.position = SCNVector3(1.2, 0, 0)
        
//        let action = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: 8)
//        let forever = SCNAction.repeatForever(action)
//        earth.runAction(forever)
        
    }
    func planet(geometery:SCNGeometry, diffuse:UIImage, specular:UIImage?, emission:UIImage?, normal:UIImage?, position:SCNVector3) -> SCNNode{
        let planet = SCNNode(geometry: geometery)
        planet.geometry?.firstMaterial?.diffuse.contents = diffuse
        planet.geometry?.firstMaterial?.specular.contents = specular
        planet.geometry?.firstMaterial?.emission.contents = emission
        planet.geometry?.firstMaterial?.normal.contents = normal
        planet.position = position
        return planet
    }
    func Rotation(time: TimeInterval) -> SCNAction{
        let Rotation = SCNAction.rotateBy(x: 0, y: CGFloat(360.degreeToRadians), z: 0, duration: time)
        let foreverRotation = SCNAction.repeatForever(Rotation)
        return foreverRotation
    }
    


}
extension Int{
    var degreeToRadians: Double {return Double(self) * .pi/180}
}

