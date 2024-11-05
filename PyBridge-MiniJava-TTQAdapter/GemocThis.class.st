Class {
	#name : 'GemocThis',
	#superclass : 'GemocExpression',
	#instVars : [
		'objectAddress'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'visiting' }
GemocThis >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocThis: self
]

{ #category : 'printing' }
GemocThis >> printOn: aStream [
	aStream << 'this'
]

{ #category : 'api' }
GemocThis >> retrieveObjectAddress [
	|addrString|
	addrString := (model printString splitOn: Character space) last.
	objectAddress := addrString copyFrom: 1 to: addrString size - 1
]
