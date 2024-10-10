Trait {
	#name : 'TGemocAssignee',
	#category : 'PyBridge-MiniJava-TTQAdapter-model',
	#package : 'PyBridge-MiniJava-TTQAdapter',
	#tag : 'model'
}

{ #category : 'as yet unclassified' }
TGemocAssignee >> assigneeClass [
	^Smalltalk at: #TGemocAssignee ifAbsent: [ nil ] 
]
