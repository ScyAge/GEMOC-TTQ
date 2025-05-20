Class {
	#name : 'GemocProgramState',
	#superclass : 'GemocAbstractModelRepresentation',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'as yet unclassified' }
GemocProgramState class >> assignment: aGemocStep [
	^GemocAssignment step: aGemocStep 
]

{ #category : 'as yet unclassified' }
GemocProgramState class >> fromGemocStep: aGemocStep [

	^ self
		  newStepNamed:
			  aGemocStep semanticRuleStaticTarget value __class__ __name__
				  literalValue
		  fromGemocStep: aGemocStep
]

{ #category : 'as yet unclassified' }
GemocProgramState class >> methodCall: aGemocStep [
	^GemocMethodCall step: aGemocStep 
]

{ #category : 'as yet unclassified' }
GemocProgramState class >> newStepNamed: stepName fromGemocStep: aGemocStep [

	^ GemocProgramStateGenerator new build: aGemocStep typed: stepName
]

{ #category : 'as yet unclassified' }
GemocProgramState class >> step: aGemocStep [ 
	|programState|
	programState := self new.
	programState executionStep: aGemocStep.
	programState programState: aGemocStep semanticRuleStaticTarget value.
	^programState 
]

{ #category : 'reflective operations' }
GemocProgramState >> uuid [
	self pc = -1 ifTrue:[^'0xError'].
	^self executionStep uuid
]
