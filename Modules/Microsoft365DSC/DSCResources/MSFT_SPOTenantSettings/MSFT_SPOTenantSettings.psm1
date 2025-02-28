function Get-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable])]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        # DEPRECATED
        [Parameter()]
        [System.Boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [ValidateSet("AllowExternalSharing", "BlockExternalSharing")]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [ValidateSet("AllowFullAccess", "AllowLimitedAccess", "BlockAccess")]
        [System.String]
        $ConditionalAccessPolicy,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [System.Boolean]
        $IsFluidEnabled,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Write-Verbose -Message "Getting configuration for SPO Tenant"
    $ConnectionMode = New-M365DSCConnection -Workload 'PNP' -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace "MSFT_", ""
    $CommandName  = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    if ($PSBoundParameters.ContainsKey("RequireAcceptingAccountMatchInvitedAccount"))
    {
        Write-Warning "RequireAcceptingAccountMatchInvitedAccount is deprecated. Please remove this parameter from your configuration."
    }
    $nullReturn = $PSBoundParameters
    $nullReturn.Ensure = "Absent"

    try
    {
        $SPOTenantSettings = Get-PnPTenant -ErrorAction Stop

        $CompatibilityRange = $SPOTenantSettings.CompatibilityRange.Split(',')
        $MinCompat = $null
        $MaxCompat = $null
        if ($CompatibilityRange.Length -eq 2)
        {
            $MinCompat = $CompatibilityRange[0]
            $MaxCompat = $CompatibilityRange[1]
        }

        return @{
            IsSingleInstance                              = 'Yes'
            MinCompatibilityLevel                         = $MinCompat
            MaxCompatibilityLevel                         = $MaxCompat
            SearchResolveExactEmailOrUPN                  = $SPOTenantSettings.SearchResolveExactEmailOrUPN
            OfficeClientADALDisabled                      = $SPOTenantSettings.OfficeClientADALDisabled
            LegacyAuthProtocolsEnabled                    = $SPOTenantSettings.LegacyAuthProtocolsEnabled
            SignInAccelerationDomain                      = $SPOTenantSettings.SignInAccelerationDomain
            UsePersistentCookiesForExplorerView           = $SPOTenantSettings.UsePersistentCookiesForExplorerView
            UserVoiceForFeedbackEnabled                   = $SPOTenantSettings.UserVoiceForFeedbackEnabled
            PublicCdnEnabled                              = $SPOTenantSettings.PublicCdnEnabled
            PublicCdnAllowedFileTypes                     = $SPOTenantSettings.PublicCdnAllowedFileTypes
            UseFindPeopleInPeoplePicker                   = $SPOTenantSettings.UseFindPeopleInPeoplePicker
            NotificationsInSharePointEnabled              = $SPOTenantSettings.NotificationsInSharePointEnabled
            OwnerAnonymousNotification                    = $SPOTenantSettings.OwnerAnonymousNotification
            ApplyAppEnforcedRestrictionsToAdHocRecipients = $SPOTenantSettings.ApplyAppEnforcedRestrictionsToAdHocRecipients
            FilePickerExternalImageSearchEnabled          = $SPOTenantSettings.FilePickerExternalImageSearchEnabled
            HideDefaultThemes                             = $SPOTenantSettings.HideDefaultThemes
            MarkNewFilesSensitiveByDefault                = $SPOTenantSettings.MarkNewFilesSensitiveByDefault
            ConditionalAccessPolicy                       = $SPOTenantSettings.ConditionalAccessPolicy
            DisabledWebPartIds                            = $SPOTenantSettings.DisabledWebPartIds
            Credential                                    = $Credential
            ApplicationId                                 = $ApplicationId
            TenantId                                      = $TenantId
            ApplicationSecret                             = $ApplicationSecret
            CertificatePassword                           = $CertificatePassword
            CertificatePath                               = $CertificatePath
            CertificateThumbprint                         = $CertificateThumbprint
            Ensure                                        = "Present"
        }
    }
    catch
    {
        if ($error[0].Exception.Message -like "No connection available")
        {
            Write-Verbose -Message "Make sure that you are connected to your SPOService"
        }
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return $nullReturn
    }
}

function Set-TargetResource
{
    [CmdletBinding()]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        # DEPRECATED
        [Parameter()]
        [System.Boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [ValidateSet("AllowExternalSharing", "BlockExternalSharing")]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [ValidateSet("AllowFullAccess","AllowLimitedAccess", "BlockAccess")]
        [System.String]
        $ConditionalAccessPolicy,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    Write-Verbose -Message "Setting configuration for SPO Tenant"

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace "MSFT_", ""
    $CommandName  = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    $ConnectionMode = New-M365DSCConnection -Workload 'PNP' -InboundParameters $PSBoundParameters

    if ($PSBoundParameters.ContainsKey("RequireAcceptingAccountMatchInvitedAccount"))
    {
        Write-Warning "RequireAcceptingAccountMatchInvitedAccount is deprecated. Please remove this parameter from your configuration."
    }

    $CurrentParameters = $PSBoundParameters
    $CurrentParameters.Remove("Credential") | Out-Null
    $CurrentParameters.Remove("IsSingleInstance") | Out-Null
    $CurrentParameters.Remove("Ensure") | Out-Null
    $CurrentParameters.Remove("ApplicationId") | Out-Null
    $CurrentParameters.Remove("TenantId") | Out-Null
    $CurrentParameters.Remove("CertificatePath") | Out-Null
    $CurrentParameters.Remove("CertificatePassword") | Out-Null
    $CurrentParameters.Remove("CertificateThumbprint") | Out-Null
    $CurrentParameters.Remove("ApplicationSecret") | Out-Null

    if ($PublicCdnEnabled -eq $false)
    {
        Write-Verbose -Message "The use of the public CDN is not enabled, for that the PublicCdnAllowedFileTypes parameter can not be configured and will be removed"
        $CurrentParameters.Remove("PublicCdnAllowedFileTypes") | Out-Null
    }
    $tenant = Set-PnPTenant @CurrentParameters
}

function Test-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param (

        [Parameter(Mandatory = $true)]
        [ValidateSet('Yes')]
        [String]
        $IsSingleInstance,

        [Parameter()]
        [System.UInt32]
        $MinCompatibilityLevel,

        [Parameter()]
        [System.UInt32]
        $MaxCompatibilityLevel,

        [Parameter()]
        [System.Boolean]
        $SearchResolveExactEmailOrUPN,

        [Parameter()]
        [System.Boolean]
        $OfficeClientADALDisabled,

        [Parameter()]
        [System.Boolean]
        $LegacyAuthProtocolsEnabled,

        [Parameter()]
        [System.Boolean]
        $RequireAcceptingAccountMatchInvitedAccount,

        [Parameter()]
        [System.String]
        $SignInAccelerationDomain,

        [Parameter()]
        [System.Boolean]
        $UsePersistentCookiesForExplorerView,

        [Parameter()]
        [System.Boolean]
        $UserVoiceForFeedbackEnabled,

        [Parameter()]
        [System.Boolean]
        $PublicCdnEnabled,

        [Parameter()]
        [System.String]
        $PublicCdnAllowedFileTypes,

        [Parameter()]
        [System.Boolean]
        $UseFindPeopleInPeoplePicker,

        [Parameter()]
        [System.Boolean]
        $NotificationsInSharePointEnabled,

        [Parameter()]
        [System.Boolean]
        $OwnerAnonymousNotification,

        [Parameter()]
        [System.Boolean]
        $ApplyAppEnforcedRestrictionsToAdHocRecipients,

        [Parameter()]
        [System.Boolean]
        $FilePickerExternalImageSearchEnabled,

        [Parameter()]
        [System.Boolean]
        $HideDefaultThemes,

        [Parameter()]
        [ValidateSet("AllowExternalSharing", "BlockExternalSharing")]
        [System.String]
        $MarkNewFilesSensitiveByDefault,

        [Parameter()]
        [ValidateSet("AllowFullAccess", "AllowLimitedAccess", "BlockAccess")]
        [System.String]
        $ConditionalAccessPolicy,

        [Parameter()]
        [System.Guid[]]
        $DisabledWebPartIds,

        [Parameter()]
        [ValidateSet("Present", "Absent")]
        [System.String]
        $Ensure = "Present",

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )
    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace "MSFT_", ""
    $CommandName  = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

    if ($PSBoundParameters.ContainsKey("RequireAcceptingAccountMatchInvitedAccount"))
    {
        Write-Warning "RequireAcceptingAccountMatchInvitedAccount is deprecated. Please remove this parameter from your configuration."
    }

    Write-Verbose -Message "Testing configuration for SPO Tenant"
    $CurrentValues = Get-TargetResource @PSBoundParameters

    Write-Verbose -Message "Current Values: $(Convert-M365DscHashtableToString -Hashtable $CurrentValues)"
    Write-Verbose -Message "Target Values: $(Convert-M365DscHashtableToString -Hashtable $PSBoundParameters)"

    $TestResult = Test-M365DSCParameterState -CurrentValues $CurrentValues `
        -Source $($MyInvocation.MyCommand.Source) `
        -DesiredValues $PSBoundParameters `
        -ValuesToCheck @("IsSingleInstance", `
            "MaxCompatibilityLevel", `
            "SearchResolveExactEmailOrUPN", `
            "OfficeClientADALDisabled", `
            "LegacyAuthProtocolsEnabled", `
            "RequireAcceptingAccountMatchInvitedAccount", `
            "SignInAccelerationDomain", `
            "UsePersistentCookiesForExplorerView", `
            "UserVoiceForFeedbackEnabled", `
            "PublicCdnEnabled", `
            "PublicCdnAllowedFileTypes", `
            "UseFindPeopleInPeoplePicker", `
            "NotificationsInSharePointEnabled", `
            "OwnerAnonymousNotification", `
            "ApplyAppEnforcedRestrictionsToAdHocRecipients", `
            "FilePickerExternalImageSearchEnabled", `
            "HideDefaultThemes", `
            "MarkNewFilesSensitiveByDefault", `
            "ConditionalAccessPolicy", `
            "DisabledWebPartIds"
            )

    Write-Verbose -Message "Test-TargetResource returned $TestResult"
    return $TestResult
}

function Export-TargetResource
{
    [CmdletBinding()]
    [OutputType([System.String])]
    param
    (
        [Parameter()]
        [System.Management.Automation.PSCredential]
        $Credential,

        [Parameter()]
        [System.String]
        $ApplicationId,

        [Parameter()]
        [System.String]
        $TenantId,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $ApplicationSecret,

        [Parameter()]
        [System.String]
        $CertificatePath,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        $CertificatePassword,

        [Parameter()]
        [System.String]
        $CertificateThumbprint
    )

    try
    {
        $ConnectionMode = New-M365DSCConnection -Workload 'PNP' `
            -InboundParameters $PSBoundParameters

    #Ensure the proper dependencies are installed in the current environment.
    Confirm-M365DSCDependencies

    #region Telemetry
    $ResourceName = $MyInvocation.MyCommand.ModuleName -replace "MSFT_", ""
    $CommandName  = $MyInvocation.MyCommand
    $data = Format-M365DSCTelemetryParameters -ResourceName $ResourceName `
        -CommandName $CommandName `
        -Parameters $PSBoundParameters
    Add-M365DSCTelemetryEvent -Data $data
    #endregion

        $Params = @{
            IsSingleInstance      = 'Yes'
            ApplicationId         = $ApplicationId
            TenantId              = $TenantId
            ApplicationSecret     = $ApplicationSecret
            CertificatePassword   = $CertificatePassword
            CertificatePath       = $CertificatePath
            CertificateThumbprint = $CertificateThumbprint
            Credential    = $Credential
        }

        $Results = Get-TargetResource @Params
        if ($null -eq $Results.MaxCompatibilityLevel)
        {
            $Results.Remove("MaxCompatibilityLevel") | Out-Null
        }
        if ($null -eq $Results.MinCompatibilityLevel)
        {
            $Results.Remove("MinCompatibilityLevel") | Out-Null
        }
        $Results = Update-M365DSCExportAuthenticationResults -ConnectionMode $ConnectionMode `
            -Results $Results
        $currentDSCBlock = Get-M365DSCExportContentForResource -ResourceName $ResourceName `
            -ConnectionMode $ConnectionMode `
            -ModulePath $PSScriptRoot `
            -Results $Results `
            -Credential $Credential
        $dscContent += $currentDSCBlock
        Save-M365DSCPartialExport -Content $currentDSCBlock `
            -FileName $Global:PartialExportFileName
        Write-Host $Global:M365DSCEmojiGreenCheckmark
        return $dscContent
    }
    catch
    {
        Write-Host $Global:M365DSCEmojiRedX
        try
        {
            Write-Verbose -Message $_
            $tenantIdValue = ""
            if (-not [System.String]::IsNullOrEmpty($TenantId))
            {
                $tenantIdValue = $TenantId
            }
            elseif ($null -ne $Credential)
            {
                $tenantIdValue = $Credential.UserName.Split('@')[1]
            }
            Add-M365DSCEvent -Message $_ -EntryType 'Error' `
                -EventID 1 -Source $($MyInvocation.MyCommand.Source) `
                -TenantId $tenantIdValue
        }
        catch
        {
            Write-Verbose -Message $_
        }
        return ""
    }
}

Export-ModuleMember -Function *-TargetResource
