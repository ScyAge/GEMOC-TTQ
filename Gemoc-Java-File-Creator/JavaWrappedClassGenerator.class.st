Class {
	#name : 'JavaWrappedClassGenerator',
	#superclass : 'AbstractJavaClassGenerator',
	#category : 'Gemoc-Java-File-Creator-classContentGenerator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'classContentGenerator'
}

{ #category : 'building' }
JavaWrappedClassGenerator >> generateClass: aMetaModelElement [

	| generator |
	generator := JavaClass createClassWithName:
		             (self generateTrueClassName: aMetaModelElement)
		             , 'Wrapper'.


	self
		generateImportAndPackageOn: generator onElement: aMetaModelElement;
		generateInstanceVaribleOnClass: generator
		onElement: aMetaModelElement;
		generateStubOnClasseGen: generator onElement: aMetaModelElement;
		generateStubForWrappedAttributeOnClasseGen: generator
		onElement: aMetaModelElement;
		generateExtenderOnAJavaClassGenerator: generator
		onClass: aMetaModelElement;
		generateConstructorOnClassGen: generator onClass: aMetaModelElement.


	^ generator
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateConstructorOnClassGen: aGenerator onClass: aClass [

	| listParam name |
	name := self generateTrueClassName: aClass.
	aGenerator addConstructor: (JavaDefaultConstructor new
			 name: (name,'Wrapper');
			 body: '').

	listParam := JavaListOfElement new.
	listParam addAnElement:
		(JavaParameter createAParameterWithName: 'wrapped' withType: name).

	aGenerator addConstructor: (JavaConstructor new
			 name: ('{1}Wrapper' format: { name });
			 parameters: listParam;
			 body: ('{1} = wrapped;' format: { name asLowercase }))
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateExtenderOnAJavaClassGenerator: aGenerator onClass: aClass [

	| listParam listParam2  trueClassName |
	aGenerator extender:
		(JavaType createJavaType: 'MetamodelElementWrapper').

	listParam := JavaListOfElement new.
	listParam addAnElement: (JavaParameter
			 createAParameterWithName: 'visitor'
			 withType: (JavaType createJavaType: 'MetamodelElementWrapperReaderVisitor')).
	
	listParam2 := JavaListOfElement new.
	listParam2 addAnElement: (JavaParameter
			 createAParameterWithName: 'car'
			 withType: (JavaType createJavaType: 'Object')).
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'String'
			 withParameter: listParam
			 withBody: 'return visitor.visit(this);'
			 withName: 'accept').
			
	trueClassName := self generateTrueClassName: aClass.
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'Optional<MetamodelElementWrapper>'
			 withParameter: listParam2
			 withBody: ('if(car.getClass() == {1}.class) \{
			return Optional.of(new {1}Wrapper(({1}) car)) ;
		\}
		
		return Optional.empty();' format: {trueClassName})
			 withName: 'test')
			
		
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateGetterForInstanceVarible: name [

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'String'
		  withParameter: JavaListOfElement new
		  withBody: ('return {1}Generated;' format: { name })
		  withName: ('get{1}' format: { name })
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateImplementorOnAJavaClassGenerator: aGenerator [

	| listParam |
	aGenerator addImplementedInterface:
		(JavaType createJavaType: 'MetamodelElementWrapper').

	listParam := JavaListOfElement new.
	listParam addAnElement: (JavaParameter
			 createAParameterWithName: 'visitor'
			 withType: (JavaType createJavaType: 'MetamodelElementWrapperReaderVisitor')).
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'String'
			 withParameter: listParam
			 withBody: 'return visitor.visit(this);'
			 withName: 'accept')
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateImplementorOnAJavaClassGenerator: aGenerator onClass: aClass [

	| listParam listParam2  trueClassName |
	aGenerator addImplementedInterface:
		(JavaType createJavaType: 'MetamodelElementWrapper').

	listParam := JavaListOfElement new.
	listParam addAnElement: (JavaParameter
			 createAParameterWithName: 'visitor'
			 withType: (JavaType createJavaType: 'MetamodelElementWrapperReaderVisitor')).
	
	listParam2 := JavaListOfElement new.
	listParam2 addAnElement: (JavaParameter
			 createAParameterWithName: 'car'
			 withType: (JavaType createJavaType: 'EObject')).
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'String'
			 withParameter: listParam
			 withBody: 'return visitor.visit(this);'
			 withName: 'accept').
			
	trueClassName := self generateTrueClassName: aClass.
	
	aGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'Optional<MetamodelElementWrapper>'
			 withParameter: listParam2
			 withBody: ('if(car instanceof {1}) \{
			return Optional.of(new {1}Wrapper(({1}) car)) ;
		\}
		
		return Optional.empty();' format: {trueClassName})
			 withName: 'test')
			
		
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateImportAndPackageOn: aGenerator onElement: aMetaModelElement [

	aGenerator
		addImport: (JavaType createJavaType:
					 'main.java.gemocServer.metamodelElementWrapper.MetamodelElementWrapper');
		addImport: (JavaType createJavaType:
					 'main.java.gemocServer.runtimeStepReader.MetamodelElementWrapperReaderVisitor');
		addImport: (JavaType createJavaType:
					 ('org.tetrabox.minijava.model.miniJava.impl.{1}' format:
							  { (self generateTrueClassName: aMetaModelElement) }));
		addImport: (JavaType createJavaType:
					 ('java.util.Optional' ));
		addImport: (JavaType createJavaType:
					 ('org.eclipse.emf.ecore.EObject' ));
						
		package:
			'main.java.gemocServer.metamodelElementWrapper.generatedWrapper'
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateInstanceVaribleOnClass: classGen onElement: aMetaModelElement [

	(self getInstanceVariableFromAMetaModelElement: aMetaModelElement)
		do: [ :att |
			classGen addAttribute: (JavaAttribute
					 createAttributeWithName: (att, 'Generated')
					 withVisibility: 'private'
					 withType: 'String') ].
	
	classGen addAttribute: (JavaAttribute
					 createAttributeWithName: ((self generateTrueClassName: aMetaModelElement) asLowercase )
					 withVisibility: 'private'
					 withType: (self generateTrueClassName: aMetaModelElement))
				
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateSetterForInstanceVarible: name [

| listParam |

listParam := JavaListOfElement new.

listParam addAnElement: (JavaParameter createAParameterWithName: 'value' withType: 'String' ).

	^ JavaMethod
		  createAjavaMethodWithVisibility: 'public'
		  withReturnType: 'void'
		  withParameter: listParam
		  withBody: ('{1}Generated = value;' format: { name })
		  withName: ('set{1}' format: { name })
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateStubForWrappedAttributeOnClasseGen: classGenerator onElement: aMetaModelElement [

	| listParam name |
	name := self generateTrueClassName: aMetaModelElement.

	listParam := JavaListOfElement new.
	listParam addAnElement:
		(JavaParameter createAParameterWithName: 'value' withType: name).

	classGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: 'void'
			 withParameter: listParam
			 withBody: ('{1} = value;' format: { name asLowercase })
			 withName: ('set{1}' format: { name })).



	classGenerator addMethod: (JavaMethod
			 createAjavaMethodWithVisibility: 'public'
			 withReturnType: name
			 withParameter: JavaListOfElement new
			 withBody: ('return {1};' format: { name asLowercase })
			 withName: ('get{1}' format: { name }))
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateStubOnClasseGen: classGenerator onElement: aMetaModelElement [

(self getInstanceVariableFromAMetaModelElement: aMetaModelElement) do: [ :el |
	classGenerator addMethod: (self generateGetterForInstanceVarible: el).
	classGenerator addMethod: (self generateSetterForInstanceVarible: el).
	 ].


]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> generateTrueClassName: aMetaModelElement [

	^ (aMetaModelElement name withoutPrefix: 'Gemoc') , 'Impl'
]

{ #category : 'as yet unclassified' }
JavaWrappedClassGenerator >> getInstanceVariableFromAMetaModelElement: aMetaModelElement [

	^ aMetaModelElement slots collect: [ :slot | slot name ]
]
