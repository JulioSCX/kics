package Cx

CxPolicy [ result ] {  
  metadata := input.document[i].metadata
  replicasCheck := input.document[i].spec.replicas
  kindCheck := input.document[i].kind
  scaleKindCheck := input.document[_].spec.scaleTargetRef.kind
 
  metadata.name == input.document[_].spec.scaleTargetRef.name
  kindCheck == "Deployment"
  scaleKindCheck == "Deployment"
   
	result := {
                "documentId": 		    input.document[i].id,
                "searchKey": 	        sprintf("metadata.name=%s.spec.replicas", [metadata.name]),
                "issueType":		      "IncorrectValue",
                "keyExpectedValue":   sprintf("metadata.name=%s.spec.replicas doesn't create static replicas", [metadata.name]),
                "keyActualValue": 	  sprintf("metadata.name=%s.spec.replicas creates static replicas", [metadata.name])
              }
}