Class {
	#name : 'GemocForStatement',
	#superclass : 'GemocStatement',
	#instVars : [
		'declaration',
		'condition',
		'progression',
		'block'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocForStatement >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocForStatement: self
]

{ #category : 'accessing' }
GemocForStatement >> block [

	^ block
]

{ #category : 'accessing' }
GemocForStatement >> block: anObject [

	block := anObject
]

{ #category : 'accessing' }
GemocForStatement >> condition [

	^ condition
]

{ #category : 'accessing' }
GemocForStatement >> condition: anObject [

	condition := anObject
]

{ #category : 'accessing' }
GemocForStatement >> declaration [

	^ declaration
]

{ #category : 'accessing' }
GemocForStatement >> declaration: anObject [

	declaration := anObject
]

{ #category : 'accessing' }
GemocForStatement >> declaration: d condition: c progression: p block: b [
	declaration := d.
	condition := c.
	progression := p.
	block := b
]

{ #category : 'accessing' }
GemocForStatement >> progression [

	^ progression
]

{ #category : 'accessing' }
GemocForStatement >> progression: anObject [

	progression := anObject
]
