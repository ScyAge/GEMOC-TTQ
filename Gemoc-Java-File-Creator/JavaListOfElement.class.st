"
Class for representing a list of elements separated by a comma.

You can add an element in the list with the method addAnElement.
All the subClasses use the same method only printOn: change.
"
Class {
	#name : 'JavaListOfElement',
	#superclass : 'Object',
	#instVars : [
		'parameters'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'adding' }
JavaListOfElement >> addAnElement: aParameter [

parameters add: aParameter 
]

{ #category : 'initialization' }
JavaListOfElement >> initialize [ 

	parameters := OrderedCollection new.
]

{ #category : 'testing' }
JavaListOfElement >> isEmpty [ 

^ parameters isEmpty.
]

{ #category : 'printing' }
JavaListOfElement >> printOn: aStream [
	parameters doWithIndex: [ :param :index |
		param printOn: aStream.
		aStream << (self putAComma: index listSize: parameters size )].
]

{ #category : 'as yet unclassified' }
JavaListOfElement >> putAComma: index listSize: size [

size > index ifTrue: [ ^ ', ' ] ifFalse: [ ^ '' ]
]
