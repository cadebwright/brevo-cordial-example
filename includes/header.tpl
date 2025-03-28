{include 'content:suppress_overquota_bounce' scope='parent' assign='blackhole'}
{if $config_bounce.stopMessage == 1}{stopMessage reason='Inbox over quota'}{/if}

{if $contact["last-order-date"]}
    {$utils->updateContact(['nel-low-engagement'=>false])}
{/if}

{$utils->updateContact(['nel-active'=>false])}
{assign var="nelRemoveLowEngagement" value="crdl-removeFromList='nel-low-engagement'"}

{assign var="primaryColor" value="#1143ba"}
{assign var="secondaryColor" value="#ebecf0"}
{assign var="headingColor" value="#0a1f44"}
{assign var="stickerColor" value="#138b55"}
{assign var="footerBackground" value="#555555"}
{assign var="backgroundUrlTop" value="https://images.cordial.com/1225/600x78/Cap-Trans-FADE-FROM-B.png"}
{assign var="backgroundUrlBottom" value="https://images.cordial.com/1225/600x79/Cap-Trans-FADE-INTO-B.png"}
{assign var="showTestMessage" value=$showTestMessage|default:1}
{assign var="customTestMessage" value=$customTestMessage|default:''}
{assign var="exp" value=$exp|default:""}

<html>

<head>
    <meta charset="utf-8">
    <title>Markful</title>
    <meta http-equiv="Content-Language" content="en-us">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />

    <style>
        #outlook a {
            padding: 0;
        }

        /* Force Outlook to provide a "view in browser" menu link. */
        body {
            width: 100% !important;
            -webkit-text-size-adjust: 100%;
            -ms-text-size-adjust: 100%;
            margin: 0;
            padding: 0;
        }

        td {
            mso-table-lspace: 0pt !important;
            mso-table-rspace: 0pt !important;
        }

        img {
            -ms-interpolation-mode: bicubic;
        }

        a {
            color: #1d38ff;
            text-decoration: underline;
        }

        @media only screen and (max-width: 480px) {

            /* Full width adjustments for mobile */
            .width160,
            .width225,
            .width270,
            .width280,
            .width300,
            .width320 {
                width: 100% !important;
                height: auto !important;
                margin: 0 auto !important;
            }

            .width280,
            .container {
                padding-left: 10px !important;
                padding-right: 10px !important;
                width: 100% !important;
            }

            .width-100 {
                width: 100% !important;
                height: auto !important;
                margin: 0 auto !important;
            }

            .width-90 {
                width: 90% !important;
                height: auto !important;
                margin: 0 auto !important;
            }

            .width-85 {
                width: 85% !important;
                height: auto !important;
                margin: 0 auto !important;
            }

            .width-50 {
                width: 50% !important;
                height: auto !important;
                margin: 0 auto !important;
            }

            .body {
                background-color: transparent !important;
                font-size: 16px !important;
                line-height: 1.5 !important;
                background-color: #FFFFFF !important;
                padding: 0 !important;
                width: 100% !important;
            }

            .container {
                padding-left: 16px !important;
                padding-right: 16px !important;
            }

            .heightauto {
                height: auto !important;
            }

            /* Hide and block controls */
            .hide {
                display: none !important;
            }

            .block {
                display: block !important;
            }

            .fluid {
                width: 100% !important;
            }

            /* Padding adjustments */
            .padzero {
                padding: 0 !important;
            }

            .padbtm {
                padding-bottom: 30px !important;
            }

            .nopadbtm {
                padding-bottom: 0px !important;
            }

            .paddingleft {
                padding-left: 30px !important;
            }

            .padtwofive {
                padding-top: 25px !important;
                padding-bottom: 25px !important;
            }

            /* Text colors */
            .ltblue {
                color: #3776bc;
            }

            .blue {
                color: #003B78;
            }

            .dkblue {
                color: #192D58;
            }

            .orange {
                color: #FF6F06;
            }

            .grey {
                color: #c1c1c1;
            }

            /* Border styling */
            .brdr {
                border-top: 0 !important;
                border-right: 0 !important;
                border-bottom: 1px solid #171617 !important;
                border-left: 0 !important;
            }

            /* Navigation styling */
            .navpad {
                padding-bottom: 15px !important;
            }

            .nav {
                font-size: 12px !important;
                line-height: 26px !important;
            }

            /* Logo styling */
            .stacked-logo-mobile,
            .stacked-logo-mobile table {
                width: 100% !important;
                text-align: center;
            }

            .stacked-logo-mobile tbody,
            .stacked-logo-mobile tr {
                display: block !important;
                margin: 4px auto !important;
            }

            .stacked-logo-mobile img {
                width: 250px !important;
                object-position: center !important;
            }

            .stacked-logo-mobile .markful-logo {
                margin-top: 24px;
                height: 60px !important;
                max-width: 100% !important;
            }

            .stacked-logo-mobile .company-logo {
                max-height: 60px !important;
                width: 250px !important;
            }

            .body {
                background-color: transparent !important;
                font-size: 18px !important;
                line-height: 1.6 !important;
            }

            /* Button styling */
            .btn-primary-container {
                padding: 1.2em 2.5em !important;
            }

            .btn-primary {
                font-size: 20px !important;
                line-height: 1.3 !important;
                max-width: 100% !important;
            }
        }

        .button {
            display: inline-block;
            min-width: 130px;
            width: auto;
            color: #FFFFFF;
            background-color: #1d38ff;
            border-radius: 3px;
            justify-content: center;
            align-items: center;
            padding: 15px 30px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
        }
    </style>
</head>

<body bgcolor="#D4D4D4" style="background-color: #D4D4D4; padding-left: 6px; padding-right: 6px;" class="body">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" style="margin:0 auto;">
        <tr>

            <td align="center" bgcolor="#D4D4D4" style="background-color:#D4D4D4;" class="body"> {include
                        'content:honeypot_link_1' scope='parent'}


                {if $debug == 1}
                    {$debug = 0}
                {/if}

                {if $exp != ""}
                    {$utils->setMessageLinkAppendValue('exp', $exp)}
                {/if}

                {if $utils->isTestSend() && $showTestMessage == 1}
                    {$linksAppends = $utils->getMessageLinkAppendValue()}
                    {if $linksAppends.exp}
                        <table width="600" cellpadding="0" cellspacing="0" border="0"
                            style="margin: 10px 0; padding-bottom: 0px; padding-top: 0px;" class="width-100">
                            <tr>
                                <td width="600" class="container">
                                    <table width="600" cellpadding="0" cellspacing="0" border="0" style="margin: 0 auto;"
                                        class="width-100">
                                        <tr>
                                            <td width="600"
                                                style="background-color: #F8D7DA; padding: 15px; border-radius: 4px; border: 1px solid #FFB74D;"
                                                class="width-100">
                                                <p
                                                    style="font-family: Arial, sans-serif; color: #664D03; margin: 0; font-size: 14px; line-height: 1.5;">
                                                    <strong>⚠️ This Message Contains Warnings</strong><br>
                                                    The query "exp" parmeter is actived with value of {$linksAppends.exp}.<span
                                                        style="display: block; font-size: 12px; font-style: italics;">This will
                                                        flash a sale expired message to the user if they click on a link in this
                                                        email after this date.</span>
                                                </p>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    {/if}

                    {* Set up timezone and format for LA time *}
                    {$getNow.tzId = 'America/Los_Angeles'}
                    {$getNow.format = 'U'} {* Get timestamp *}
                    {$currentTimestamp = $utils->getNow($getNow.tzId, $getNow.format)}

                    {if $date}
                        {assign var="displayDate" value=$date}
                    {else}
                        {* Calculate tomorrow's timestamp *}
                        {assign var="tomorrowTimestamp" value=$currentTimestamp + 86400} {* Add 24 hours in seconds *}
                        {assign var="dayOfWeek" value=$tomorrowTimestamp|date_format:"%w"}

                        {if $dayOfWeek == "6"}
                            {* If tomorrow is Saturday, jump to Monday (+3 days) *}
                            {assign var="displayDate" value=$currentTimestamp + (86400 * 3)}
                        {elseif $dayOfWeek == "0"}
                            {* If tomorrow is Sunday, jump to Monday (+2 days) *}
                            {assign var="displayDate" value=$currentTimestamp + (86400 * 2)}
                        {else}
                            {* For weekdays, just use tomorrow *}
                            {assign var="displayDate" value=$tomorrowTimestamp}
                        {/if}
                    {/if}

                    <table width="600" cellpadding="0" cellspacing="0" border="0"
                        style="margin: 10px 0; padding-bottom: 22px; padding-top: 0px;" class="width-100">
                        <tr>
                            <td width="600" class="container">
                                <table width="600" cellpadding="0" cellspacing="0" border="0" style="margin: 0 auto;"
                                    class="width-100">
                                    <tr>
                                        <td width="600"
                                            style="background-color: #FFF7E6; padding: 15px; border-radius: 4px; border: 1px solid #FFB74D;"
                                            class="width-100">
                                            <p
                                                style="font-family: Arial, sans-serif; color: #664D03; margin: 0; font-size: 14px; line-height: 1.5;">
                                                <strong>📧 Email Preview</strong><br>
                                                This is a test email for {$displayDate|date_format:"%A, %m/%d/%y"}.<br>
                                                If you have questions or concerns, please contact <a
                                                    href="mailto:cade@markful.com"
                                                    style="color: #664D03; text-decoration: underline;">cade@markful.com</a>
                                                or
                                                message via Teams.
                                                {if $customTestMessage}
                                                    <br /><br />
                                                    {$customTestMessage}
                                                {/if}
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
{/if}