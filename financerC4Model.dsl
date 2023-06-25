workspace "FinancerLatte" {

    model {
        //-Actors
        visitor = person "Visitor"
        business = person "Business Owner"
        adviser = person "Adviser"
        
        //Financer Platform (All Bounded Context Elements go here)
        financerPlatform = softwareSystem "Financer" "A financial advisory platform." {
            // "Variables-Containers"
                //Elementos
                landing = container "Landing Page" {
                    tags "Page"
                }
                mobileApp = container "Mobile App" "Provides advisory functionality to clients via mobile device." "Xamarin" {
                    tags "Mobile"
                }
                API = container "REST API"
                
                //Databases
                databaseAD = container "Adviser Database" "Stores adviser information, speciality, etc." "SQL" {
                    tags "DataBase"
                }
                databaseRD = container "Review Database" "Stores review information from advisers" "SQL" {
                    tags "DataBase"
                }
                databaseSD = container "Situation Database" "Stores the situation of the client/business owner" "SQL" {
                    tags "DataBase"
                }
                databaseAM = container "Database Service AWS" {
                    tags "DataBase"
                }
                
            // "Variables-Bounded Context Search & Match"
                searchAPI = container "Search & Match" {
                    suggest = component "Suggest Adviser Controller" "Allows user to search for an adviser according to the situation" "Nest.js"
                    manual = component "Manual Search Controller" "Allows user to search for an adviser by name" "Nest.js"
                    search = component "Search Repository" "Searchs in the database for a specific adviser according to information received" "Nest.js"
                }
                
            // "Variables-Bounded Context Subscription Management"
                subscriptionManagement = container "Subscription Management" "Manages user subscriptions." {
                    userManager = component "User Manager" "Manages user information." "Language"
                    subscriptionManager = component "Subscription Manager" "Manages user subscriptions." "Language"
                    planManager = component "Plan Manager Repository" "Manages the available subscription plans." "Language"
                }
                billingSystem = container "Billing System" "Handles user payments." "Language" {
                    tags "Billing"
                }
                
            // "Variables-Bounded Context Feedback Review" 
                reviewAPI = container "Feedback Review" {
                    reviewC = component "Review Controller" "Delivers and recieves tasks to the right components"
                    reviewV = component "View" "Shows information to the user"
                    review = component "Review Component" "Main component, contains attributes and methods of review"
                    repositoryReview = component "Respository Review" "Stores reviews"            
                }
                
                
            // "Variables-Bounded Context Session Scheduling" 
                sessionPlan = container "Session Scheduling" {
                    planner = component "Schedule Controller" "Desc" "Type"
                    meeting = component "Meeting Service" "Desc" "Type"
                    videocall = component "Videocall Component" "Desc" "Type"
                    notifSessionS = component "Session Notification Service" "Desc" "Type"
                    notifSessionC = component "Session Notification Component" "Desc" "Type"
                }
            
            //"Variables-Bounded Context Account Management"
                accountManager = container "Account Management" {
                    account = component "Account Management"
                    user = component "Profile Editor Manager"
                    terminate = component "Terminate Account Controller"
                }
            //"Variables-Bounded Context Situation Summary"
                situationSummary = container "Situation Summary" {
                    view = component "View" "Shows information to the user"
                    situationController = component "Situation Manager" "Manages user situations." "add/modify situation"
                    situationRepository = component "User situation Repository" "Manages adding and modifying user situations." 
                }
            //"Variables-Bounded Context End Service"
                endservice = container "End Service" {
                    end = component "End Service Manager" "Desc"
                    finRev = component "Final Review Controller" "Desc"
                    saveSituation = component "Finished Situation Controller" "Desc"
                    finRevRepo = component "Final Review Repository" "Desc"
                    saveSitRepo = component "Finished Situation Repository" "Desc"
                }
        }
        
        //External Systems
        stripe = softwareSystem "Stripe"
        zoom = softwareSystem "Zoom"
        mailmonkey = softwareSystem "MailMonkey"
        notif = softwareSystem "FireBase Cloud Managing Notifications"
        
        //Relations
        group "Relations-Containers" {
            visitor -> landing "visits"
            business -> mobileApp "uses"
            adviser -> mobileApp "uses"
            mobileApp -> API "API Request"
            
            API -> searchAPI
            API -> subscriptionManagement
            API -> reviewAPI
            API -> sessionPlan
            
        }
        group "Relations-Bounded Context Search & Match" {
            mobileApp -> suggest "API call to"
            mobileApp -> manual "API call to"
            //Uses in platform
            suggest -> search "uses"
            manual -> search "uses"
            //External
            search -> databaseAD "fetch adviser information from"
        }
        group "Relations-Bounded Context Subscription Management" {
            mobileApp -> userManager "Sends user data"
            userManager -> subscriptionManager "Requests subscription creation/modification"
            subscriptionManager -> userManager "Gets user data"
            planManager -> subscriptionManager "Provides plan data"
            subscriptionManager -> planManager "Gets plan data"
            subscriptionManagement -> billingSystem "Interacts with"
            planManager -> stripe "uses"
        }
        group "Relations-Bounded Context Feedback Review" {
            //Linking to api call
            mobileApp -> reviewC "API call to"
            //Inside platform
            reviewC -> reviewV "Controls what to show"
            reviewC -> review "Passes task to"
            reviewC -> repositoryReview "Sends the new review to"
            reviewV -> reviewC "Show"
            reviewV -> review "Shows info from"
            //Relations To Database
            repositoryReview -> databaseRD "Saves information of reviews"
        }
        group "Relations-Bounded Context Session Scheduling" {
            mobileApp -> planner "API call to"
            planner -> meeting "uses"
            meeting -> databaseSD "fetch customer's situation file"
            meeting -> videocall "starts a call"
            videocall -> zoom "uses"
            planner -> notifSessionS "uses"
            notifSessionS -> notifSessionC "sends notification information"
            notifSessionC -> mailmonkey "uses"
        }
        group "Relations-Bounded Context Account Management" {
            mobileApp -> account "API calls to"
            mobileApp -> user "API calls to"
            user -> databaseAM "reads and sends info to"
            account -> terminate "uses"
            user -> terminate "uses"
        }
        group "Relations-Bounded Context Situation Management" {
            mobileApp -> situationController "API call to"
            situationController -> view "Requesting to display forms"
            view -> situationController "Shows forms"
            situationController -> situationRepository "Send user add/modify information"
            situationRepository -> databaseSD "Saves changes in user situation"
        }
        group "Relations-Bounded Context End Service" {
            mobileApp -> end "API call"
            end -> finRev "send review"
            end -> saveSituation "send situation"
            finRev -> finRevRepo "uses"
            finRevRepo -> databaseAD "saves"
            saveSituation -> saveSitRepo "uses"
            saveSitRepo -> databaseSD "saves"
        }
    }
    
    
    views {
        //Visualizar el System Context
        systemContext financerPlatform {
            include *
            autoLayout tb
        }
        //Visualizar los contenedores
        container financerPlatform {
            include *
            autoLayout tb
        }
        //Visualizar el componente Search & Match
        component searchAPI {
            include *
            autoLayout tb
        }
        //Visualizar el componente Subscription Management
        component subscriptionManagement {
            include *
            autoLayout tb
        }
        //Visualizar el componente Feedback Review
        component reviewAPI {
            include *
            autoLayout tb
        }
        //Visualizar el componente Session Schedule
        component sessionPlan {
            include *
            autoLayout tb
        }
        //Visualizar el componente Account Management
        component accountManager {
            include *
            autoLayout tb
        }
        //Visualizar el componente Situation Summary
        component situationSummary {
            include *
            autoLayout tb
        }
        //Visualizar el componente End Service
        component endservice {
            include *
            autoLayout tb
        }
        
        styles {
            element "DataBase" {
                shape Cylinder
            }
            element "Mobile" {
                shape MobileDevicePortrait
            }
            element "Billing" {
                shape Cylinder
            }
            element "Page" {
                shape WebBrowser
            }
        }
        
        theme default
    }
}