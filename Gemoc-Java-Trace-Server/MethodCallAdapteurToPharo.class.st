Class {
	#name : 'MethodCallAdapteurToPharo',
	#superclass : 'Object',
	#instVars : [
		'dictionnary'
	],
	#category : 'Gemoc-Java-Trace-Server-objectAdapter',
	#package : 'Gemoc-Java-Trace-Server',
	#tag : 'objectAdapter'
}

{ #category : 'as yet unclassified' }
MethodCallAdapteurToPharo class >> createAdapterWithDictionary: aDictionary [

	^ self new dictionnary: aDictionary
]

{ #category : 'accessing' }
MethodCallAdapteurToPharo >> dictionnary [

	^ dictionnary
]

{ #category : 'accessing' }
MethodCallAdapteurToPharo >> dictionnary: anObject [

	dictionnary := anObject
]

{ #category : 'testing' }
MethodCallAdapteurToPharo >> isMessageSend [

 ^ (dictionnary at: 'programStateType') = ('methodCall')
]

{ #category : 'accessing' }
MethodCallAdapteurToPharo >> messageSelector [

	^ (dictionnary at: 'messageSelector') asSymbol
]

{ #category : 'accessing' }
MethodCallAdapteurToPharo >> pc [ 

	^ (dictionnary at: 'stepNumber') asNumber.
]
