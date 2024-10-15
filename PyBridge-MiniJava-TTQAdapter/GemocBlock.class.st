Class {
	#name : 'GemocBlock',
	#superclass : 'GemocProgramState',
	#instVars : [
		'statements'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'visiting' }
GemocBlock >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocBlock: self
]

{ #category : 'building' }
GemocBlock >> build [
	self acceptVisitor: GemocProgramStateGenerator new
]

{ #category : 'testing' }
GemocBlock >> isBlock [
	^true
]

{ #category : 'accessing' }
GemocBlock >> printOn: aStream [

	aStream << '[BLOCK]'.
	aStream space.
	statements do: [ :s |
		s printOn: aStream.
		aStream space ]
]

{ #category : 'accessing' }
GemocBlock >> statements: aCollection [ 
	statements := aCollection
]
