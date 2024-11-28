Class {
	#name : 'GemocMethod',
	#superclass : 'GemocProgramState',
	#instVars : [
		'name',
		'args'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'visiting' }
GemocMethod >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocMethod: self
]

{ #category : 'as yet unclassified' }
GemocMethod >> args: aCollection [ 
	args := aCollection
]

{ #category : 'building' }
GemocMethod >> build [

	self acceptVisitor: GemocProgramStateGenerator new
]

{ #category : 'accessing' }
GemocMethod >> name: aString [ 
	name := aString
]

{ #category : 'printing' }
GemocMethod >> nicePrintOn: aStream nbTabs: nbTabs [

	
	aStream << name.
	aStream << '('.
	args do: [ :a |
		a printOn: aStream.
		a = args last ifFalse: [ aStream << ','. aStream space ] ].
	aStream << ')'
]

{ #category : 'printing' }
GemocMethod >> printOn: aStream [

	"aStream << '[METHOD]'.
	aStream space.
"
	aStream << name.

	aStream << '('.
	args do: [ :a |
		a printOn: aStream.
		a = args last ifFalse: [ aStream << ',' ] ].

	aStream << ')'
]
