Class {
	#name : 'DynamicTTQCreator',
	#superclass : 'Object',
	#instVars : [
		'predicateList',
		'trace'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-model',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'model'
}

{ #category : 'adding' }
DynamicTTQCreator >> addPredicteInList: aPredicte [

predicateList add: aPredicte 
]

{ #category : 'initialization' }
DynamicTTQCreator >> initialize [ 

predicateList := OrderedCollection new.
]

{ #category : 'accessing' }
DynamicTTQCreator >> predicateList [

	^ predicateList
]

{ #category : 'accessing' }
DynamicTTQCreator >> trace [

	^ trace
]

{ #category : 'accessing' }
DynamicTTQCreator >> trace: anObject [

	trace := anObject
]
