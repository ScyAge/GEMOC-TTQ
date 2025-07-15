"
class that holds all the information for class code generation

In this class you have different setters and adders that help you to construct your class.


In the adding protocol, there are all the methods that help you add elements to an existing list of elements. You can add as many methods, constructors, imports, interfaces implemented, and attributes.

For the package and the extension, there is a single attribute you can set: 

- For the package you can put just a string.
- for the extension you need to put a JavaType
	
To create the class, there is a class-side method that simplifies the creation 

```language=Pharo
   JavaClass createClassWithName: 'aName'
```
 
"
Class {
	#name : 'JavaClass',
	#superclass : 'Object',
	#instVars : [
		'name',
		'attributes',
		'constructor',
		'methods',
		'implementor',
		'extender',
		'imports',
		'package'
	],
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'as yet unclassified' }
JavaClass class >> createClassWithName: aName [

	^ self new
		  name: aName;
		  yourself
]

{ #category : 'adding' }
JavaClass >> addAttribute: anAttribute [

	attributes add: anAttribute
]

{ #category : 'adding' }
JavaClass >> addConstructor: aJavaConstructor [

	constructor add: aJavaConstructor
]

{ #category : 'adding' }
JavaClass >> addImplementedInterface: typeOfTheInterface [

	implementor addAnElement: typeOfTheInterface
]

{ #category : 'adding' }
JavaClass >> addImport: anImportJavaType [

	imports addAnElement: anImportJavaType
]

{ #category : 'adding' }
JavaClass >> addMethod: aMethod [

	methods add: aMethod
]

{ #category : 'accessing' }
JavaClass >> attributes [

	^ attributes
]

{ #category : 'accessing' }
JavaClass >> attributes: anObject [

	attributes := anObject
]

{ #category : 'accessing' }
JavaClass >> constructor [

	^ constructor
]

{ #category : 'accessing' }
JavaClass >> extender: anObject [

	extender := anObject
]

{ #category : 'accessing' }
JavaClass >> implementor [

	^ implementor
]

{ #category : 'initialization' }
JavaClass >> initialize [

	methods := OrderedCollection new.
	attributes := OrderedCollection new.
	constructor := OrderedCollection new.
	implementor := JavaListOfImplementedInterface new.
	imports := JavaListOfImport new.
]

{ #category : 'accessing' }
JavaClass >> methods [

	^ methods
]

{ #category : 'accessing' }
JavaClass >> methods: anObject [

	methods := anObject
]

{ #category : 'accessing' }
JavaClass >> name [

	^ name
]

{ #category : 'accessing' }
JavaClass >> name: anObject [

	name := anObject
]

{ #category : 'accessing' }
JavaClass >> package: anObject [

	package := anObject
]

{ #category : 'printing' }
JavaClass >> printClassBodyOn: aStream [

	aStream
		<< '{';
		cr;
		cr.
	attributes do: [ :att | att printOn: aStream ].
	constructor do: [:cons | cons printOn: aStream ].
	methods do: [ :met | met printOn: aStream ].
	aStream << '}'
]

{ #category : 'printing' }
JavaClass >> printClassHeaderOn: aStream [

	aStream << ('public class {1} ' format: { name }).
	extender ifNotNil: [
		aStream << 'extends '.
		extender printOn: aStream ].
	
	implementor isEmpty ifFalse: [ implementor printOn: aStream ].
]

{ #category : 'printing' }
JavaClass >> printImportAndPackageDeclaration: aStream [

	package ifNotNil: [
		aStream
			<< ('package {1};' format: { package });
			cr ].
	imports isEmpty ifFalse: [ imports printOn: aStream ].

	aStream cr
]

{ #category : 'printing' }
JavaClass >> printOn: aStream [

	
	self printImportAndPackageDeclaration: aStream.
	
	self printClassHeaderOn: aStream.
	
	self printClassBodyOn: aStream.
]
