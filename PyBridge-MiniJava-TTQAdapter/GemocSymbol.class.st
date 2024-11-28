Class {
	#name : 'GemocSymbol',
	#superclass : 'GemocTypedDeclaration',
	#category : 'PyBridge-MiniJava-TTQAdapter-generated',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'generated'
}

{ #category : 'printing' }
GemocSymbol >> printOn: aStream [

	self printName: name on: aStream

]
