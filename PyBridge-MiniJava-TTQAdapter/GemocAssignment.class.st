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

{ #category : 'building' }
GemocAssignment >> build [
	GemocProgramStateGenerator new visit: self
]

{ #category : 'building' }
GemocAssignment >> buildOld [
	|assignee value|
	assignee := programState assignee value.
	self halt.
	variableType := self parse: assignee typeRef value.	
	variableName := assignee name. 
	value := self getValue.
	
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

{ #category : 'as yet unclassified' }
GemocAssignment >> nodeIsAssignment [
	^true
]

{ #category : 'accessing' }
GemocAssignment >> value: anObject [

	value := anObject
]
