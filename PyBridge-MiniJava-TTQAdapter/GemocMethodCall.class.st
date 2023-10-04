Class {
	#name : #GemocMethodCall,
	#superclass : #GemocProgramState,
	#instVars : [
		'rootFrame',
		'receiver'
	],
	#category : #'PyBridge-MiniJava-TTQAdapter'
}

{ #category : #accessing }
GemocMethodCall >> aliasOfObject: aGemocReceiver [

	^ (aGemocReceiver receiver __str__ literalValue splitOn:
		   Character space) last
]

{ #category : #building }
GemocMethodCall >> build [
	self buildRootFrame.
	self buildReceiver 
]

{ #category : #building }
GemocMethodCall >> buildReceiver [

	receiver := GemocReceiver new receiver: programState receiver.
	executionStep step subSteps asNativeList first sourceState runtimeExtensions asNativeList first runtimeBindings asNativeList first runtimeValue runtimeObject "-> root frame -> childFrame -> trouver le method call"
]

{ #category : #accessing }
GemocMethodCall >> buildRootFrame [

	rootFrame := executionStep step sourceState runtimeExtensions
		             asNativeList first runtimeBindings asNativeList first
		             runtimeValue runtimeObject rootFrame
]

{ #category : #accessing }
GemocMethodCall >> bytecodeIndex [
	^executionStep step number literalValue
]

{ #category : #testing }
GemocMethodCall >> isMessageSend [
	^true
]

{ #category : #accessing }
GemocMethodCall >> messageArguments [
	self flag: '[GEMOC] How do I get method call arguments?'.
	^#()
]

{ #category : #accessing }
GemocMethodCall >> messageReceiver [
	^self receiver 
]

{ #category : #accessing }
GemocMethodCall >> messageSelector [
	^self methodSelector
]

{ #category : #accessing }
GemocMethodCall >> methodSelector [
	^programState method value name literalValue
]

{ #category : #accessing }
GemocMethodCall >> receiver [
	^GemocReceiver new receiver: programState receiver
]

{ #category : #accessing }
GemocMethodCall >> receiverClass [

	^ receiver receiverClass
]
