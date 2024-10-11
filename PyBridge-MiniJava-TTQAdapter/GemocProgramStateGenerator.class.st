Class {
	#name : 'GemocProgramStateGenerator',
	#superclass : 'Object',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'building' }
GemocProgramStateGenerator >> build: aPyBridgeObject [

	
]

{ #category : 'building' }
GemocProgramStateGenerator >> build: step typed: typeName [

	^ (self classNamed: typeName) step: step
]

{ #category : 'building' }
GemocProgramStateGenerator >> classNamed: typeName [

	| className |
	className := 'Gemoc' , typeName.
	^ Smalltalk
		  at: className asSymbol
		  ifAbsent: [ self generateClass: className ]
]

{ #category : 'parsing' }
GemocProgramStateGenerator >> fromPybridgeObject: aPybridgeObject [

	| typeName type instance |
	typeName := self parse: aPybridgeObject.
	type := self typeNamed: typeName.
	instance := type new.
	instance model: aPybridgeObject.
	^ instance
]

{ #category : 'building' }
GemocProgramStateGenerator >> generateClass: className [

	^ GemocProgramState subclass: className
]

{ #category : 'parsing' }
GemocProgramStateGenerator >> parse: aPyBridgeObject [

	^ aPyBridgeObject printString readStream
		  upToAll: '<pyecore.ecore.';
		  upTo: Character space
]

{ #category : 'parsing' }
GemocProgramStateGenerator >> typeNamed: typeName [

	^ Smalltalk at: ('Gemoc' , typeName) asSymbol
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visit: aGemocTypeInstance [

	aGemocTypeInstance acceptVisitor: self
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocAssignee: aGemocAssignee [

	| value |
	value := self fromPybridgeObject: aGemocAssignee model.
	value acceptVisitor: self.
	aGemocAssignee value: value
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocAssignment: aGemocAssignment [

	| assignee value |
	assignee := GemocAssignee new.
	assignee model: aGemocAssignment programState assignee value.
	assignee acceptVisitor: self.
	aGemocAssignment assignee: assignee
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocAssignmentOld: aGemocAssignment [

	| assignee value |
	assignee := self fromPybridgeObject:
		            aGemocAssignment programState assignee value.
	assignee acceptVisitor: self.
	aGemocAssignment assignee: assignee
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocClassRef: aGemocClassRef [ 
	aGemocClassRef name: aGemocClassRef model referencedClass value name
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocVariableDeclaration: aGemocVariableDeclaration [ 
		|type name|
		type := self fromPybridgeObject: aGemocVariableDeclaration model typeRef value.
		type acceptVisitor: self.
		aGemocVariableDeclaration type: type.
		aGemocVariableDeclaration name: aGemocVariableDeclaration model name literalValue.
]
