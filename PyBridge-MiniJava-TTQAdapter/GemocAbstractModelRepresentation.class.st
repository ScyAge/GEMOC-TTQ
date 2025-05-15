Class {
	#name : 'GemocAbstractModelRepresentation',
	#superclass : 'Object',
	#instVars : [
		'executionStep',
		'pc',
		'model',
		'programState',
		'ruleName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
}

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> basicModel [

	^ programState ifNil:[executionStep semanticRuleStaticTarget value]
]

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> build [
	^ self subclassResponsibility
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

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> programState [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
GemocAbstractModelRepresentation >> programState: anObject [

	programState := anObject
]

{ #category : 'testing' }
GemocAbstractModelRepresentation >> ruleName [

	^ruleName ifNil: [
		| col |
		col := executionStep semanticRuleName value splitOn: '_'.
		ruleName := col last ]
]

{ #category : 'as yet unclassified' }
GemocAbstractModelRepresentation >> uuid [
	^ self subclassResponsibility
]
