Class {
	#name : 'GemocAssignee',
	#superclass : 'GemocType',
	#traits : 'TGemocAssignee',
	#classTraits : 'TGemocAssignee classTrait',
	#instVars : [
		'value'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocAssignee >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocAssignee: self
]

{ #category : 'printing' }
GemocAssignee >> printOn: aStream [

	value ifNil: [ ^ aStream << 'No assignee found' ].
	value printOn: aStream
]

{ #category : 'accessing' }
GemocAssignee >> value: aGemocVariableDeclaration [ 
	value := aGemocVariableDeclaration
]
