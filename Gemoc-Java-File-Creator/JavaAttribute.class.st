"
class to create an attribute in a class you cant specify the visibility the name and the type of the attribute

the method createAttributeWithName: aName withVisibility: aString withType: JavaType help you to create an instance
"
Class {
	#name : 'JavaAttribute',
	#superclass : 'Object',
	#instVars : [
		'visibility',
		'type',
		'name'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaAttribute class >> createAttributeWithName: aName withVisibility: vis withType: aType [

	^ self new
		  visibility: vis;
		  name: aName;
		  type: aType;
		  yourself
]

{ #category : 'accessing' }
JavaAttribute >> name [

	^ name
]

{ #category : 'accessing' }
JavaAttribute >> name: anObject [

	name := anObject
]

{ #category : 'printing' }
JavaAttribute >> printOn: aStream [

	aStream << ('	{1} {2} {3};' format: {
			 visibility.
			 type.
			 name }).

	aStream
		cr;
		cr
]

{ #category : 'accessing' }
JavaAttribute >> type [

	^ type
]

{ #category : 'accessing' }
JavaAttribute >> type: anObject [

	type := anObject
]

{ #category : 'accessing' }
JavaAttribute >> visibility [

	^ visibility
]

{ #category : 'accessing' }
JavaAttribute >> visibility: anObject [

	visibility := anObject
]
