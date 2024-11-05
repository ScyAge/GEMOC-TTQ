Class {
	#name : 'GemocIfStatement',
	#superclass : 'GemocStatement',
	#instVars : [
		'if',
		'then',
		'else'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocIfStatement >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocIfStatement: self
]

{ #category : 'accessing' }
GemocIfStatement >> else [

	^ else
]

{ #category : 'accessing' }
GemocIfStatement >> else: anObject [

	else := anObject
]

{ #category : 'accessing' }
GemocIfStatement >> if [

	^ if
]

{ #category : 'accessing' }
GemocIfStatement >> if: anObject [

	if := anObject
]

{ #category : 'accessing' }
GemocIfStatement >> then [

	^ then
]

{ #category : 'accessing' }
GemocIfStatement >> then: anObject [

	then := anObject
]
