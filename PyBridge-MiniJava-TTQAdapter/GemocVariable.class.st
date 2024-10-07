Class {
	#name : 'GemocVariable',
	#superclass : 'GemocRuntimeEntity',
	#instVars : [
		'variableName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter',
	#package : 'PyBridge-MiniJava-TTQAdapter'
}

{ #category : 'accessing' }
GemocVariable >> name [
	^variableName
]

{ #category : 'accessing' }
GemocVariable >> variableName [

	^ variableName
]

{ #category : 'accessing' }
GemocVariable >> variableName: anObject [

	variableName := anObject
]
