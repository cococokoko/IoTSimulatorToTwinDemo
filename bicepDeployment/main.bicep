@secure()
param IotHubs_IoTCoco_connectionString string

@secure()
param IotHubs_IoTCoco_containerName string
param IotHubs_IoTCoco_name string = 'IoTCoco'
param sites_IoTCocoFunction_name string = 'IoTCocoFunction'
param systemTopics_IoTCocoTopic_name string = 'IoTCocoTopic'
param components_IoTCocoFunction_name string = 'IoTCocoFunction'
param storageAccounts_storagecoco_name string = 'storagecoco'
param serverfarms_ASP_ResourceCoco_b9af_name string = 'ASP-ResourceCoco-b9af'
param storageAccounts_resourcecoco8764_name string = 'resourcecoco8764'
param storageAccounts_resourcecocobdd1_name string = 'resourcecocobdd1'
param components_IoTCocoFunction202303161431_name string = 'IoTCocoFunction202303161431'
param provisioningServices_IoTCocoProvisioning_name string = 'IoTCocoProvisioning'
param digitalTwinsInstances_IoTCocoDigitalTwin_name string = 'IoTCocoDigitalTwin'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param smartdetectoralertrules_failure_anomalies_iotcocofunction_name string = 'failure anomalies - iotcocofunction'
param smartdetectoralertrules_failure_anomalies_iotcocofunction202303161431_name string = 'failure anomalies - iotcocofunction202303161431'
param workspaces_DefaultWorkspace_ee58e014_1109_4d4e_b3ba_baf450b03b17_WEU_externalid string = '/subscriptions/ee58e014-1109-4d4e-b3ba-baf450b03b17/resourceGroups/DefaultResourceGroup-WEU/providers/Microsoft.OperationalInsights/workspaces/DefaultWorkspace-ee58e014-1109-4d4e-b3ba-baf450b03b17-WEU'

resource IotHubs_IoTCoco_name_resource 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: IotHubs_IoTCoco_name
  location: 'eastus'
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
  identity: {
    type: 'None'
  }
  properties: {
    ipFilterRules: []
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: 1
        partitionCount: 4
      }
    }
    routing: {
      endpoints: {
        serviceBusQueues: []
        serviceBusTopics: []
        eventHubs: [
          {
            connectionString: 'Endpoint=sb://iotcocoeventhub.servicebus.windows.net:5671/;SharedAccessKeyName=iothubroutes_${IotHubs_IoTCoco_name};SharedAccessKey=****;EntityPath=iotcocoevent'
            authenticationType: 'keyBased'
            name: '${IotHubs_IoTCoco_name}EventHubEndpoint'
            id: 'c63f9b6f-fcaf-4387-ad25-eeac94d57d8d'
            subscriptionId: 'ee58e014-1109-4d4e-b3ba-baf450b03b17'
            resourceGroup: 'ResourceCoco'
          }
        ]
        storageContainers: []
        cosmosDBSqlCollections: []
      }
      routes: [
        {
          name: 'RouteToEventGrid'
          source: 'DeviceMessages'
          condition: 'true'
          endpointNames: [
            'eventgrid'
          ]
          isEnabled: true
        }
      ]
      fallbackRoute: {
        name: '$fallback'
        source: 'DeviceMessages'
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: false
      }
    }
    storageEndpoints: {
      '$default': {
        sasTtlAsIso8601: 'PT1H'
        connectionString: IotHubs_IoTCoco_connectionString
        containerName: IotHubs_IoTCoco_containerName
      }
    }
    messagingEndpoints: {
      fileNotifications: {
        lockDurationAsIso8601: 'PT1M'
        ttlAsIso8601: 'PT1H'
        maxDeliveryCount: 10
      }
    }
    enableFileUploadNotifications: false
    cloudToDevice: {
      maxDeliveryCount: 10
      defaultTtlAsIso8601: 'PT1H'
      feedback: {
        lockDurationAsIso8601: 'PT1M'
        ttlAsIso8601: 'PT1H'
        maxDeliveryCount: 10
      }
    }
    features: 'None'
    disableLocalAuth: false
    allowedFqdnList: []
    enableDataResidency: false
  }
}

resource provisioningServices_IoTCocoProvisioning_name_resource 'Microsoft.Devices/provisioningServices@2022-12-12' = {
  name: provisioningServices_IoTCocoProvisioning_name
  location: 'eastus'
  sku: {
    name: 'S1'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    state: 'Active'
    provisioningState: 'Succeeded'
    iotHubs: [
      {
        connectionString: 'HostName=IoTCoco.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=****'
        location: 'eastus'
      }
    ]
    allocationPolicy: 'Hashed'
    enableDataResidency: false
  }
}

resource digitalTwinsInstances_IoTCocoDigitalTwin_name_resource 'Microsoft.DigitalTwins/digitalTwinsInstances@2023-01-31' = {
  name: digitalTwinsInstances_IoTCocoDigitalTwin_name
  location: 'westeurope'
  properties: {
    privateEndpointConnections: []
    publicNetworkAccess: 'Enabled'
  }
}

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2023-01-01' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_IoTCocoFunction_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_IoTCocoFunction_name
  location: 'westeurope'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_ee58e014_1109_4d4e_b3ba_baf450b03b17_WEU_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource components_IoTCocoFunction202303161431_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_IoTCocoFunction202303161431_name
  location: 'eastus'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaWebAppExtensionCreate'
    RetentionInDays: 90
    WorkspaceResourceId: workspaces_DefaultWorkspace_ee58e014_1109_4d4e_b3ba_baf450b03b17_WEU_externalid
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource storageAccounts_resourcecoco8764_name_resource 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccounts_resourcecoco8764_name
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource storageAccounts_resourcecocobdd1_name_resource 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccounts_resourcecocobdd1_name
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'Storage'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
  }
}

resource storageAccounts_storagecoco_name_resource 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccounts_storagecoco_name
  location: 'eastus'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_ASP_ResourceCoco_b9af_name_resource 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: serverfarms_ASP_ResourceCoco_b9af_name
  location: 'East US'
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource digitalTwinsInstances_IoTCocoDigitalTwin_name_IoTCocoEndpoint 'Microsoft.DigitalTwins/digitalTwinsInstances/endpoints@2023-01-31' = {
  parent: digitalTwinsInstances_IoTCocoDigitalTwin_name_resource
  name: 'IoTCocoEndpoint'
  properties: {
    authenticationType: 'KeyBased'
    endpointType: 'EventGrid'
    TopicEndpoint: 'https://iotcocotopic.westeurope-1.eventgrid.azure.net/api/events'
    accessKey1: '(PLACEHOLDER)'
    accessKey2: '(PLACEHOLDER)'
  }
}

resource systemTopics_IoTCocoTopic_name_resource 'Microsoft.EventGrid/systemTopics@2022-06-15' = {
  name: systemTopics_IoTCocoTopic_name
  location: 'eastus'
  properties: {
    source: IotHubs_IoTCoco_name_resource.id
    topicType: 'Microsoft.Devices.IoTHubs'
  }
}

resource components_IoTCocoFunction_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'degradationindependencyduration'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'degradationindependencyduration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'degradationinserverresponsetime'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'degradationinserverresponsetime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'digestMailConfiguration'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'digestMailConfiguration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_canaryextension'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_canaryextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_memoryleakextension'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_memoryleakextension'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_securityextensionspackage'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_securityextensionspackage'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'extension_traceseveritydetector'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'extension_traceseveritydetector'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'longdependencyduration'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'longdependencyduration'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'slowpageloadtime'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'slowpageloadtime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction_name_resource
  name: 'slowserverresponsetime'
  location: 'westeurope'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_IoTCocoFunction202303161431_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_IoTCocoFunction202303161431_name_resource
  name: 'slowserverresponsetime'
  location: 'eastus'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource storageAccounts_resourcecoco8764_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: [
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'GET'
            'POST'
            'OPTIONS'
            'PUT'
          ]
          maxAgeInSeconds: 200
          exposedHeaders: [
            'x-ms-meta-*'
          ]
          allowedHeaders: [
            'Authorization x-ms-version x-ms-blob-type'
            'x-ms-meta-data*'
          ]
        }
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'DELETE'
            'HEAD'
            'GET'
            'MERGE'
            'POST'
            'OPTIONS'
            'PUT'
            'PATCH'
          ]
          maxAgeInSeconds: 200
          exposedHeaders: [
            ''
          ]
          allowedHeaders: [
            'Authorization'
            'x-ms-version'
            'x-ms-blob-type'
          ]
        }
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'GET'
            'OPTIONS'
            'POST'
            'PUT'
          ]
          maxAgeInSeconds: 0
          exposedHeaders: [
            ''
          ]
          allowedHeaders: [
            'Authorization'
            'x-ms-version'
            'x-ms-blob-type'
          ]
        }
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'GET'
            'OPTIONS'
            'POST'
            'PUT'
          ]
          maxAgeInSeconds: 0
          exposedHeaders: [
            ''
          ]
          allowedHeaders: [
            'Authorization'
            'x-ms-version'
            'x-ms-blob-type'
          ]
        }
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'GET'
            'OPTIONS'
            'POST'
            'PUT'
          ]
          maxAgeInSeconds: 0
          exposedHeaders: [
            ''
          ]
          allowedHeaders: [
            'Authorization'
            'x-ms-version'
            'x-ms-blob-type'
          ]
        }
      ]
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource storageAccounts_resourcecocobdd1_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource storageAccounts_storagecoco_name_default 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storageAccounts_storagecoco_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: [
        {
          allowedOrigins: [
            'https://explorer.digitaltwins.azure.net'
          ]
          allowedMethods: [
            'GET'
            'OPTIONS'
            'POST'
            'PUT'
          ]
          maxAgeInSeconds: 0
          exposedHeaders: [
            ''
          ]
          allowedHeaders: [
            'Authorization'
            'x-ms-version'
            'x-ms-blob-type'
          ]
        }
      ]
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_resourcecoco8764_name_default 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_resourcecocobdd1_name_default 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_storagecoco_name_default 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' = {
  parent: storageAccounts_storagecoco_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_resourcecoco8764_name_default 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_resourcecocobdd1_name_default 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_storagecoco_name_default 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' = {
  parent: storageAccounts_storagecoco_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_resourcecoco8764_name_default 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_resourcecocobdd1_name_default 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_storagecoco_name_default 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' = {
  parent: storageAccounts_storagecoco_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_IoTCocoFunction_name_resource 'Microsoft.Web/sites@2022-09-01' = {
  name: sites_IoTCocoFunction_name
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/ee58e014-1109-4d4e-b3ba-baf450b03b17/resourceGroups/ResourceCoco/providers/microsoft.insights/components/IoTCocoFunction202303161431'
    'hidden-link: /app-insights-instrumentation-key': 'a742c3f0-14c5-407d-b359-0574a306daf6'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=a742c3f0-14c5-407d-b359-0574a306daf6;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/'
  }
  kind: 'functionapp,linux'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: 'iotcocofunction.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: 'iotcocofunction.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_ASP_ResourceCoco_b9af_name_resource.id
    reserved: true
    isXenon: false
    hyperV: false
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      linuxFxVersion: 'Python|3.8'
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: '81A56C6F899EA5876C4EA1DBB086B1501B0AAC1274E0E143D3B67AA35F1FEFBD'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_IoTCocoFunction_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'ftp'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/ee58e014-1109-4d4e-b3ba-baf450b03b17/resourceGroups/ResourceCoco/providers/microsoft.insights/components/IoTCocoFunction202303161431'
    'hidden-link: /app-insights-instrumentation-key': 'a742c3f0-14c5-407d-b359-0574a306daf6'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=a742c3f0-14c5-407d-b359-0574a306daf6;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/'
  }
  properties: {
    allow: true
  }
}

resource sites_IoTCocoFunction_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'scm'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/ee58e014-1109-4d4e-b3ba-baf450b03b17/resourceGroups/ResourceCoco/providers/microsoft.insights/components/IoTCocoFunction202303161431'
    'hidden-link: /app-insights-instrumentation-key': 'a742c3f0-14c5-407d-b359-0574a306daf6'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=a742c3f0-14c5-407d-b359-0574a306daf6;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/'
  }
  properties: {
    allow: true
  }
}

resource sites_IoTCocoFunction_name_web 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'web'
  location: 'East US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/ee58e014-1109-4d4e-b3ba-baf450b03b17/resourceGroups/ResourceCoco/providers/microsoft.insights/components/IoTCocoFunction202303161431'
    'hidden-link: /app-insights-instrumentation-key': 'a742c3f0-14c5-407d-b359-0574a306daf6'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=a742c3f0-14c5-407d-b359-0574a306daf6;IngestionEndpoint=https://eastus-8.in.applicationinsights.azure.com/;LiveEndpoint=https://eastus.livediagnostics.monitor.azure.com/'
  }
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    linuxFxVersion: 'Python|3.8'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$IoTCocoFunction'
    scmType: 'None'
    use32BitWorkerProcess: false
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    managedServiceIdentityId: 56334
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {
    }
  }
}

resource sites_IoTCocoFunction_name_DeleteDigitalTwin 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'DeleteDigitalTwin'
  location: 'East US'
  properties: {
    script_root_path_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/DeleteDigitalTwin/'
    script_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/DeleteDigitalTwin/__init__.py'
    config_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/DeleteDigitalTwin/function.json'
    test_data_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/tmp/FunctionsData/DeleteDigitalTwin.dat'
    href: 'https://iotcocofunction.azurewebsites.net/admin/functions/DeleteDigitalTwin'
    config: {
    }
    language: 'python'
    isDisabled: false
  }
}

resource sites_IoTCocoFunction_name_RegisterNewTwin 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'RegisterNewTwin'
  location: 'East US'
  properties: {
    script_root_path_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/RegisterNewTwin/'
    script_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/RegisterNewTwin/__init__.py'
    config_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/RegisterNewTwin/function.json'
    test_data_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/tmp/FunctionsData/RegisterNewTwin.dat'
    href: 'https://iotcocofunction.azurewebsites.net/admin/functions/RegisterNewTwin'
    config: {
    }
    language: 'python'
    isDisabled: false
  }
}

resource sites_IoTCocoFunction_name_TelemetryToTwin 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: 'TelemetryToTwin'
  location: 'East US'
  properties: {
    script_root_path_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/TelemetryToTwin/'
    script_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/TelemetryToTwin/__init__.py'
    config_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/home/site/wwwroot/TelemetryToTwin/function.json'
    test_data_href: 'https://iotcocofunction.azurewebsites.net/admin/vfs/tmp/FunctionsData/TelemetryToTwin.dat'
    href: 'https://iotcocofunction.azurewebsites.net/admin/functions/TelemetryToTwin'
    config: {
    }
    language: 'python'
    isDisabled: false
  }
}

resource sites_IoTCocoFunction_name_sites_IoTCocoFunction_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2022-09-01' = {
  parent: sites_IoTCocoFunction_name_resource
  name: '${sites_IoTCocoFunction_name}.azurewebsites.net'
  location: 'East US'
  properties: {
    siteName: 'IoTCocoFunction'
    hostNameType: 'Verified'
  }
}

resource smartdetectoralertrules_failure_anomalies_iotcocofunction_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_iotcocofunction_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_IoTCocoFunction_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource smartdetectoralertrules_failure_anomalies_iotcocofunction202303161431_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_iotcocofunction202303161431_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_IoTCocoFunction202303161431_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource systemTopics_IoTCocoTopic_name_teletransporter 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  parent: systemTopics_IoTCocoTopic_name_resource
  name: 'teletransporter'
  properties: {
    destination: {
      properties: {
        resourceId: sites_IoTCocoFunction_name_TelemetryToTwin.id
        maxEventsPerBatch: 1
        preferredBatchSizeInKilobytes: 64
      }
      endpointType: 'AzureFunction'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Devices.DeviceTelemetry'
      ]
    }
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}

resource systemTopics_IoTCocoTopic_name_twindeletion 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  parent: systemTopics_IoTCocoTopic_name_resource
  name: 'twindeletion'
  properties: {
    destination: {
      properties: {
        resourceId: sites_IoTCocoFunction_name_DeleteDigitalTwin.id
        maxEventsPerBatch: 1
        preferredBatchSizeInKilobytes: 64
      }
      endpointType: 'AzureFunction'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Devices.DeviceDeleted'
      ]
      enableAdvancedFilteringOnArrays: true
    }
    labels: []
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}

resource systemTopics_IoTCocoTopic_name_twinsimulation 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  parent: systemTopics_IoTCocoTopic_name_resource
  name: 'twinsimulation'
  properties: {
    destination: {
      properties: {
        resourceId: sites_IoTCocoFunction_name_RegisterNewTwin.id
        maxEventsPerBatch: 1
        preferredBatchSizeInKilobytes: 64
      }
      endpointType: 'AzureFunction'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Devices.DeviceCreated'
      ]
      enableAdvancedFilteringOnArrays: true
    }
    labels: []
    eventDeliverySchema: 'EventGridSchema'
    retryPolicy: {
      maxDeliveryAttempts: 30
      eventTimeToLiveInMinutes: 1440
    }
  }
}

resource storageAccounts_resourcecoco8764_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecoco8764_name_resource
  ]
}

resource storageAccounts_resourcecocobdd1_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecocobdd1_name_resource
  ]
}

resource storageAccounts_resourcecoco8764_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecoco8764_name_resource
  ]
}

resource storageAccounts_resourcecocobdd1_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecocobdd1_name_resource
  ]
}

resource storageAccounts_resourcecoco8764_name_default_function_releases 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_default
  name: 'function-releases'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecoco8764_name_resource
  ]
}

resource storageAccounts_resourcecoco8764_name_default_iotcocodigitaltwin 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecoco8764_name_default
  name: 'iotcocodigitaltwin'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecoco8764_name_resource
  ]
}

resource storageAccounts_resourcecocobdd1_name_default_scm_releases 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_resourcecocobdd1_name_default
  name: 'scm-releases'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_resourcecocobdd1_name_resource
  ]
}

resource storageAccounts_storagecoco_name_default_storageAccounts_storagecoco_name_container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: storageAccounts_storagecoco_name_default
  name: '${storageAccounts_storagecoco_name}container'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_storagecoco_name_resource
  ]
}

resource storageAccounts_resourcecocobdd1_name_default_iotcocofunction82b8 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_resourcecocobdd1_name_default
  name: 'iotcocofunction82b8'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [

    storageAccounts_resourcecocobdd1_name_resource
  ]
}

resource storageAccounts_resourcecoco8764_name_default_iotcocofunctiona65d 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_resourcecoco8764_name_default
  name: 'iotcocofunctiona65d'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [

    storageAccounts_resourcecoco8764_name_resource
  ]
}
