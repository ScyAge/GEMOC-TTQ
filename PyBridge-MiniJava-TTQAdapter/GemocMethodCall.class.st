Class {
	#name : #GemocMethodCall,
	#superclass : #GemocProgramState,
	#category : #'PyBridge-MiniJava-TTQAdapter'
}

{ #category : #accessing }
GemocMethodCall >> aliasOfObject: aGemocReceiver [

	^ (aGemocReceiver receiver __str__ literalValue splitOn:
		   Character space) last
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
	self flag: '[GEMOC] How do I get the class of the receiver?'.
	^'Object'
]
