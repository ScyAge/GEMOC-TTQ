## setup

BaseLine 
```st
Metacello new	
	baseline: 'GEMOCTTQ';	
	repository: 'github://ScyAge/GEMOC-TTQ';	
	load
```

## issues

### Merging GemocProgramState and GemocType in PyBridge-MiniJava-TTQAdapter :

- issue:
	There is currently an issue where we need to merge two class hierarchies. After an analysis of the code, I found that a lot of code between these two classes was duplicated—methods, attributes, and code itself. But there are methods with the same name but different implementations.

- solution:

  	Firstly, I decided to remove all the duplicated code between these two classes by introducing a new common superclass GemocAbstractModelRepresentation, where I pulled up all the duplicated code, attributes, and methods. This solution helped to find the methods with different implementations between these two classes.


  	Next step : find how i will merge the different implementation.
  	
