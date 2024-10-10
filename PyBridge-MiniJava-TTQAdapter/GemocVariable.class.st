Class {
	#name : 'GemocVariable',
	#superclass : 'GemocRuntimeEntity',
	#instVars : [
		'variableName'
	],
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
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
