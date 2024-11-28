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
GemocBlock >> nicePrintOn: aStream nbTabs: nbTabs [
	nbTabs = 0 ifFalse:[nbTabs timesRepeat: [ aStream space ]].
	aStream << '{'.
	aStream cr.
	statements do: [ :s |
		"aStream tab."
		nbTabs timesRepeat:[aStream tab].
		s nicePrintOn: aStream nbTabs: nbTabs.
		aStream cr ].
	nbTabs timesRepeat:[ aStream tab].
	aStream << '}'
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
