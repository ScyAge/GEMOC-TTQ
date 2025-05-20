Class {
	#name : 'GemocAbstractModelRepresentation',
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
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
}

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation class >> step: aGemocStep [ 
	|programState|
	programState := self new.
	programState executionStep: aGemocStep.
	programState model: aGemocStep semanticRuleStaticTarget value.
	^programState 
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> basicModel [

	^ model ifNil:[executionStep semanticRuleStaticTarget value]
]

{ #category : 'building' }
GemocAbstractModelRepresentation >> build [
	GemocProgramStateGenerator new visit: self
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> ensureModel [

	model := self basicModel
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> executionStep [

	^ executionStep
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> executionStep: anObject [

	executionStep := anObject
]

{ #category : 'testing' }
GemocAbstractModelRepresentation >> isStatementEvaluation [
	^self ruleName = 'evaluateStatement'
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> model [

	^ model ifNil: [ self ensureModel ]
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> model: aPyBridgeObject [ 
	model := aPyBridgeObject 
]

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> nicePrintOn: aStream nbTabs: anObject [
	self printOn: aStream
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> node [
	^self
]

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> nodeIsAssignment [
	^false
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> pc [
	^pc ifNil:[pc := [executionStep number literalValue] on: Error do:[-1]]
]

{ #category : 'testing' }
GemocAbstractModelRepresentation >> ruleName [

	^ruleName ifNil: [
		| col |
		col := executionStep semanticRuleName value splitOn: '_'.
		ruleName := col last ]
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> superTypes [

	^ superTypes
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> superTypes: anObject [

	superTypes := anObject
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> typeClass [

	^ typeClass
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> typeClass: anObject [

	typeClass := anObject
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> typeName [

	^ typeName
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> typeName: anObject [

	typeName := anObject
]

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> uuid [
	^ self subclassResponsibility
]
