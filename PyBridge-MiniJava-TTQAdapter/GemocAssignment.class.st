Class {
	#name : 'GemocAssignment',
	#superclass : 'GemocProgramState',
	#instVars : [
		'variableType',
		'variableName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'building' }
GemocAssignment >> build [
	|assignee value|
	assignee := programState assignee value.
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

{ #category : 'parsing' }
GemocAssignment >> parse: aPyBridgeObject [

	^ aPyBridgeObject printString readStream
		  upToAll: '<pyecore.ecore.';
		  upTo: Character space
]
