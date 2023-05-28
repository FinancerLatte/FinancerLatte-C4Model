!constant ORGANIZATION_NAME "Latte"
!constant BUSINESS_UNIT "Financial Support"

workspace {
    model {
        group "${ORGANIZATION_NAME} - ${BUSINESS_UNIT}" {
            //Software Containers
            platform = softwareSystem "Financial advice platform" {
            platformMobile    = container "Platform Mobile" "Provides service to advisers and clients alike"
            platformWebsite   = container "Plaform Website" "Web Interface to access service features"
            platformAPI       = container "Platform API" "API for application interaction"

            //Software Components
            loggingReminder = container "Logging & Reminder"
            profileRegister = container "Profile Registration"
            searchMatch     = container "Search & Match"
            chatVideo       = container "Chat & Video"
            fileUpload      = container "File Upload and Storage"
            billingInfo     = container "Billing Information"
            }
                    
        
        // Container-to-Component Relationship
        loggingReminder -> platformMobile  "To help the user to sign in"
        loggingReminder -> platformWebsite "To help the user to sign in"
        profileRegister -> platformMobile  "For a new account registration"
        profileRegister -> platformWebsite "For a new account registration"
        searchMatch     -> platformMobile  "Used to browse adviser and match with them"
        searchMatch     -> platformWebsite "Used to browse adviser and match with them"
        chatVideo       -> platformMobile  "To make it easy for client and adviser to reunite"
        chatVideo       -> platformWebsite "To make it easy for client and adviser to reunite"
        fileUpload      -> platformAPI     "Client can use this service to send adviser relevant info"
        billingInfo     -> platformAPI     "Storage of billing info"
    }
 }



    views {
        systemContext platform {
            include *
            autoLayout
        }

        container platform {
            include platformMobile platformWebsite platformAPI 
            include loggingReminder profileRegister searchMatch chatVideo fileUpload billingInfo

            autoLayout
        }

        theme default
    }
 }