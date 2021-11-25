Class {
	#name : #CSNRModel,
	#superclass : #MRAPI,
	#category : #'Casino-REST-API'
}

{ #category : #api }
CSNRModel class >> attributes: aRequest [

	<REST_API: 'GET' versions: #( 'v1' ) pattern:
	'csn-model/<modelID>/entity/<entityID>/attributes'>
	| entity attributes |
	entity := self retrieveEntity: aRequest.
	attributes := entity entityAttributes collect: [ :att | 
		              { 
			              (#key -> att name).
			              (#value -> att attributeValue) } asDictionary ].

	^ MROutput json value: (TeaResponse ok body: attributes)
]

{ #category : #api }
CSNRModel class >> sourceCode: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'csn-model/<modelID>/entity/<entityID>/source'>
	| entity |
	entity := self retrieveEntity: aRequest.
	^ MROutput json value: (TeaResponse ok body: {('body' -> entity source sourceText). (#file -> entity source sourceAnchor fileName)} asDictionary)
]

{ #category : #api }
CSNRModel class >> subWidget: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'csn-model/<modelID>/entity/<entityID>/subWidgets'>
	| entity |
	entity := self retrieveEntity: aRequest.
	^ MROutput json
		value:
			(TeaResponse ok
				body:
					((entity isKindOf: CSNPage)
						ifTrue: [ entity businessPage ]
						ifFalse: [ entity subWidgets ]))
]

{ #category : #api }
CSNRModel class >> summary: aRequest [
	<REST_API: 'GET' versions: #('v1') pattern: 'csn-model/<modelID>'>
	| model |
	model := self retrieveModel: aRequest.
	^ MROutput json
		value:
			(TeaResponse ok
				body:
					{(#numberOfWidgets -> (model allWithSubTypesOf: CSNWidget) size).
					(#numberOfBusinessEntities
						-> (model allWithSubTypesOf: CSNBuEntity) size).
					(#numberOfServicesEntities
						->
							(model
								allWithSubTypesOfAny:
									{CSNService.
									CSNServiceAPI.
									CSNServiceAPIParameter}) size).
					(#numberOfActions -> (model allWithSubTypesOf: CSNAction) size).
					(#numberOfAttributes
						-> (model allWithSubTypesOf: CSNAttribute) size).
					(#numberOfLayouts -> (model allWithSubTypesOf: CSNLLayout) size)}
						asDictionary)
]
