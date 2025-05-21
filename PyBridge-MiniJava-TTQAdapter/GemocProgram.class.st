Class {
	#name : 'GemocProgram',
	#superclass : 'GemocType',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'building' }
GemocProgram >> build [
	"self halt"
]

{ #category : 'accessing' }
GemocProgram >> container [
	^executionStep _container
]

{ #category : 'printing' }
GemocProgram >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	| title |
	title := self class name.
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title
]
