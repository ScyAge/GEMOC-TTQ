Class {
	#name : 'JavaListOfParameters',
	#superclass : 'Object',
	#instVars : [
		'parameters'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'adding' }
JavaListOfParameters >> addAparameter: aParameter [

parameters add: aParameter 
]

{ #category : 'initialization' }
JavaListOfParameters >> initialize [ 

	parameters := OrderedCollection new.
]

{ #category : 'printing' }
JavaListOfParameters >> printOn: aStream [
	parameters doWithIndex: [ :param :index |
		param printOn: aStream.
		aStream << (self putAComma: index listSize: parameters size )].
]

{ #category : 'as yet unclassified' }
JavaListOfParameters >> putAComma: index listSize: size [

size > index ifTrue: [ ^ ', ' ] ifFalse: [ ^ '' ]
]
