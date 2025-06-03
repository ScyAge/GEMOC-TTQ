"
This class stock parameter for any type of predicate

- predicateOn is the type of an element in the model

- mapParam is s a dictionarie wich map a string representing an type of element (selector, arguments, asignee ...) with their value. 


mapParam is not initialize with a default dictionnary.
"
Class {
	#name : 'TTQPredicate',
	#superclass : 'Object',
	#instVars : [
		'predicateOn',
		'mapParam'
	],
	#category : 'Gemoc-DynamicTTQCreator-UI-model',
	#package : 'Gemoc-DynamicTTQCreator-UI',
	#tag : 'model'
}

{ #category : 'instance creation' }
TTQPredicate class >> newPredicateOn: element withDictionnary: aDictionnary [
	
	^ self new
		  mapParam: aDictionnary;
		  predicateOn: element;
		  yourself
]

{ #category : 'accessing' }
TTQPredicate >> mapParam [

	^ mapParam
]

{ #category : 'accessing' }
TTQPredicate >> mapParam: anObject [

	mapParam := anObject
]

{ #category : 'accessing' }
TTQPredicate >> predicateOn [

	^ predicateOn
]

{ #category : 'accessing' }
TTQPredicate >> predicateOn: anObject [

	predicateOn := anObject
]
