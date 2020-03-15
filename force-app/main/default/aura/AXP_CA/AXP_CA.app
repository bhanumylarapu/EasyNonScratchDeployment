<aura:application controller="chatBotAssistantController_apiai" implements="force:appHostable,flexipage:availableForAllPageTypes,force:hasRecordId" extends="ltng:outApp" access="GLOBAL">
    
    <aura:dependency resource="markup://c:*" type="COMPONENT"/>	<!-- avoid server route on createComponent -->
    <!--<aura:dependency resource="c:axp_ca_robo"/>	--><!--avoiding double loading of component-->
    
</aura:application>