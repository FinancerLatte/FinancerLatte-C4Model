/*
    Financial Advisory | Advisory Support
    Software Platform
*/

!constant ORGANIZATION_NAME "Financial Advisory"
!constant BUSINESS_UNIT "Advisory Support"

workspace {
    model {
        group "${ORGANIZATION_NAME} - ${BUSINESS_UNIT}" {
            // Actors/Roles
            adviser     = person "Adviser"
            client      = person "Client"
            visitor     = person "Visitor"

            // Software Platform
            platform = softwareSystem "Financial advisory platform" {
                // Containers
            }
             // Relationships Section
            adviser     -> platform "Uses"
            client        -> platform "Client"
            visitor     -> platform "Visits"
            

           
        }
    }

    // Views Specification Section
    views {
        // System Context
        systemContext platform {
            include *
            autoLayout
        }
        container platform {
            //Roles included
            include visitor client adviser
            autoLayout
        }
        theme default
    }
}