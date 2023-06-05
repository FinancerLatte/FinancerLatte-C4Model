/*
    Financial Advisory | Advisory Support
    Software Platform
*/
!constant ORGANIZATION_NAME "Latte"
!constant BUSINESS_UNIT "Financial Support"

workspace {
    model {
    group "${ORGANIZATION_NAME} - ${BUSINESS_UNIT}"{
        softwaresystem = softwareSystem "Software System" {
        webApp = container "API Application" {
            profile = component "Profile Registration"
            billing = component "Billing Information"
            security = component "Security"
            login = component "Login & Sign In"
            chat = component "Chat & Video"
            files = component "File Upload and Storage"

        }
        mobile = container "Platform Mobile"
        website = container "Platform Website"
        database = container "Database"
        payments = container "External Payment Service"
        mobile -> profile "API call"
        mobile -> billing "API call"
        website -> profile "API call"
        website -> billing "API call"
        profile -> login "Uses"
        billing -> security "Uses"
        login -> database "Uses"
        billing -> payments "Uses"
        mobile -> chat "API call"
        website -> chat "API call"
        chat -> files "Uses"


}
}
}
        views {
        component webApp {
            include *
            autoLayout lr
        }
        theme default

    }

    }
