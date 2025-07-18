"
this class is for generating constructors for a Java class

you can use the class side method createConstructorWithName:withParameter:withBody:

```language=Pharo
   JavaConstructor createConstructorWithName: the class name
	withParameter: JavaListOfElement
	withBody: aString
```

after the creation you can add it to the class
"
Class {
	#name : 'JavaConstructor',
	#superclass : 'Object',
	#instVars : [
		'name',
		'parameters',
		'body'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaConstructor class >> createConstructorWithName: className withParameter: listOfParameter withBody: aString [

	^ self new
		  name: className;
		  parameters: listOfParameter;
		  body: aString;
		  yourself
]

{ #category : 'accessing' }
JavaConstructor >> body [

	^ body
]

{ #category : 'accessing' }
JavaConstructor >> body: anObject [

	body := anObject
]

{ #category : 'initialization' }
JavaConstructor >> initialize [ 

parameters := JavaListOfElement new.
]

{ #category : 'accessing' }
JavaConstructor >> name [

	^ name
]

{ #category : 'accessing' }
JavaConstructor >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
JavaConstructor >> parameters [

	^ parameters
]

{ #category : 'accessing' }
JavaConstructor >> parameters: anObject [

	parameters := anObject
]

{ #category : 'printing' }
JavaConstructor >> printOn: aStream [

	aStream << ('	public {1}(' format: { name }).

	self printParameterOn: aStream.

	aStream << (')\{
		{1}
	\}' format: { body }).

	aStream
		cr;
		cr
]

{ #category : 'printing' }
JavaConstructor >> printParameterOn: aStream [

	parameters printOn: aStream
]
