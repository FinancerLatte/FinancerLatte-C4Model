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

            // Software Platform
            platform = softwareSystem "Financial advisory platform" {
                // Containers
                adviserApp    = container "Adviser App" "Provides services in advisory processes" "NestJs"
                userApp       = container "User App" "Allows user to receive financial advice" "NestJs"
                mobile        = container "Platform Mobile" "Access to features via mobile device" "Flutter"
                webApp        = container "Platform Website" "Web interface for accessing features" "VueJs"
                webAPI        = container "Platform API" "API for application interaction" "NestJs"
                landingPage   = container "Landing Page" "Home page for visitors" "Bootstrap"
            }
             // Relationships Section
            adviser     -> platform "Uses"
            user        -> platform "Uses"
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

        

        theme default
    }
}