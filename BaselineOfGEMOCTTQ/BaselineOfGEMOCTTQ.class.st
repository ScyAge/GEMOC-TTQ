Class {
	#name : 'BaselineOfGEMOCTTQ',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGEMOCTTQ',
	#package : 'BaselineOfGEMOCTTQ'
}

{ #category : 'baselines' }
BaselineOfGEMOCTTQ >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'PyBridge-MiniJava-TTQAdapter'.
		spec
			package: 'Gemoc-MetaModel-Generator'
			with: [ spec requires: #( 'PyBridge-MiniJava-TTQAdapter' ) ].
		spec
			package: 'Gemoc-UI-Trace-loader'
			with: [ spec requires: #( 'PyBridge-MiniJava-TTQAdapter' ) ].
		spec package: 'Gemoc-DynamicTTQCreator-UI' with: [
			spec requires:
				#( 'PyBridge-MiniJava-TTQAdapter' 'Gemoc-UI-Trace-loader' ) ].
		spec package: 'Gemoc-MMEWC' with: [
			spec requires:
				#( 'PyBridge-MiniJava-TTQAdapter' 'Gemoc-Java-File-Creator' ) ].
		spec package: 'Gemoc-Java-File-Creator' with: [
			spec requires:
				#() ].	
		spec package: 'Gemoc-Java-Trace-Server' with: [
			spec requires:
				#() ].
		spec package: 'Gemoc-DynamicTTQCreator-UI-Tests' with: [
			spec requires:
				#(Gemoc-DynamicTTQCreator-UI) ].	 ]
]
