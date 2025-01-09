Class {
	#name : 'GemocVariableDeclaration',
	#superclass : 'GemocSymbol',
	#traits : 'TGemocAssignee',
	#classTraits : 'TGemocAssignee classTrait',
	#instVars : [
		'type'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocVariableDeclaration >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocVariableDeclaration: self
]

{ #category : 'accessing' }
GemocVariableDeclaration >> name: aString [ 
	name := aString
]

{ #category : 'printing' }
GemocVariableDeclaration >> nicePrintOn: aStream nbTabs: nbTabs [

	type printOn: aStream.
	aStream space.
	self printName: name on: aStream

]

{ #category : 'printing' }
GemocVariableDeclaration >> printOn: aStream [

	"type printOn: aStream.
	aStream space."
	super printName: name on: aStream

]

{ #category : 'accessing - structure variables' }
GemocVariableDeclaration >> type [

	^ type
]

{ #category : 'accessing - structure variables' }
GemocVariableDeclaration >> type: aGemocClassRef [ 
	type := aGemocClassRef
]
