Class {
	#name : 'JavaListOfImport',
	#superclass : 'JavaListOfElement',
	#category : 'Gemoc-Java-File-Creator-java-element-represenation',
	#package : 'Gemoc-Java-File-Creator',
	#tag : 'java-element-represenation'
}

{ #category : 'printing' }
JavaListOfImport >> printOn: aStream [

	parameters do: [ :import |
		aStream << 'import '.
		import printOn: aStream.
		aStream << ';'.
		aStream cr ]
]
