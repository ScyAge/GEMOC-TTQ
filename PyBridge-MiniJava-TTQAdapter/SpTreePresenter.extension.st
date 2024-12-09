Extension { #name : 'SpTreePresenter' }

{ #category : '*PyBridge-MiniJava-TTQAdapter' }
SpTreePresenter >> selectItem: anObject atIndex: anIndex [

	super selectItem: anObject.
	verticalAlignment desiredVisibleRow:  anIndex
]
