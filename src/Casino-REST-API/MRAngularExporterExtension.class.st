Class {
	#name : #MRAngularExporterExtension,
	#superclass : #MRExtension,
	#category : #'Casino-REST-API'
}

{ #category : #accessing }
MRAngularExporterExtension >> canReceiveEntity: anObject [

	^ anObject isNotNil and: [ 
		(anObject isKindOf: CSNWidget) and: [ 
		  (anObject isKindOf: CSNBusinessPage) not and: [ 
			  (anObject isKindOf: CSNPage) not ] ] ]
]

{ #category : #accessing }
MRAngularExporterExtension >> followEntity: anEntity [

	"Return the data that will be displayed for the followed entity"

	| config attributeExporter |
	config := CSNExporterAngularMaterialConfiguration.
	attributeExporter := CSNExporterAngularAttribute.
	^ String streamContents: [ :s | 
		  (CSNModelExporterAngular on: s)
			  currentPage: (anEntity atAnyScope: { 
							   CSNPage.
							   CSNBusinessPage }) anyOne;
			  attributeExporter: attributeExporter new;
			  exporterAngularConfiguration: config new;
			  visit: anEntity ]
]

{ #category : #accessing }
MRAngularExporterExtension >> title [
	^ 'Angular Viewer'
]
