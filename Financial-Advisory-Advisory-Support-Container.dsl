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
            customer        = person "Customer"
            visitor     = person "Visitor"

            // Software Platform
            platform = softwareSystem "Financial advisory platform" {
                // Containers

                mobile        = container "Platform Mobile" "Access to features via mobile device" "Flutter"
                webApp        = container "Platform Website" "Web interface for accessing features" "VueJs"
                webAPI        = container "Platform API" "API for application interaction" "NestJs"
                landingPage   = container "Landing Page" "Home page for visitors" "Bootstrap"
                dataBase = container "Database" "Stores data" "PostgreSQL"
            }
             // Relationships Section
            adviser     -> platform "Uses"
            user        -> platform "Uses"
            visitor     -> platform "Visits"

            // Container-to-Container Relationships
            landingPage -> webApp
            webApp      -> webAPI
            mobile      -> webAPI
            webAPI      -> dataBase

            // Actor-to-Container Relationships
            adviser     -> webApp        "Uses"
            adviser     -> mobile        "Uses"
            customer    -> webApp        "Uses"
            customer    -> mobile        "Uses"
            visitor     -> landingPage   "Visits"

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
            include adviser customer visitor

            // Containers included
            include   mobile webApp webAPI landingPage dataBase

            autoLayout
        }

        theme default
    }
}