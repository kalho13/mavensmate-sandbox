global with sharing class UserManagerController {

    @RemoteAction
    global static String insertUser(String firstName, String lastName, String email, String profile, String role, String sendEmail) {
        try {
            String alias = firstName.substring(0, 2) + lastName.substring(0, 2) + email.substring(0, 2);
            User u = new User(IsActive = true, FirstName = firstName, LastName = lastName, Email = email, Username = email, ProfileId = profile, UserRoleId = role, Alias = alias, DefaultGroupNotificationFrequency = 'D', DigestFrequency = 'D', EmailEncodingKey = 'ISO-8859-1', LanguageLocaleKey = 'en_US', LocaleSidKey = 'en_US', TimeZoneSidKey = 'America/Los_Angeles', UserPermissionsCallCenterAutoLogin = false, UserPermissionsMarketingUser = false, UserPermissionsOfflineUser = false);

            if (sendEmail == 'on') {
                Database.DMLOptions dlo = new Database.DMLOptions();
                dlo.EmailHeader.triggerUserEmail = true;
                u.setOptions(dlo);
            }
            insert u;
        } catch (DmlException e) {
            return e.getDmlMessage(0);
        }
        return 'true';
    }

    @RemoteAction
    global static List < Profile > queryProfile() {
        //Only works for SFDC, enable later for Force.com with a dependent picklists in jquery
        ID salesforceUserLicense = [Select Id from UserLicense where Name = 'Salesforce'
        limit 1].Id;
        String profileQuery = 'Select Id, Name, UserLicenseId From Profile where UserType = \'Standard\' And UserLicenseId = :salesforceUserLicense ORDER BY Name ASC';
        List < Profile > p = Database.query(profileQuery);
        return p;
    }

    @RemoteAction
    global static List < UserRole > queryRole() {
        String roleQuery = 'Select Id, Name From UserRole where PortalType = \'None\' ORDER BY Name ASC';
        List < UserRole > r = Database.query(roleQuery);
        return r;
    }

    @RemoteAction
    global static List < UserLicense > queryUserLicense() {
        String ulQuery = 'Select Id, Name, LicenseDefinitionKey From UserLicense where Name =\'Salesforce\' limit 1';
        List < UserLicense > ul = Database.query(ulQuery);
        return ul;
    }
}