Class {
	#name : 'GemocAssignment',
	#superclass : 'GemocProgramState',
	#instVars : [
		'variableType',
		'variableName',
		'assignee',
		'value'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'visiting' }
GemocAssignment >> acceptVisitor: aGemocProgramStateGenerator [ 
	aGemocProgramStateGenerator visitGemocAssignment: self
]

{ #category : 'accessing' }
GemocAssignment >> assignee [

	^ assignee
]

{ #category : 'accessing' }
GemocAssignment >> assignee: anObject [

	assignee := anObject
]

{ #category : 'tests' }
GemocAssignment >> getValue [

	| pyObjectValue _value |
	pyObjectValue := (((programState __dict__ items asNativeList
		                    collect: #asNativeList)
		                   detect: [ :c | c first literalValue = 'value' ]
		                   ifNone: [ ^ nil ]) ifNotNil: [ :c | c second ])
		                 value.
	_value := pyObjectValue value _value.
	self parse: _value
	self halt
]

{ #category : 'printing' }
GemocAssignment >> nicePrintOn: aStream nbTabs: nbTabs [
	assignee printOn: aStream.
	aStream << ' = '.
	value printOn: aStream.
	aStream << ';'.
]

{ #category : 'as yet unclassified' }
GemocAssignment >> nodeIsAssignment [
	^true
]

{ #category : 'printing' }
GemocAssignment >> printOn: aStream [
	aStream << '[ASSIGNMENT]'.
	aStream space.
	assignee printOn: aStream.
	aStream << ' = '.
	value printOn: aStream
]

{ #category : 'accessing' }
GemocAssignment >> value: anObject [

	value := anObject
]
