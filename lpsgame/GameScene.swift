//
//  GameScene.swift
//  lpsgame
//
//  
//  Copyright (c) 2019 Juanjo&Juanjo. All rights reserved.
//

import SpriteKit

var logo: SKSpriteNode!
var barra: SKSpriteNode!
var barra2: SKSpriteNode!
var barra3: SKSpriteNode!
var barra4: SKSpriteNode!
var barraPregunta: SKSpriteNode!
var soundWin: SKAction!
var soundFall: SKAction!

var fondo: SKSpriteNode!
var labelPregunta: SKLabelNode!
var labelRespuesta1: SKLabelNode!
var labelRespuesta2: SKLabelNode!
var labelRespuesta3: SKLabelNode!
var labelRespuesta4: SKLabelNode!
var labelResultado: SKLabelNode!
var labelScoreUser: SKLabelNode!

var pregunta: String!
var respuesta1: String!
var respuesta2: String!
var respuesta3: String!
var respuesta4: String!



var nodoSelected: SKSpriteNode!

//para saber si estoy jugando
var isGame: Bool = false
var numAleatorio: Int!

var selUser: Int!
var scoreUser: Int = 0


class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        
        self.iniGame()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
        
        
        if(isGame == true){
            
            //el Juego ha iniciado
            
            //primer toque
            let touch = touches.first
            //localizacion del toque
            let touchLocation = touch?.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation!)
            
            
            //gestion de nodos
            if(touchedNode.name == "barra" || touchedNode.name == "labelRespuesta1"){
                
                selUser = 1
                
                self.quienGana()
            }
            else if(touchedNode.name == "barra2" || touchedNode.name == "labelRespuesta2"){
                
                selUser = 2
                self.quienGana()
            }
            else if(touchedNode.name == "barra3" || touchedNode.name == "labelRespuesta3"){
                
                selUser = 2
                self.quienGana()
            }
            else if(touchedNode.name == "barra4" || touchedNode.name == "labelRespuesta4"){
                
                selUser = 2
                self.quienGana()
            }
            isGame = false
            
        }else{
            //el juego va a iniciar
            
            resetGame()
            configurarRespuestas()
            let showBig = SKAction.scaleTo(0.7, duration: 0.4)
            let izquierda = SKAction.moveToX(CGRectGetMidX(self.frame) - 200, duration: 2)
            let secuencia = SKAction.sequence([showBig,izquierda])
            logo.runAction(secuencia, completion: {
                barra = SKSpriteNode(imageNamed: "Barra")
                barra.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY+200)
                barra.size = CGSize(width: 400, height: 100)
                barra.name = "barra"
                barra.zPosition = 140
                self.addChild(barra)
                
                barra2 = SKSpriteNode(imageNamed: "Barra")
                barra2.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY+75)
                barra2.size = CGSize(width: 400, height: 100)
                barra2.name = "barra2"
                barra2.zPosition = 140
                self.addChild(barra2)
                
                barra3 = SKSpriteNode(imageNamed: "Barra")
                barra3.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY-50)
                barra3.size = CGSize(width: 400, height: 100)
                barra3.name = "barra3"
                barra3.zPosition = 140
                self.addChild(barra3)
                
                barra4 = SKSpriteNode(imageNamed: "Barra")
                barra4.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY-175)
                barra4.size = CGSize(width: 400, height: 100)
                barra4.name = "barra4"
                barra4.zPosition = 140
                self.addChild(barra4)
                
                barraPregunta = SKSpriteNode(imageNamed: "barraRoja")
                barraPregunta.position = CGPoint(x: self.frame.midX-300, y: self.frame.midY+200)
                barraPregunta.size = CGSize(width: 900, height: 100)
                barraPregunta.name = "barra4"
                barraPregunta.zPosition = 140
                self.addChild(barraPregunta)
                
            
                
                let big = SKAction.scaleTo(1, duration: 0.3)
                let secuenciaDos = SKAction.sequence([big])
                
                barra4.runAction(secuenciaDos, completion: {
                    
                    labelPregunta = SKLabelNode(fontNamed: "Noteworthy-Light")
                    labelPregunta.text = pregunta
                    labelPregunta.fontSize = 25
                    //Z position es un numero de capa para superponerse
                    labelPregunta.zPosition = 170
                    labelPregunta.position = CGPoint(x: self.frame.midX-200, y: self.frame.midY+200)
                    self.addChild(labelPregunta)
                    
                    //R1: unidad
                    //R2: servicio
                    //R3: zona
                    //R4: ninguna
                    
                    labelRespuesta1 = SKLabelNode(fontNamed: "Noteworthy-Light")
                    labelRespuesta1.text = respuesta1
                    labelRespuesta1.fontSize = 20
                    //Z position es un numero de capa para superponerse
                    labelRespuesta1.zPosition = 170
                    labelRespuesta1.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY+200)
                    
                    self.addChild(labelRespuesta1)
                    labelRespuesta1.runAction(secuenciaDos, completion: {
                        labelRespuesta2 = SKLabelNode(fontNamed: "Noteworthy-Light")
                        labelRespuesta2.text = respuesta2
                        labelRespuesta2.fontSize = 20
                        //Z position es un numero de capa para superponerse
                        labelRespuesta2.zPosition = 170
                        labelRespuesta2.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY+75)
                        
                        self.addChild(labelRespuesta2)
                        
                        labelRespuesta2.runAction(secuenciaDos, completion: {
                            labelRespuesta3 = SKLabelNode(fontNamed: "Noteworthy-Light")
                            labelRespuesta3.text = respuesta3
                            labelRespuesta3.fontSize = 20
                            //Z position es un numero de capa para superponerse
                            labelRespuesta3.zPosition = 170
                            labelRespuesta3.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY-50)
                            
                            self.addChild(labelRespuesta3)
                            
                            labelRespuesta4 = SKLabelNode(fontNamed: "Noteworthy-Light")
                            labelRespuesta4.text = respuesta4
                            labelRespuesta4.fontSize = 20
                            //Z position es un numero de capa para superponerse
                            labelRespuesta4.zPosition = 170
                            labelRespuesta4.position = CGPoint(x: self.frame.midX+400, y: self.frame.midY-175)
                            
                            self.addChild(labelRespuesta4)
                            
                            
                            //MARCADORES
                            if(labelScoreUser == nil){
                                labelScoreUser = SKLabelNode(fontNamed: "Noteworthy-Light")
                                labelScoreUser.text = "0"
                                labelScoreUser.fontSize = 35
                                labelScoreUser.fontColor = UIColor.redColor()
                                labelScoreUser.zPosition = 300
                                labelScoreUser.position = CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMinY((self.frame)))
                                self.addChild(labelScoreUser)
                            }
                            
                            
                           

                        })
                    })
                    
                })
                
            })
            isGame = true

        }
        
        
        
        
        
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func configurarRespuestas(){
        let p1 = "Es más adecuado hablar de Trabajo Social Sanitario como..."
        let r1 = "Unidad"
        let r2 = "Servicio"
        let r3 = "Zona"
        let r4 = "Ninguna"
        let p2 = "¿Qué ciudad española se encuentra más alejada de Almería?"
        let r5 = "A Coruña"
        let r6 = "Salamanca"
        let r7 = "Lugo"
        let r8 = "Oviedo"
        let p3 = "¿Qué metodo en Java es el que se encarga de devolver un atributo?"
        let r9 = "Get"
        let r10 = "Set"
        let r11 = "Contains"
        let r12 = "Equals"
        
        let num = crearNumerosAleatorios(1, max: 3)
        
        if(num == 1){
            pregunta = p1
            respuesta1 = r1
            respuesta2 = r2
            respuesta3 = r3
            respuesta4 = r4
            
        }
        else if(num == 2){
            pregunta = p2
            respuesta1 = r5
            respuesta2 = r6
            respuesta3 = r7
            respuesta4 = r8
        }
        else if(num == 3){
            pregunta = p3
            respuesta1 = r9
            respuesta2 = r10
            respuesta3 = r11
            respuesta4 = r12
        }
    }
    
    //Funcion para la presentacion de la vista
    func iniGame(){
        fondo = SKSpriteNode(imageNamed: "fondoPlaya")
        fondo.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        fondo.size = CGSize(width: self.frame.width, height: self.frame.height)
        self.addChild(fondo)
        
        logo = SKSpriteNode(imageNamed: "logotipo")
        logo.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        logo.size = CGSize(width: 733, height: 450)
        logo.name = "logotipo"
        logo.zPosition = 150
        self.addChild(logo)
        
        
        soundWin = SKAction.playSoundFileNamed("win.mp3", waitForCompletion: true)
        soundFall = SKAction.playSoundFileNamed("fall.mp3", waitForCompletion: true)
        
    }
    
    
    
    //Mis funciones
    
    func quienGana(){
        
       
        if(selUser == 1){
            labelResultado = SKLabelNode(fontNamed: "Noteworthy-Light")
            labelResultado.text = "Acierto!!"
            labelResultado.fontSize = 100
            labelResultado.zPosition = 400
            labelResultado.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(labelResultado)
            
            labelScoreUser.runAction(soundWin)
            
            scoreUser += 1
            labelScoreUser.text = "Aciertos: \(scoreUser)"
            
        }
        else if(selUser == 2){
            labelResultado = SKLabelNode(fontNamed: "Noteworthy-Light")
            labelResultado.text = "Error!!"
            labelResultado.fontSize = 100
            labelResultado.zPosition = 400
            labelResultado.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            self.addChild(labelResultado)
            
            labelScoreUser.runAction(soundFall)
            labelScoreUser.text = "Aciertos: \(scoreUser)"
            
        

        }
        
        

    }
    
    
    func crearNumerosAleatorios(min: Int, max: Int) -> Int{
        
        return Int(arc4random_uniform(UInt32((max - min) + min))) + min
    }
    
    
    func juegoUsuario(imageNameNode: String, positionNode: CGPoint){
        nodoSelected = SKSpriteNode(imageNamed: imageNameNode)
        nodoSelected.position = positionNode
        nodoSelected.size = CGSize(width: 250, height: 250)
        self.addChild(nodoSelected)
        
    }
    func resetGame(){
        let delNodo = SKAction.removeFromParent()
        
        if(labelPregunta != nil){
            labelPregunta.runAction(delNodo)
        }
        if(labelRespuesta1 != nil){
           labelRespuesta1.runAction(delNodo)
        }

        if(labelRespuesta2 != nil){
            labelRespuesta2.runAction(delNodo)
        }
        
        if(labelRespuesta3 != nil){
            labelRespuesta3.runAction(delNodo)
        }
        if(labelRespuesta3 != nil){
            labelRespuesta3.runAction(delNodo)
        }
        if(labelRespuesta4 != nil){
            labelRespuesta4.runAction(delNodo)
        }
        if(labelResultado != nil){
            labelResultado.runAction(delNodo)
        }
        
       
        
    }
    
    
}
