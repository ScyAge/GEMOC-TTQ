Class {
	#name : 'GemocType',
	#superclass : 'Object',
	#instVars : [
		'executionStep',
		'pc',
		'model',
		'ruleName',
		'superTypes',
		'typeClass',
		'typeName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'as yet unclassified' }
GemocType class >> fromGemocStep: aGemocStep [

	^ self
		  newStepNamed:
			  aGemocStep semanticRuleStaticTarget value __class__ __name__
				  literalValue
		  fromGemocStep: aGemocStep
]

{ #category : 'as yet unclassified' }
GemocType class >> newStepNamed: stepName fromGemocStep: aGemocStep [

	^ GemocProgramStateGenerator new build: aGemocStep typed: stepName
]

{ #category : 'as yet unclassified' }
GemocType class >> step: aGemocStep [ 
	|programState|
	programState := self new.
	programState executionStep: aGemocStep.
	programState model: aGemocStep semanticRuleStaticTarget value.
	^programState 
]

{ #category : 'accessing' }
GemocType >> basicModel [

	^ model ifNil:[executionStep semanticRuleStaticTarget value]
]

{ #category : 'building' }
GemocType >> build [
	GemocProgramStateGenerator new visit: self
]

{ #category : 'accessing' }
GemocType >> ensureModel [

	model := self basicModel
]

{ #category : 'accessing' }
GemocType >> executionStep [

	^ executionStep
]

{ #category : 'accessing' }
GemocType >> executionStep: anObject [

	executionStep := anObject
]

{ #category : 'testing' }
GemocType >> isStatementEvaluation [
	^self ruleName = 'evaluateStatement'
]

{ #category : 'accessing' }
GemocType >> model [

	^ model ifNil: [ self ensureModel ]
]

{ #category : 'accessing' }
GemocType >> model: aPyBridgeObject [ 
	model := aPyBridgeObject 
]

{ #category : 'as yet unclassified' }
GemocType >> nicePrintOn: aStream nbTabs: anObject [
	self printOn: aStream
]

{ #category : 'accessing' }
GemocType >> node [
	^self
]

{ #category : 'as yet unclassified' }
GemocType >> nodeIsAssignment [
	^false
]

{ #category : 'accessing' }
GemocType >> pc [
	^pc ifNil:[pc := [executionStep number literalValue] on: Error do:[-1]]
]

{ #category : 'printing' }
GemocType >> printName: aString on: aStream [

	aStream << (aString ifNil: [ '<name not found>' ])
]

{ #category : 'printing' }
GemocType >> printOn: aStream [

	aStream << (typeName ifNil: [ 'An undefined Gemoc type' ]).
	superTypes ifEmpty: [ ^ self ].
	aStream << ' (super types: '.
	superTypes do: [ :st |
		aStream << st typeName.
		aStream << (st == superTypes last
			 ifTrue: [ ')' ]
			 ifFalse: [ ', ' ]) ]
]

{ #category : 'testing' }
GemocType >> ruleName [

	^ruleName ifNil: [
		| col |
		col := executionStep semanticRuleName value splitOn: '_'.
		ruleName := col last ]
]

{ #category : 'accessing' }
GemocType >> superTypes [

	^ superTypes
]

{ #category : 'accessing' }
GemocType >> superTypes: anObject [

	superTypes := anObject
]

{ #category : 'accessing' }
GemocType >> typeClass [

	^ typeClass
]

{ #category : 'accessing' }
GemocType >> typeClass: anObject [

	typeClass := anObject
]

{ #category : 'accessing' }
GemocType >> typeName [

	^ typeName
]

{ #category : 'accessing' }
GemocType >> typeName: anObject [

	typeName := anObject
]

{ #category : 'reflective operations' }
GemocType >> uuid [
	self pc = -1 ifTrue:[^'0xError'].
	^self executionStep uuid
]
