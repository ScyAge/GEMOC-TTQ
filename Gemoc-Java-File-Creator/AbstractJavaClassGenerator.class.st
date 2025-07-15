"
Abstraction for java class generation, the generation is done by the class in the tag java-element-representation. Those classes are used to format how you want your class to be generated with these elements.

- import 
- package 
- extension 
- implementation (one or many)
- class field (static field not handled)
- constructor
- method
- list of parameters

you can put those elements in the class that hold and handle the generation JavaClass
"
Class {
	#name : 'AbstractJavaClassGenerator',
	#superclass : 'Object',
	#category : 'Gemoc-Java-File-Creator-classContentGenerator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'classContentGenerator'
}

{ #category : 'testing' }
AbstractJavaClassGenerator class >> isAbstract [

	^ self == AbstractJavaClassGenerator
]

{ #category : 'building' }
AbstractJavaClassGenerator >> generateClass: aMetaModelElement [

	self subclassResponsibility.
]
