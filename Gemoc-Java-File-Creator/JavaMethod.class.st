Class {
	#name : 'JavaMethod',
	#superclass : 'Object',
	#instVars : [
		'visibility',
		'returnType',
		'name',
		'parameter',
		'body'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaMethod class >> createAjavaMethodWithVisibility: vis withReturnType: rType withParameter: lParametetr withBody: aBody withName: aName [

	^ self new
		  name: aName;
		  body: aBody;
		  visibility: vis;
		  parameter: lParametetr;
		  returnType: rType;
		  yourself
]

{ #category : 'accessing' }
JavaMethod >> body [

	^ body
]

{ #category : 'accessing' }
JavaMethod >> body: anObject [

	body := anObject
]

{ #category : 'initialization' }
JavaMethod >> initialize [ 

parameter := JavaListOfElement new.
]

{ #category : 'accessing' }
JavaMethod >> name [

	^ name
]

{ #category : 'accessing' }
JavaMethod >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
JavaMethod >> parameter [

	^ parameter
]

{ #category : 'accessing' }
JavaMethod >> parameter: anObject [

	parameter := anObject
]

{ #category : 'printing' }
JavaMethod >> printOn: aStream [

	aStream << ('{1} {2} {3}(' format: {
			 visibility.
			 returnType.
			 name }).

	parameter printOn: aStream.

	aStream << (')\{
{1}
\}' format: { body }).

	aStream
		cr;
		cr
]

{ #category : 'accessing' }
JavaMethod >> returnType [

	^ returnType
]

{ #category : 'accessing' }
JavaMethod >> returnType: anObject [

	returnType := anObject
]

{ #category : 'accessing' }
JavaMethod >> visibility [

	^ visibility
]

{ #category : 'accessing' }
JavaMethod >> visibility: anObject [

	visibility := anObject
]
