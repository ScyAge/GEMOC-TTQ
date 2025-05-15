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

  exemple :

  ```st
  GemocProgramState>>model
	self ensureModel.
	^ model ifNil:[model := programState]
  ```

   ```st
  GemocType>>model
	^ model ifNil: [ model := self ensureModel ]
  ```

Here the code seems to have the same goal. But we need to choose the bottom version, slightly modified, because `self ensureModel` returns nothing and just returns  `self ensureModel` in the block that already affects a value in the model instance variable. By choosing the bottom version, we only reassign model if model is nil, while the top one reassigns model every time the method is called. Plus, the block in the top version is never reached because model always has a value with the call to  `self ensureModel`.
___
```st
GemocType>>build
	GemocProgramStateGenerator new visit: self
```

```st
GemocProgramState>>build
	"self subclassResponsibility "
```

here we must choose the GemocType implementation to be pulled up in the super class, because the subclass of GemocProgramState are define the same way as build in GemocType only one subclass of GemocProgramState keep overriding build
