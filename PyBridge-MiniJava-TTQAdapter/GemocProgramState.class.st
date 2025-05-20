Class {
	#name : 'GemocProgramState',
	#superclass : 'GemocAbstractModelRepresentation',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'as yet unclassified' }
GemocProgramState class >> fromGemocStep: aGemocStep [

	^ self
		  newStepNamed:
			  aGemocStep semanticRuleStaticTarget value __class__ __name__
				  literalValue
		  fromGemocStep: aGemocStep
]

{ #category : 'as yet unclassified' }
GemocProgramState class >> newStepNamed: stepName fromGemocStep: aGemocStep [

	^ GemocProgramStateGenerator new build: aGemocStep typed: stepName
]

{ #category : 'printing' }
GemocProgramState >> printOn: aStream [
	"Append to the argument, aStream, a sequence of characters that
	identifies the receiver."

	| title |
	title := self class name.
	aStream
		nextPutAll: (title first isVowel ifTrue: ['an '] ifFalse: ['a ']);
		nextPutAll: title
]
