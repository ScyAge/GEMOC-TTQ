Class {
	#name : 'BaselineOfGEMOCTTQ',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGEMOC-TTQ',
	#package : 'BaselineOfGEMOC-TTQ'
}

{ #category : 'baselines' }
BaselineOfGEMOCTTQ >> baseline: spec [
	<baseline>
	spec
		for: #common
		do:  [ spec package: 'PyBridge-MiniJava-TTQAdapter'.  
			spec package: 'Gemoc-MetaModel-Generator'.
			 ].
]
