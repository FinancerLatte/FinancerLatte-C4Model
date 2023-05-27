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
            user        = person "User"
            visitor     = person "Visitor"
        }
    }

        // Views Specification Section
    views {
        // System Context
        systemContext platform {
            include *
            autoLayout
        }

        // Container Diagram
        container platform {
            // Roles included
            include adviser user visitor

            // Containers included
            include adviserApp userApp mobile webApp webAPI landingPage

            autoLayout
        }

        theme default
    }
}