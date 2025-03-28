{assign var="nelRemoveLowEngagement" value="crdl-removeFromList='nel-low-engagement'"}

{if not isset($primaryColor)}{assign var="primaryColor" value="#1143ba"}{/if}
{if not isset($headingColor)}{assign var="headingColor" value="#0a1f44"}{/if}
{if not isset($stickerColor)}{assign var="stickerColor" value="#138b55"}{/if}
{if not isset($footerBackground)}{assign var="footerBackground" value="#555555"}{/if}
{if not isset($backgroundColor)}{assign var="backgroundColor" value="#1143ba"}{/if}
{if not isset($backgroundUrlTop)}{assign var="backgroundUrlTop" value="https://images.cordial.com/1225/600x78/Cap-Trans-FADE-FROM-B.png"}{/if}
{if not isset($backgroundUrlBottom)}{assign var="backgroundUrlBottom" value="https://images.cordial.com/1225/600x79/Cap-Trans-FADE-INTO-B.png"}{/if}


<!-- ///// RECOVERY NAV-->
<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$footerBackground}"
                    style="padding-top:0px; padding-bottom: 0px; background-color:{$footerBackground};"
                    class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" class="width-100"
                        style="margin: 0 auto;">
                        <tbody>
                            <tr>
                                <td align="center" style="text-align: center;" class="width-100"><img
                                        src="https://images.cordial.com/1225/600x79/Cap-Trans-FADE-INTO-A.png" alt=""
                                        width="600" class="fluid"
                                        style="display:block; border:none; outline:none; text-decoration:none;"
                                        border="0"></td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>


<div>
    <table width="600" bgcolor="{$footerBackground}" cellpadding="0" cellspacing="0" border="0" style="margin: 0 auto;"
        class="width-100">
        <tr>
            <td style="padding-top:8px; padding-bottom: 0px; background-color: {$footerBackground};" class="width-100">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td align="center" style="text-align: center;" class="width-100">
                            <table width="560" cellpadding="0" cellspacing="0" border="0" align="center"
                                class="width-100">
                                <tr>
                                    <td style="padding-top:15px; padding-bottom: 15px; border-bottom: 1px solid #a4a4a4; border-top: 1px solid #a4a4a4; text-align:center;"
                                        class="width-100">
                                        {if $contact["company-name"] && $contact['shop-url']}
                                            <a href="{$contact['shop-url']}"
                                                data-crdl-key="Footer - Your [Company Name] Shop" {$nelRemoveLowEngagement}
                                                style="font-family: Helvetica, arial, sans-serif; font-weight: bold; color:#ffffff; font-size:20px; line-height:26px; text-decoration: none;">
                                                {$contact['company-name']}
                                            </a>
                                        {else if $contact["company-gbs-company-id"]|trim == "" && $contact["company-GBSCompanyID"]|trim == ""}
                                            <a href="https://www.markful.com/marketcentergateway/fullsearch"
                                                data-crdl-key="Footer - Find Your Company" {$nelRemoveLowEngagement}
                                                style="font-family: Helvetica, arial, sans-serif; font-weight: bold; color:#ffffff; font-size:20px; line-height:26px; text-decoration: none;">
                                                Find Your Company for Easier Ordering
                                            </a>
                                        {else}
                                            <a href="https://www.markful.com/marketing-essentials" {$nelRemoveLowEngagement}
                                                style="font-family: Helvetica, arial, sans-serif; font-weight: bold; color:#ffffff; font-size:20px; line-height:26px; text-decoration: none;"
                                                data-crdl-key="Footer - Marketing Materials">
                                                Marketing Materials</a>
                                        {/if}
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

{include 'content:contact-page-views' scope='parent' daysToLookBack=45}

<div>
    <table width="600" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;" class="width-100">
        <tr>
            <td valign="top" bgcolor="{$footerBackground}"
                style="background-color: {$footerBackground}; padding-top: 0px; padding-bottom: 0px; "
                class="width-100">
                <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" class="container
                " style="margin:0 auto;">
                    <tr>
                        <th width="280" valign="middle" class="width-50"
                            style="padding-top: 15px; padding-bottom: 15px; border-right: 1px solid #a4a4a4; border-bottom: 1px solid #a4a4a4;">
                            <table width="280" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;"
                                class="width-50">
                                <tr>
                                    <td width="200" align="center" class="width-50">
                                        <a href="{$contactPageViews[0].landingURL}"
                                            data-crdl-key="Footer - {$contactPageViews[0]["headingShort"][0]}"
                                            {$nelRemoveLowEngagement}
                                            style="font-size:18px; line-height: 22px; font-family:Helvetica, arial, sans-serif; text-align:center; color:#ffffff; font-weight: normal; text-decoration: none; ">{$contactPageViews[0]["headingShort"][0]}</a>
                                    </td>
                                </tr>
                            </table>
                        </th>
                        <th width="280" valign="middle" class="width-50"
                            style="padding-top: 15px; padding-bottom: 15px; border-bottom: 1px solid #a4a4a4;">
                            <table width="280" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;"
                                class="width-50">
                                <tr>
                                    <td width="200" align="center" class="width-50"><a
                                            href="{$contactPageViews[1].landingURL}" {$nelRemoveLowEngagement}
                                            data-crdl-key="Footer - {$contactPageViews[1]["headingShort"][0]}"
                                            style="font-size:18px; line-height: 22px; font-family:Helvetica, arial, sans-serif; text-align:center; color:#ffffff; font-weight: normal; text-decoration: none; ">{$contactPageViews[1]["headingShort"][0]}</a>
                                    </td>
                                </tr>
                            </table>
                        </th>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<div>
    <table width="600" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;" class="width-100">
        <tr>
            <td valign="top" bgcolor="{$footerBackground}"
                style="background-color: {$footerBackground}; padding-top: 0px; padding-bottom: 0px; "
                class="width-100">
                <table width="560" border="0" align="center" cellpadding="0" cellspacing="0" class="container
                " style="margin:0 auto;">
                    <tr>
                        <th width="280" valign="middle" class="width-50"
                            style="padding-top: 15px; padding-bottom: 15px; border-right: 1px solid #a4a4a4; border-bottom: 1px solid #a4a4a4;">
                            <table width="280" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;"
                                class="width-50">
                                <tr>
                                    <td width="200" align="center" class="width-50">
                                        <a href="{$contactPageViews[2].landingURL}"
                                            data-crdl-key="Footer - {$contactPageViews[2]["headingShort"][0]}"
                                            {$nelRemoveLowEngagement}
                                            style="font-size:18px; line-height: 22px; font-family:Helvetica, arial, sans-serif; text-align:center; color:#ffffff; font-weight: normal; text-decoration: none; ">{$contactPageViews[2]["headingShort"][0]}</a>
                                    </td>
                                </tr>
                            </table>
                        </th>
                        <th width="280" valign="middle" class="width-50"
                            style="padding-top: 15px; padding-bottom: 15px; border-bottom: 1px solid #a4a4a4;">
                            <table width="280" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;"
                                class="width-50">
                                <tr>
                                    <td width="200" align="center" class="width-50"><a
                                            href="{$contactPageViews[3].landingURL}" {$nelRemoveLowEngagement}
                                            data-crdl-key="Footer - {$contactPageViews[3]["headingShort"][0]}"
                                            style="font-size:18px; line-height: 22px; font-family:Helvetica, arial, sans-serif; text-align:center; color:#ffffff; font-weight: normal; text-decoration: none; ">{$contactPageViews[3]["headingShort"][0]}</a>
                                    </td>
                                </tr>
                            </table>
                        </th>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
<!-- END CONTENT ZONE-->

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" style="margin: 0 auto;" class="width-100">
        <tr>
            <td bgcolor="{$footerBackground}"
                style="background-color: {$footerBackground}; padding-top: 25px; padding-bottom: 45px;"
                class="width-100">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="width-100">
                    <tr>
                        <td style="padding-top:0px; padding-bottom:0px;" class="width-100">
                            <table width="540" align="center" cellpadding="0" cellspacing="0" border="0"
                                class="width-100">
                                <tr>
                                    <td style="text-align:center; font-family: Arial,Verdana,sans-serif;font-size: 12px; color: #a4a4a4; line-height: 14px; padding-bottom: 9px;"
                                        class="width-100">
                                        Markful | 1912 John Towers Ave |
                                        El&nbsp;Cajon,&nbsp;CA&nbsp;92020 </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center; font-family: Arial,Verdana,sans-serif;font-size: 12px; color: #a4a4a4; line-height: 14px; padding-bottom: 9px;"
                                        class="width-100">
                                        (800) 789-6247 | <a href="mailto:info@markful.com"
                                            style="color: #a4a4a4; text-decoration: none;">info@markful.com</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align:center; font-family: Arial,Verdana,sans-serif;font-size: 12px; color: #a4a4a4; line-height: 14px; padding-bottom: 9px;"
                                        class="width-100">
                                        <a href="{$env['optoutLink']}"
                                            style="color: #a4a4a4; text-decoration: underline;"
                                            data-crdl-key="Unsubscribe Link">Unsubscribe</a>
                                        | <a href="https://www.markful.com/privacy-notice/"
                                            style="color: #a4a4a4; text-decoration: underline;"
                                            data-crdl-key="Privacy Policy Link">Privacy
                                            Policy</a> |
                                        &copy;{$smarty.now|date_format:"%Y"}
                                        Markful.
                                        All rights reserved.
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<!--{$env['optoutLink']}-->
{include 'content:honeypot_link_2' scope='parent'}
</td>

</tr>
</table>

</body>

</html>


{if $debug == 1}
    {$debug = 0}
{/if}