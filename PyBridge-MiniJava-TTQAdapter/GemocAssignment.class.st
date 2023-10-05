Class {
	#name : #GemocAssignment,
	#superclass : #GemocProgramState,
	#instVars : [
		'variableType',
		'variableName'
	],
	#category : #'PyBridge-MiniJava-TTQAdapter'
}

{ #category : #building }
GemocAssignment >> build [
	|assignee value|
	assignee := programState assignee value.
	variableType := assignee typeRef value referencedClass value name.	
	variableName := assignee name. 
	value := self getValue.
	self hal
]

{ #category : #tests }
GemocAssignment >> getValue [

	^ ((programState __dict__ items asNativeList collect: #asNativeList)
		   detect: [ :c | c first literalValue = 'value' ]
		   ifNone: [ nil ]) ifNotNil: [ :c | c second ] value
]

{ #category : #'as yet unclassified' }
GemocAssignment >> nodeIsAssignment [
	^true
]
