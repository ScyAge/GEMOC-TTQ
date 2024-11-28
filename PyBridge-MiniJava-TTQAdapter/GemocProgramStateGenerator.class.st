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
GemocProgramStateGenerator >> parseAndBuildArraySize: aGemocNewArray [


	| pyObjectValue size sizeValue |
	pyObjectValue := (((aGemocNewArray model __dict__ items asNativeList
		                    collect: #asNativeList)
		                   detect: [ :c | c first literalValue = 'size' ]
		                   ifNone: [ ^ nil ]) ifNotNil: [ :c | c second ])
		                 value.
	size := pyObjectValue value _value.
	sizeValue := self fromPybridgeObject: size.
	sizeValue acceptVisitor: self.
	^sizeValue

]

{ #category : 'building' }
GemocProgramStateGenerator >> parseAndBuildLiteralValue: aGemocType [


	| pyObjectValue _value |
	pyObjectValue := (((aGemocType model __dict__ items asNativeList
		                    collect: #asNativeList)
		                   detect: [ :c | c first literalValue = 'value' ]
		                   ifNone: [ ^ nil ]) ifNotNil: [ :c | c second ])
		                 value.
	_value := pyObjectValue value _value.
	^_value literalValue

]

{ #category : 'building' }
GemocProgramStateGenerator >> parseAndBuildValue: aGemocType [


	| pyObjectValue _value valueObject |
	pyObjectValue := (((aGemocType model __dict__ items asNativeList
		                    collect: #asNativeList)
		                   detect: [ :c | c first literalValue = 'value' ]
		                   ifNone: [ ^ nil ]) ifNotNil: [ :c | c second ])
		                 value.
	_value := pyObjectValue value _value.
	valueObject := self fromPybridgeObject: _value.
	valueObject acceptVisitor: self.
	^valueObject

]

{ #category : 'parsing' }
GemocProgramStateGenerator >> typeNamed: typeName [

	^ Smalltalk at: ('Gemoc' , typeName) asSymbol
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visit: aGemocTypeInstance [

	[aGemocTypeInstance acceptVisitor: self] on: Error do: [:err| GemocTrace logError: 'Visit error: ', err printString]
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitArrayTypeRef: aGemocArrayTypeRef [ 
	|typeRef|
	typeRef := self fromPybridgeObject: 	aGemocArrayTypeRef model typeRef value.
	typeRef acceptVisitor: self.
	aGemocArrayTypeRef typeRef: typeRef
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocArrayAccess: aGemocArrayAccess [ 
	|arrayObject index|
	arrayObject := self fromPybridgeObject: aGemocArrayAccess model object value.
	arrayObject acceptVisitor: self.
	index :=  self fromPybridgeObject: aGemocArrayAccess model index value.
	index  acceptVisitor: self.
	aGemocArrayAccess arrayObject: arrayObject.
	aGemocArrayAccess accessIndex: index
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocArrayLength: aGemocArrayLength [

	| array |
	array := self fromPybridgeObject: aGemocArrayLength model array.

	array acceptVisitor: self.
	aGemocArrayLength array: array
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
	self flag: 'bug: check if the assignment is a literal or an object'.
	value := self parseAndBuildValue: aGemocAssignment.
	aGemocAssignment value: value
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocBinaryMessage: aGemocBinaryMessage [
	|left right|
	left := self fromPybridgeObject: aGemocBinaryMessage model left value.
	right := self fromPybridgeObject: aGemocBinaryMessage model right value.
	left acceptVisitor: self.
	right acceptVisitor: self.
	aGemocBinaryMessage left: left.
	aGemocBinaryMessage right: right
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
GemocProgramStateGenerator >> visitGemocForStatement: aGemocForStatement [ 
	|declaration condition progression block|
	declaration := self fromPybridgeObject: aGemocForStatement model declaration value.
	condition := self fromPybridgeObject: aGemocForStatement model condition value.
	progression := self fromPybridgeObject: aGemocForStatement model progression value.
	block := self fromPybridgeObject: aGemocForStatement model block value.
	
	declaration acceptVisitor: self.
	condition acceptVisitor: self.
	progression acceptVisitor: self.
	block acceptVisitor: self.
	
	aGemocForStatement declaration: declaration condition: condition progression: progression block: block
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocIfStatement: aGemocIfStatement [ 
	|if then else|
	if := self fromPybridgeObject: aGemocIfStatement model expression.
	then := [self fromPybridgeObject: aGemocIfStatement model thenBlock] on: Error do:[nil].
	else := [self fromPybridgeObject: aGemocIfStatement model elseBlock] on: Error do:[nil].
	if acceptVisitor: self.
	then ifNotNil:[then acceptVisitor: self].
	else ifNotNil:[else acceptVisitor: self].
	aGemocIfStatement if: if.
	aGemocIfStatement then: then.
	aGemocIfStatement else: else
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocIntConstant: aGemocIntConstant [ 
	aGemocIntConstant intValue: (self parseAndBuildLiteralValue: aGemocIntConstant)
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocIntegerTypeRef: aGemocIntegerTypeRef [ 
	aGemocIntegerTypeRef name: 'int'
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
GemocProgramStateGenerator >> visitGemocNewArray: aGemocNewArray [ 
	| type size |
	type := self fromPybridgeObject: aGemocNewArray model type value.
	type acceptVisitor: self.
	size := self parseAndBuildArraySize: aGemocNewArray.
	aGemocNewArray type: type.
	aGemocNewArray size: size
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocNewObject: aGemocNewObject [ 
	
	aGemocNewObject instantiation: aGemocNewObject model type name literalValue.
	aGemocNewObject model args asNativeList isEmpty ifFalse:[self halt]
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocParam: aGemocParameter [ 
	|name type|
	name := aGemocParameter model name value.
	type := self fromPybridgeObject: aGemocParameter model typeRef value.
	type acceptVisitor: self.
	aGemocParameter name: aGemocParameter model name value.
	aGemocParameter typeRef: type
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
GemocProgramStateGenerator >> visitGemocThis: aGemocThis [

	aGemocThis retrieveObjectAddress
]

{ #category : 'visiting' }
GemocProgramStateGenerator >> visitGemocVariableDeclaration: aGemocVariableDeclaration [ 
		|type name|
		type := self fromPybridgeObject: aGemocVariableDeclaration model typeRef value.
		type acceptVisitor: self.
		aGemocVariableDeclaration type: type.
		aGemocVariableDeclaration name: aGemocVariableDeclaration model name literalValue.
]
