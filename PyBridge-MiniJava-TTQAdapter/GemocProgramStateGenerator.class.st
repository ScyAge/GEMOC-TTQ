Class {
	#name : 'GemocProgramStateGenerator',
	#superclass : 'Object',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'as yet unclassified' }
GemocProgramStateGenerator >> build: step typed: typeName [

	^ (self classNamed: typeName) step: step
]

{ #category : 'as yet unclassified' }
GemocProgramStateGenerator >> classNamed: typeName [

	| className |
	className := 'Gemoc' , typeName.
	^ Smalltalk
		  at: className asSymbol
		  ifAbsent: [ self generateClass: className ]
]

{ #category : 'as yet unclassified' }
GemocProgramStateGenerator >> generateClass: className [

	^ GemocProgramState subclass: className
]
