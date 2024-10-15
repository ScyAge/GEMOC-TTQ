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
	instance programState: aPybridgeObject.
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

{ #category : 'building' }
GemocProgramStateGenerator >> parseAndBuildAssignmentValue: aGemocAssignment [


	| pyObjectValue _value assignmentValue |
	pyObjectValue := (((aGemocAssignment programState __dict__ items asNativeList
		                    collect: #asNativeList)
		                   detect: [ :c | c first literalValue = 'value' ]
		                   ifNone: [ ^ nil ]) ifNotNil: [ :c | c second ])
		                 value.
	_value := pyObjectValue value _value.
	assignmentValue := self fromPybridgeObject: _value.
	assignmentValue acceptVisitor: self.
	^assignmentValue

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
	aGemocAssignment assignee: assignee.
	value := self parseAndBuildAssignmentValue: aGemocAssignment.
	aGemocAssignment value: value
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocBlock: aGemocBlock [

	| statements |
	statements := aGemocBlock model statements asNativeList collect: [ :s |
		              | gemocStatement |
		              gemocStatement := self fromPybridgeObject: s.
		              gemocStatement acceptVisitor: self ].
	aGemocBlock statements: statements
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocClassRef: aGemocClassRef [

	aGemocClassRef name:
		aGemocClassRef model referencedClass value name literalValue
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocMethod: aGemocMethod [

	aGemocMethod name: aGemocMethod model name literalValue.
	aGemocMethod args:
		(aGemocMethod model params asNativeList collect: [ :p |
			 | gemocParam |
			 gemocParam := self fromPybridgeObject: p.
			 gemocParam acceptVisitor: self.
			 gemocParam ])
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocMethodCall: aGemocMethodCall [

	| method receiver |
	method := self fromPybridgeObject:
		          aGemocMethodCall programState method.
	method acceptVisitor: self.
	aGemocMethodCall method: method.
	
	receiver := self fromPybridgeObject:
		          aGemocMethodCall programState receiver.
	receiver acceptVisitor: self.
	aGemocMethodCall receiver: receiver

]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocNewObject: aGemocNewObject [ 
	
	aGemocNewObject instantiation: aGemocNewObject model type name literalValue.
	aGemocNewObject model args asNativeList isEmpty ifFalse:[self halt]
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocPrintStatement: aGemocPrintStatement [ 
	|expr|
	expr := self fromPybridgeObject: aGemocPrintStatement model expression value.
	expr acceptVisitor: self.
	aGemocPrintStatement expression: expr
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocStringConstant: aGemocStringConstant [

	aGemocStringConstant value:
		aGemocStringConstant model pyBridgeObjectValue _value literalValue
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocStringTypeRef: aGemocStringTypeRef [ 
	aGemocStringTypeRef name: 'String'
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocSymbolRef: aGemocSymbolRef [ 
	|symbol|
	symbol := self fromPybridgeObject: aGemocSymbolRef model symbol value.
	symbol acceptVisitor: self.
	aGemocSymbolRef symbol: symbol
	
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocVariableDeclaration: aGemocVariableDeclaration [ 
		|type name|
		type := self fromPybridgeObject: aGemocVariableDeclaration model typeRef value.
		type acceptVisitor: self.
		aGemocVariableDeclaration type: type.
		aGemocVariableDeclaration name: aGemocVariableDeclaration model name literalValue.
]
