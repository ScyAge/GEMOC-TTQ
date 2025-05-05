Class {
	#name : 'BaselineOfGEMOCTTQ',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGEMOCTTQ',
	#package : 'BaselineOfGEMOCTTQ'
}

{ #category : 'baselines' }
BaselineOfGEMOCTTQ >> baseline: spec [
	<baseline>
	spec
		for: #common
		do:  [ spec package: 'PyBridge-MiniJava-TTQAdapter'.  
				spec package: 'Gemoc-MetaModel-Generator' with: [spec requires: #('PyBridge-MiniJava-TTQAdapter')].
			 ].
]
