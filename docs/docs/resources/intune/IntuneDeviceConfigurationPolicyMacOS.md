﻿# IntuneDeviceConfigurationPolicyMacOS

## Parameters

| Parameter | Attribute | DataType | Description | Allowed Values |
| --- | --- | --- | --- | --- |
| **dataType** | Write | String | The type of the target assignment. |#microsoft.graph.groupAssignmentTarget, #microsoft.graph.allLicensedUsersAssignmentTarget, #microsoft.graph.allDevicesAssignmentTarget, #microsoft.graph.exclusionGroupAssignmentTarget, #microsoft.graph.configurationManagerCollectionAssignmentTarget|
| **deviceAndAppManagementAssignmentFilterType** | Write | String | The type of filter of the target assignment i.e. Exclude or Include. Possible values are:none, include, exclude. |none, include, exclude|
| **deviceAndAppManagementAssignmentFilterId** | Write | String | The Id of the filter for the target assignment. ||
| **groupId** | Write | String | The group Id that is the target of the assignment. ||
| **collectionId** | Write | String | The collection Id that is the target of the assignment.(ConfigMgr) ||
| **odataType** | Write | String |  |#microsoft.graph.appleAppListItem|
| **appId** | Write | String |  ||
| **appStoreUrl** | Write | String |  ||
| **name** | Write | String |  ||
| **publisher** | Write | String |  ||
| **accessibility** | Write | String |  |notConfigured, enabled, disabled|
| **addressBook** | Write | String | Blocks iCloud from syncing contacts. |notConfigured, enabled, disabled|
| **appleEventsAllowedReceivers** | Write | InstanceArray[] |  ||
| **blockCamera** | Write | Boolean |  ||
| **blockListenEvent** | Write | Boolean |  ||
| **blockMicrophone** | Write | Boolean |  ||
| **blockScreenCapture** | Write | Boolean |  ||
| **calendar** | Write | String | Blocks iCloud from syncing calendars. |notConfigured, enabled, disabled|
| **codeRequirement** | Write | String |  ||
| **displayName** | Write | String |  ||
| **fileProviderPresence** | Write | String |  |notConfigured, enabled, disabled|
| **identifier** | Write | String |  ||
| **identifierType** | Write | String |  |bundleID, path|
| **mediaLibrary** | Write | String |  |notConfigured, enabled, disabled|
| **photos** | Write | String |  |notConfigured, enabled, disabled|
| **postEvent** | Write | String |  |notConfigured, enabled, disabled|
| **reminders** | Write | String | Blocks iCloud from syncing reminders. |notConfigured, enabled, disabled|
| **speechRecognition** | Write | String |  |notConfigured, enabled, disabled|
| **staticCodeValidation** | Write | Boolean |  ||
| **systemPolicyAllFiles** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicyDesktopFolder** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicyDocumentsFolder** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicyDownloadsFolder** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicyNetworkVolumes** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicyRemovableVolumes** | Write | String |  |notConfigured, enabled, disabled|
| **systemPolicySystemAdminFiles** | Write | String |  |notConfigured, enabled, disabled|
| **allowed** | Write | Boolean |  ||
| **codeRequirement** | Write | String |  ||
| **identifier** | Write | String |  ||
| **identifierType** | Write | String |  |bundleID, path|
| **Id** | Write | String |  ||
| **Description** | Write | String |  ||
| **DisplayName** | Write | String |  ||
| **AddingGameCenterFriendsBlocked** | Write | Boolean |  ||
| **AirDropBlocked** | Write | Boolean |  ||
| **AppleWatchBlockAutoUnlock** | Write | Boolean | Blocks users from unlocking their Mac with Apple Watch. ||
| **CameraBlocked** | Write | Boolean | Blocks users from taking photographs and videos. ||
| **ClassroomAppBlockRemoteScreenObservation** | Write | Boolean | Blocks AirPlay, screen sharing to other devices, and a Classroom app feature used by teachers to view their students' screens. This setting isn't available if you've blocked screenshots. ||
| **ClassroomAppForceUnpromptedScreenObservation** | Write | Boolean | Unprompted observation means that teachers can view screens without warning students first. This setting isn't available if you've blocked screenshots. ||
| **ClassroomForceAutomaticallyJoinClasses** | Write | Boolean | Students can join a class without prompting the teacher. ||
| **ClassroomForceRequestPermissionToLeaveClasses** | Write | Boolean | Students enrolled in an unmanaged Classroom course must get teacher consent to leave the course. ||
| **ClassroomForceUnpromptedAppAndDeviceLock** | Write | Boolean | Teachers can lock a student's device or app without the student's approval. ||
| **CompliantAppListType** | Write | String | Device compliance can be viewed in the Restricted Apps Compliance report. |none, appsInListCompliant, appsNotInListCompliant|
| **CompliantAppsList** | Write | InstanceArray[] |   ||
| **ContentCachingBlocked** | Write | Boolean |  ||
| **DefinitionLookupBlocked** | Write | Boolean | Block look up, a feature that looks up the definition of a highlighted word. ||
| **EmailInDomainSuffixes** | Write | StringArray[] | Emails that the user sends or receives which don't match the domains you specify here will be marked as untrusted.  ||
| **EraseContentAndSettingsBlocked** | Write | Boolean |  ||
| **GameCenterBlocked** | Write | Boolean |  ||
| **ICloudBlockActivityContinuation** | Write | Boolean | Handoff lets users start work on one MacOS device, and continue it on another MacOS or iOS device. Available for macOS 10.15 and later. ||
| **ICloudBlockAddressBook** | Write | Boolean | Blocks iCloud from syncing contacts. ||
| **ICloudBlockBookmarks** | Write | Boolean | Blocks iCloud from syncing bookmarks. ||
| **ICloudBlockCalendar** | Write | Boolean | Blocks iCloud from syncing calendars. ||
| **ICloudBlockDocumentSync** | Write | Boolean | Blocks iCloud from syncing documents and data. ||
| **ICloudBlockMail** | Write | Boolean | Blocks iCloud from syncing mail. ||
| **ICloudBlockNotes** | Write | Boolean | Blocks iCloud from syncing notes. ||
| **ICloudBlockPhotoLibrary** | Write | Boolean | Any photos not fully downloaded from iCloud Photo Library to device will be removed from local storage. ||
| **ICloudBlockReminders** | Write | Boolean | Blocks iCloud from syncing reminders. ||
| **ICloudDesktopAndDocumentsBlocked** | Write | Boolean |  ||
| **ICloudPrivateRelayBlocked** | Write | Boolean |  ||
| **ITunesBlockFileSharing** | Write | Boolean | Blocks files from being transferred using iTunes. ||
| **ITunesBlockMusicService** | Write | Boolean |  ||
| **KeyboardBlockDictation** | Write | Boolean | Block dictation, which is a feature that converts the user's voice to text. ||
| **KeychainBlockCloudSync** | Write | Boolean | Disables syncing credentials stored in the Keychain to iCloud ||
| **MultiplayerGamingBlocked** | Write | Boolean |  ||
| **PasswordBlockAirDropSharing** | Write | Boolean |  ||
| **PasswordBlockAutoFill** | Write | Boolean |  ||
| **PasswordBlockFingerprintUnlock** | Write | Boolean | Requires user to set a non-biometric passcode or password to unlock the device. ||
| **PasswordBlockModification** | Write | Boolean | Blocks user from changing the set passcode. ||
| **PasswordBlockProximityRequests** | Write | Boolean |  ||
| **PasswordBlockSimple** | Write | Boolean | Block simple password sequences, such as 1234 or 1111. ||
| **PasswordExpirationDays** | Write | UInt32 | Number of days until device password must be changed. (1-65535) ||
| **PasswordMaximumAttemptCount** | Write | UInt32 |  ||
| **PasswordMinimumCharacterSetCount** | Write | UInt32 | Minimum number (0-4) of non-alphanumeric characters, such as #, %, !, etc., required in the password. The default value is 0. ||
| **PasswordMinimumLength** | Write | UInt32 | Minimum number of digits or characters in password (4-16). ||
| **PasswordMinutesOfInactivityBeforeLock** | Write | UInt32 | Set to 0 to require a password immediately. There is no maximum number of minutes, and this number overrides the number currently set on the device. ||
| **PasswordMinutesOfInactivityBeforeScreenTimeout** | Write | UInt32 | Set to 0 to use the device's minimum possible value. This number (0-60 minutes) overrides the number currently set on the device. ||
| **PasswordMinutesUntilFailedLoginReset** | Write | UInt32 |  ||
| **PasswordPreviousPasswordBlockCount** | Write | UInt32 | Number of new passwords that must be used until an old one can be reused. (1-24) ||
| **PasswordRequired** | Write | Boolean |  Specify the type of password required. ||
| **PasswordRequiredType** | Write | String | Specify the type of password required. |deviceDefault, alphanumeric, numeric|
| **PrivacyAccessControls** | Write | InstanceArray[] | Configure an app's access to specific data, folders, and apps on a device. These settings apply to devices running macOS Mojave 10.14 and later. ||
| **SafariBlockAutofill** | Write | Boolean | Blocks Safari from remembering what users enter in web forms. ||
| **ScreenCaptureBlocked** | Write | Boolean |  ||
| **SoftwareUpdateMajorOSDeferredInstallDelayInDays** | Write | UInt32 |  ||
| **SoftwareUpdateMinorOSDeferredInstallDelayInDays** | Write | UInt32 |  ||
| **SoftwareUpdateNonOSDeferredInstallDelayInDays** | Write | UInt32 |  ||
| **SoftwareUpdatesEnforcedDelayInDays** | Write | UInt32 | Delay the user's software update for this many days. The maximum is 90 days. (1-90) ||
| **SpotlightBlockInternetResults** | Write | Boolean | Blocks Spotlight from returning any results from an Internet search ||
| **TouchIdTimeoutInHours** | Write | UInt32 |  ||
| **UpdateDelayPolicy** | Write | String |  |none, delayOSUpdateVisibility, delayAppUpdateVisibility, unknownFutureValue, delayMajorOsUpdateVisibility|
| **WallpaperModificationBlocked** | Write | Boolean |  ||
| **Assignments** | Write | InstanceArray[] | Represents the assignment to the Intune policy. ||
| **Ensure** | Write | String | Present ensures the policy exists, absent ensures it is removed. |Present, Absent|
| **Credential** | Write | PSCredential | Credentials of the Intune Admin ||
| **ApplicationId** | Write | String | Id of the Azure Active Directory application to authenticate with. ||
| **TenantId** | Write | String | Id of the Azure Active Directory tenant used for authentication. ||
| **ApplicationSecret** | Write | PSCredential | Secret of the Azure Active Directory tenant used for authentication. ||
| **CertificateThumbprint** | Write | String | Thumbprint of the Azure Active Directory application's authentication certificate to use for authentication. ||
| **ManagedIdentity** | Write | Boolean | Managed ID being used for authentication. ||


# IntuneDeviceConfigurationPolicyMacOS

### Description

This resource configures an Intune device configuration profile for an MacOS Device.


