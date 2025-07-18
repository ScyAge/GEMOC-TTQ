Class {
	#name : 'JavaAdapterClassGenerator',
	#superclass : 'AbstractJavaClassGenerator',
	#category : 'Gemoc-Java-File-Creator-classContentGenerator',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'classContentGenerator'
}

{ #category : 'building' }
JavaAdapterClassGenerator >> generateClass: aMetaModelElement [

	| generator |
	generator := JavaClass createClassWithName:
		             (self generateTrueClassName: aMetaModelElement)
		             , 'Adapter'.


	self
		generateInstanceVaribleOnClass: generator onElement: aMetaModelElement; 
		generateImportAndPackageOn: generator onElement: aMetaModelElement;
		generateExtenderOnAJavaClassGenerator: generator
		onClass: aMetaModelElement;
		generateConstructorOnClassGen: generator onClass: aMetaModelElement.


	^ generator
]

{ #category : 'as yet unclassified' }
JavaAdapterClassGenerator >> generateConstructorOnClassGen: aGenerator onClass: aClass [

	| listParam name |
	name := self generateTrueClassName: aClass.
	aGenerator addConstructor: (JavaDefaultConstructor new
			 name: (name,'Adapter');
			 body: '').

	listParam := JavaListOfElement new.
	listParam addAnElement:
		(JavaParameter createAParameterWithName: 'wrapped' withType: name).

	aGenerator addConstructor: (JavaConstructor new
			 name: ('{1}Adapter' format: { name });
			 parameters: listParam;
			 body: ('{1} = wrapped;' format: { name asLowercase }))
]

{ #category : 'as yet unclassified' }
JavaAdapterClassGenerator >> generateExtenderOnAJavaClassGenerator: aGenerator onClass: aClass [

	| listParam listParam2  trueClassName |
	aGenerator extender:
		(JavaType createJavaType: 'MetamodelElementAdapter').

	listParam := JavaListOfElement new.
	listParam addAnElement: (JavaParameter
			 createAParameterWithName: 'visitor'
			 withType: (JavaType createJavaType: 'MetamodelElementWrapperReaderVisitor')).
	
	listParam2 := JavaListOfElement new.
	listParam2 addAnElement: (JavaParameter
			 createAParameterWithName: 'element'
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
			 withReturnType: 'Optional<MetamodelElementAdapter>'
			 withParameter: listParam2
			 withBody: ('if(element.getClass() == {1}.class) \{
			return Optional.of(new {1}Adapter(({1}) element)) ;
		\}
		
		return Optional.empty();' format: {trueClassName})
			 withName: 'createAdapterIfInstanceOf')
			
		
]

{ #category : 'as yet unclassified' }
JavaAdapterClassGenerator >> generateImportAndPackageOn: aGenerator onElement: aMetaModelElement [

	aGenerator
		addImport: (JavaType createJavaType:
					 'main.java.gemocServer.metamodelElementWrapper.MetamodelElementAdapter');
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
			'main.java.gemocServer.metamodelElementWrapper.generatedAdapter'
]

{ #category : 'as yet unclassified' }
JavaAdapterClassGenerator >> generateInstanceVaribleOnClass: classGen onElement: aMetaModelElement [
	
	classGen addAttribute: (JavaAttribute
					 createAttributeWithName: ((self generateTrueClassName: aMetaModelElement) asLowercase )
					 withVisibility: 'private'
					 withType: (self generateTrueClassName: aMetaModelElement))
				
]

{ #category : 'as yet unclassified' }
JavaAdapterClassGenerator >> generateTrueClassName: aMetaModelElement [

	^ (aMetaModelElement name withoutPrefix: 'Gemoc') , 'Impl'
]
