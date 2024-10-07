Class {
	#name : 'GemocProgramState',
	#superclass : 'Object',
	#instVars : [
		'executionStep',
		'programState'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
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

{ #category : 'building' }
GemocProgramState >> build [
	self subclassResponsibility 
]

{ #category : 'accessing' }
GemocProgramState >> executionStep [

	^ executionStep
]

{ #category : 'accessing' }
GemocProgramState >> executionStep: anObject [

	executionStep := anObject
]

{ #category : 'accessing' }
GemocProgramState >> node [
	^self
]

{ #category : 'as yet unclassified' }
GemocProgramState >> nodeIsAssignment [
	^false
]

{ #category : 'accessing' }
GemocProgramState >> programState [

	^ programState
]

{ #category : 'accessing' }
GemocProgramState >> programState: anObject [

	programState := anObject
]
