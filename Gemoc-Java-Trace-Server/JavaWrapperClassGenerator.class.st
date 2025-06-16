"
this class generate java code by using a class as input, JavaWrapperClassGenerator take information from the input classe : class name and all the attrubite and generate a string representing a Java class with all the attribute and stub for them. This class create a wrapper for holding information  from the original class
"
Class {
	#name : 'JavaWrapperClassGenerator',
	#superclass : 'Object',
	#category : 'Gemoc-Java-Trace-Server',
	#package : 'Gemoc-Java-Trace-Server'
}

{ #category : 'translating' }
JavaWrapperClassGenerator >> generateClassBodyOnElement: aMetaModelElement [

	^ String streamContents: [ :str |
		  self
			  generateInstanceVarible: aMetaModelElement onStream: str;
				generateWrappedAttribute: aMetaModelElement onStream: str;
			  generateStub: aMetaModelElement onStream: str;
			  generateImplementedMethodeOnStream: str ;
				generateWrappedAttributeStub: aMetaModelElement onStream:str]
]

{ #category : 'translating' }
JavaWrapperClassGenerator >> generateClassOnElement: aMetaModelElement [

	^ String streamContents: [ :str |
		  self generateImport: aMetaModelElement OnStream: str.
		  self generateTimestampOn: str.
		  str
		  <<
			  ('public class {1}Wrapper implements MetamodelElementWrapper \{
			{2}
			\}' format: {
					   aMetaModelElement name.
					   (self generateClassBodyOnElement: aMetaModelElement) }) ]
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateGetterForAttribute: aString withReturnType: aRType [ 

^ self generatePublicMethodTextWithReturnType: aRType withName: aString withParam: '' withBody: 'return ',aString , ';'
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateImplementedMethodeOnStream: aStream [

	aStream << '@Override
	public String accept(MetamodelElementWrapperReaderVisitor visitor) {
		return visitor.visit(this);
	}'.

	aStream cr
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateImport: aMetaModelElement OnStream: aStream [

	aStream
		<<
			'package main.java.gemocServer.metamodelElementWrapper.generatedWrapper;
import main.java.gemocServer.metamodelElementWrapper.MetamodelElementWrapper;
import main.java.gemocServer.runtimeStepReader.MetamodelElementWrapperReaderVisitor;';
		cr;
		<< ('import org.tetrabox.minijava.model.miniJava.impl.{1};' format:
					 { (self generateTrueClassName: aMetaModelElement) });
		cr.
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateInstanceVarible: aMetaModelElement onStream: aStream [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :var |
			aStream cr.
			aStream << ('private String {1};' format: { var }).
			aStream cr ]
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generatePublicMethodTextWithReturnType: aType withName: aName withParam: param withBody: aBody [

^ '	public {1} {2}({3}) \{
		{4}
	\}' format: { aType . aName . param . aBody }
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateSetterForAttribute: aString withReturnType: aRType withParamType: aPType [

	^ self
		  generatePublicMethodTextWithReturnType: aRType
		  withName: 'set' , aString
		  withParam: aPType , ' value'
		  withBody: aString , ' = value;'
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateStub: aMetaModelElement onStream: aStream [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :var |
			aStream cr.
			aStream << (self generateGetterForAttribute: var withReturnType: 'String').
			aStream cr.
			aStream << (self generateSetterForAttribute: var withReturnType: 'void' withParamType: 'String').
			aStream cr ]
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateTimestampOn: aStream [

	aStream << ('/**#generated with {1} on {2}**/' format: {
			 SystemVersion current imageVersionString.
			 DateAndTime now printString }).
	aStream
		cr;
		cr;
		cr
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateTrueClassName: aMetaModelElement [

	^ (aMetaModelElement name withoutPrefix: 'Gemoc') , 'Impl'
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateWrappedAttribute: aMetaModelElement onStream: aStream [

	| name |
	name := self generateTrueClassName: aMetaModelElement.

	aStream
		cr;
		<< ('private {1} {2};' format: {
						 name.
						 name asLowercase });
		cr
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateWrappedAttributeStub: aMetaModelElement onStream: aStream [

	| name |
	name := self generateTrueClassName: aMetaModelElement.

	aStream << (self
		 generatePublicMethodTextWithReturnType: name
		 withName: 'get' , name
		 withParam: ''
		 withBody: ('return {1};' format: { name asLowercase })).

	aStream cr.

	aStream << (self
		 generatePublicMethodTextWithReturnType: 'void'
		 withName: 'set' , name
		 withParam: name , ' value'
		 withBody: ('{1} = value;' format: { name asLowercase })).

	aStream cr
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> getInstanceVariableFromAMetaModelElement: aMetaModelElement [

	^ aMetaModelElement slots collect: [ :slot | slot name ]
]
