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
			  generateStub: aMetaModelElement onStream: str;
			  generateImplementedMethodeOnStream: str ]
]

{ #category : 'translating' }
JavaWrapperClassGenerator >> generateClassOnElement: aMetaModelElement [

	^ String streamContents: [ :str |
		  self generateImportOnStream: str.
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
JavaWrapperClassGenerator >> generateGetterForAttribute: aString [

^ 'public String get{1}() \{
		return {1};
	\}' format: { aString }
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
JavaWrapperClassGenerator >> generateImportOnStream: aStream [

	aStream
	<<
		'package main.java.gemocServer.metamodelElementWrapper.generatedWrapper;
import main.java.gemocServer.metamodelElementWrapper.MetamodelElementWrapper;
import main.java.gemocServer.runtimeStepReader.MetamodelElementWrapperReaderVisitor;'.

aStream cr.
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
JavaWrapperClassGenerator >> generateSetterForAttribute: aString [

^ 'public void set{1}(String value) \{
		 {1} = value;
	\}' format: { aString }
]

{ #category : 'as yet unclassified' }
JavaWrapperClassGenerator >> generateStub: aMetaModelElement onStream: aStream [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :var |
			aStream cr.
			aStream << (self generateGetterForAttribute: var).
			aStream cr.
			aStream << (self generateSetterForAttribute: var).
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
JavaWrapperClassGenerator >> getInstanceVariableFromAMetaModelElement: aMetaModelElement [

	^ aMetaModelElement slots collect: [ :slot | slot name ]
]
