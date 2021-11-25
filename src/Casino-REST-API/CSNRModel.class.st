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
