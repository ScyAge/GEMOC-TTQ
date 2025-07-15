"
class representing a Java parameter with the type and the name of the parameter 

the method createAParameterWithName: aName withType: (JavaType) can be helpful the create to create one easily
"
Class {
	#name : 'JavaParameter',
	#superclass : 'Object',
	#instVars : [
		'type',
		'name'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaParameter class >> createAParameterWithName: aName withType: aType [

	^ self new
		  name: aName;
		  type: aType;
		  yourself
]

{ #category : 'accessing' }
JavaParameter >> name [

	^ name
]

{ #category : 'accessing' }
JavaParameter >> name: anObject [

	name := anObject
]

{ #category : 'printing' }
JavaParameter >> printOn: aStream [

aStream << ('{1} {2}' format: { type . name })
]

{ #category : 'accessing' }
JavaParameter >> type [

	^ type
]

{ #category : 'accessing' }
JavaParameter >> type: anObject [

	type := anObject
]
