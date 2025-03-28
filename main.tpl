{include 'content:baseball-teams' 
scope="parent" 
forceZip=1
}

{include 'content:header' scope="parent" }


{include 'content:get-categories' scope="parent"
query=['id' => 'BB']
limit=1
}

{$baseballUrl = 'https://www.markful.com/baseball'}

{if $preferredTeam}
    {$baseballUrl = "https://www.markful.com{$preferredTeam.teamUrl}"}
{/if}

{if $preferredTeam}
    {* Define product types and their corresponding image indices *}
    {assign var="productTypes" value=[
    ['type' => 'Standard Full Magnets', 'index' => 1],
    ['type' => 'Jersey Shape', 'index' => 0],
    ['type' => 'Baseball Shape', 'index' => 0],
    ['type' => 'Small Full Magnets', 'index' => 2],
    ['type' => 'Mailer Magnet Cards', 'index' => 0],
    ['type' => 'Standard Magnet Cards', 'index' => 2]
]}

    {* Create array to store mapped team objects *}
    {assign var="mappedTeams" value=[]}

    {* Generate team objects for each product type *}
    {foreach from=$productTypes item=product}
        {assign var="teamObject" value=[
        'Name' => $product.type,
        'shortDescription' => $preferredTeam.Name,
        'teamUrl' => "https://www.markful.com{$preferredTeam.teamUrl}",
        'ImagePath' => [
        str_replace(
        'https://blob.markful.com',
        'https://markful.b-cdn.net',
        $preferredTeam[$product.type][$product.index]
        )|cat:'?width=450&format=jpeg'
        ],
        'sku' => $preferredTeam.sku
        ]}
        {append var="mappedTeams" value=$teamObject}
    {/foreach}

    {* Define MLB Opening Day matchups with full team names *}
    {assign var="mlbMatchups" value=[
    "Milwaukee Brewers" => "New York Yankees",
    "New York Yankees" => "Milwaukee Brewers",
    "Baltimore Orioles" => "Toronto Blue Jays",
    "Toronto Blue Jays" => "Baltimore Orioles",
    "Boston Red Sox" => "Texas Rangers",
    "Texas Rangers" => "Boston Red Sox",
    "Philadelphia Phillies" => "Washington Nationals",
    "Washington Nationals" => "Philadelphia Phillies",
    "Cleveland Guardians" => "Kansas City Royals",
    "Kansas City Royals" => "Cleveland Guardians",
    "New York Mets" => "Houston Astros",
    "Houston Astros" => "New York Mets",
    "San Francisco Giants" => "Cincinnati Reds",
    "Cincinnati Reds" => "San Francisco Giants",
    "Atlanta Braves" => "San Diego Padres",
    "San Diego Padres" => "Atlanta Braves",
    "Los Angeles Angels" => "Chicago White Sox",
    "Chicago White Sox" => "Los Angeles Angels",
    "Pittsburgh Pirates" => "Miami Marlins",
    "Miami Marlins" => "Pittsburgh Pirates",
    "Minnesota Twins" => "St. Louis Cardinals",
    "St. Louis Cardinals" => "Minnesota Twins",
    "Detroit Tigers" => "Los Angeles Dodgers",
    "Los Angeles Dodgers" => "Detroit Tigers",
    "Chicago Cubs" => "Arizona Diamondbacks",
    "Arizona Diamondbacks" => "Chicago Cubs",
    "Oakland Athletics" => "Seattle Mariners",
    "Seattle Mariners" => "Oakland Athletics"
    ]}

    {* Initialize opponent object *}
    {assign var="opponentTeam" value=false}

    {* Find opponent team name *}
    {if $preferredTeam && isset($mlbMatchups[$preferredTeam.Name])}
        {assign var="opponentTeamName" value=$mlbMatchups[$preferredTeam.Name]}

        {* Search through $teams to find the full opponent object *}
        {foreach from=$teams item=team}
            {if $team.Name == $opponentTeamName}
                {* Generate team objects for each product type *}
                {foreach from=$productTypes item=product}
                    {assign var="teamObject" value=[
                    'Name' => $team.Name,
                    'shortDescription' => $product.type,
                    'teamUrl' => "https://www.markful.com{$team.teamUrl}",
                    'ImagePath' => [
                    str_replace(
                    'https://blob.markful.com',
                    'https://markful.b-cdn.net',
                    $team[$product.type][$product.index]
                    )|cat:'?width=450&format=jpeg'
                    ],
                    'sku' => $team.sku
                    ]}

                    {assign var="opponentTeam" value=$teamObject}
                {/foreach}
                {break}
            {/if}
        {/foreach}
    {/if}

{elseif $teams}
    {assign var="productTypes" value=[
    'Mailer Magnet Cards',
    'Jersey Shape',
    'Standard Full Magnets',
    'Baseball Shape',
    'Small Full Magnets',
    'Standard Magnet Cards',
    'Standard Full Magnets',
    'Jersey Shape'
    ]}

    {assign var="mappedTeams" value=[]}
    {foreach from=$teams item=team name=teamLoop}
        {if $smarty.foreach.teamLoop.index < 8}
            {* Get product type based on current index *}
            {assign var="currentType" value=$productTypes[$smarty.foreach.teamLoop.index]}

            {* Get random image for the current type *}
            {assign var="typeImages" value=$team[$currentType]}
            {assign var="shuffledImages" value=$utils->shuffle($typeImages)}
            {assign var="randomImage" value=$shuffledImages[0]}

            {* Set link attribute based on team id *}
            {if $team.id}
                {assign var="linkAttr" value="crdl-setAttribute-preferred-baseball-team='`$team.id`'"}
            {else}
                {assign var="linkAttr" value=""}
            {/if}

            {* Create team object with processed image *}
            {assign var="teamObject" value=[
            'Name' => $team.Name,
            'shortDescription' => $currentType,
            'teamUrl' => "https://www.markful.com{$team.teamUrl}",
            'ImagePath' => [
            str_replace(
            'https://blob.markful.com',
            'https://markful.b-cdn.net',
            $randomImage
            )|cat:'?width=450&format=jpeg'
            ],
            'linkAttribute' => $linkAttr,
            'sku' => "BB"
            ]}

            {append var="mappedTeams" value=$teamObject}
        {/if}
    {/foreach}
{/if}

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" style="margin: 0px auto;" class="width-100">
        <tbody>
            <tr>
                <td bgcolor="{$primaryColor}" style="background-color: {$primaryColor};">
                    <table width="600" align="center" cellspacing="0" cellpadding="0" border="0" class="width-100"
                        style="margin: 0 auto;">
                        <tbody>
                            <tr>
                                <td>
                                    <table width="560" align="center" cellspacing="0" cellpadding="0" border="0"
                                        class="container">
                                        <tbody>
                                            <tr>
                                                <td
                                                    style="font-family: Helvetica, arial, sans-serif; font-size:12px; color: #ffffff; text-align:center; padding-top:7px; padding-bottom: 0px;">
                                                    It’s game time—make sure your clients see your brand every time they
                                                    check the schedule.
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$primaryColor}"
                    style="padding-top:0px; padding-bottom: 0px; background-color:{$primaryColor};" class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" class="width-100"
                        style="margin: 0 auto;">
                        <tr>
                            <td align="center" style="text-align: center; "><img src="{$backgroundUrlTop}" alt=""
                                    width="600" class="fluid"
                                    style="display:block; border:none; outline:none; text-decoration:none;" border="0">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="#ffffff" style="padding-top:24px; padding-bottom: 0px; background-color:#ffffff;">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                        class="container">
                        <tr>
                            <td align="left" style="text-align: left;" class="width-100">
                                <a href="{$baseballUrl}" {$nelRemoveLowEngagement} data-crdl-key="Markful Logo">
                                    <img src="https://images.cordial.com/1225/251x40/Logo-Markful-2c.png" width="200"
                                        alt="Markful Logo"
                                        style="display:block; border:none; outline:none; text-decoration:none;"
                                        border="0">
                                </a>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="#ffffff" style="padding-top:32px; padding-bottom:0px; background-color:#ffffff;">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                        class="container">
                        <tr>
                            <td
                                style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:52px; line-height:115%; padding-top:0px; padding-bottom: 16px; font-weight:800; margin: 0 auto; display: block;">
                                Baseball Season Starts Today!
                            </td>
                        </tr>

                        {if $opponentTeam && $preferredTeam}
                            <tr>
                                <td
                                    style="font-family: Helvetica, arial, sans-serif; text-align:left; color:#555555; font-size:18px; line-height:115%; padding-top:0px; padding-bottom: 16px; font-weight:800; margin: 0 auto; display: block; text-transform: uppercase;">
                                    {$preferredTeam.Name} <span
                                        style="font-size: 13px; font-weight: 800;">&nbsp;&nbsp;vs.&nbsp;&nbsp;</span>
                                    {$opponentTeam.Name}
                                </td>
                            </tr>
                        {/if}

                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

{assign var="heroImages" value=array_slice($mappedTeams, 0, 2)}

{if $opponentTeam}
    {assign var="heroImages" value=[
    $mappedTeams[0],
    $opponentTeam
    ]}
{/if}

{include 'content:two-column-layout'
scope='parent'
products=array_slice($heroImages, 0, 2)    
nameField='Name'
descField='shortDescription'
urlField='teamUrl'
imagesField='ImagePath'
idField='sku'
withBackground=0
imageMaxHeight="none"
nameFontSize="24px"
itemPadding="0"
rowPadding="0"
skuMatch=1
sectionOrder=['image']
sectionSpacing="0"
}

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="#ffffff" style="padding-top:16px; padding-bottom:0px; background-color:#ffffff;">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                        class="container">

                        {if $preferredTeam}
                            <tr>
                                <td
                                    style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:13px; line-height:115%; font-weight:600; text-transform: uppercase; background-color: {$secondaryColor}; padding: 6px 16px; border-radius: 4px;">
                                    <a href="https://www.markful.com/baseball" {$nelRemoveLowEngagement}
                                        style="text-decoration: none; color: {$headingColor}; letter-spacing: 0.4px;"
                                        crdl-setAttribute-preferred-baseball-team="">
                                        <table>
                                            <tr>
                                                <td>
                                                    <img src="https://images.cordial.com/1225/150x150/baseball_heart_icon.png"
                                                        width="75" alt="Baseball Heart Icon" border="0">
                                                </td>
                                                <td>
                                                    <span style="font-weight: 300; display: block;">Your Preferred
                                                        Team</span>
                                                    <span
                                                        style="padding: 6px 0; display: block;">{$preferredTeam.Name}</span>
                                                    <span
                                                        style="font-weight: 300; display: block; text-transform: none; text-decoration: none;">Change
                                                        Teams →</span>
                                                </td>
                                            </tr>
                                        </table>
                                    </a>
                                </td>
                            </tr>
                        {/if}

                        <tr>
                            <td style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:22px; line-height:165%; padding-bottom: 16px; font-weight:400; margin: 0 auto; {if $preferredTeam}padding-top:16px{else}padding-top:0px{/if}"
                                class="width-100">
                                {if $opponentTeam}
                                    Today’s matchup: <a href="{$baseballUrl}"
                                        {$nelRemoveLowEngagement}>{$preferredTeam.Name}</a> vs. <a
                                        href="{$opponentTeam.teamUrl}" {$nelRemoveLowEngagement}>{$opponentTeam.Name}</a>.
                                    <br /><br />
                                    Baseball magnets work hard all season—so you don’t have to. No setup. No chasing leads.
                                    Just your name where clients look every day. It’s game time. Make sure your brand is in
                                    play.
                                {else}
                                    No setup. No chasing leads. Just your name where your clients look every day.
                                    Baseball magnets deliver value all season long—without lifting a finger.<br /><br />
                                    It’s game time. Make sure your brand is playing too.
                                {/if}
                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 22px 0 16px 0;">
                                <table>
                                    <tr>
                                        <td style="text-align:center; background-color:{$primaryColor}; padding:15px 55px; border-radius: 3px;"
                                            class="width-100">
                                            <a href="{$baseballUrl}"
                                                style="font-family:sans-serif; font-size:16px; line-height:18px; font-weight: bold; text-align:center; text-decoration:none; color:#ffffff;"
                                                data-crdl-key="Main CTA Button - Top" {$nelRemoveLowEngagement}>
                                                Shop 2025 Baseball
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tr>
            <td bgcolor="#ffffff" style="padding-top:32px; padding-bottom:52px; background-color:#ffffff;"
                class="width-100">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:13px; line-height:115%; font-weight:600; text-transform: uppercase; background-color: {$secondaryColor}; padding: 6px 16px; border-radius: 4px;"
                            class="width-100">
                            <a href="mailto:info@markful.com" {$nelRemoveLowEngagement}
                                style="text-decoration: none; color: {$headingColor}; letter-spacing: 0.4px;">
                                <table>
                                    <tr>
                                        <td>
                                            <img src="https://images.cordial.com/1225/600x600/jared-headshot.png"
                                                width="95" alt="Markful Account Manager" border="0"
                                                style="padding-right: 12px;">
                                        </td>
                                        <td>
                                            <span style="font-weight: 300; display: block; letter-spacing: 0.5px;">
                                                How Can I Help?
                                            </span>
                                            <span
                                                style="padding: 6px 0; display: block; line-height: 150%; letter-spacing: 0.25px; font-size: 16px;">
                                                I’m happy to answer any<br />questions about your order!
                                            </span>
                                            <span
                                                style="font-weight: 300; display: block; text-transform: none; text-decoration: none; letter-spacing: 0.5px;">Reach
                                                out →</span>
                                        </td>
                                    </tr>
                                </table>
                            </a>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$secondaryColor}"
                    style="padding-top:0px; padding-bottom: 0px; background-color:{$secondaryColor};" class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" class="width-100"
                        style="margin: 0 auto;">
                        <tr>
                            <td align="center" style="text-align: center; "><img src="{$backgroundUrlBottom}" alt=""
                                    width="600" class="fluid"
                                    style="display:block; border:none; outline:none; text-decoration:none;" border="0">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$secondaryColor}"
                    style="padding-top:32px; padding-bottom: 16px; background-color:{$secondaryColor};"
                    class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" class="width-100"
                        style="margin: 0 auto;">
                        <tr>
                            <td
                                style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:52px; line-height:115%; padding-top:0px; padding-bottom: 16px; font-weight:800; margin: 0 auto; display: block;">
                                {if $preferredTeam}
                                    Fridge-Ready.<br />Client-Approved.
                                {else}
                                    Pick Your Team,<br />Make Your Mark
                                {/if}
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>


{include 'content:two-column-layout'
scope='parent'
products=array_slice($mappedTeams, 2, 8)
nameField='Name'
descField='shortDescription'
urlField='teamUrl'
imagesField='ImagePath'
idField='sku'
withBackground=0
backgroundColor="{$secondaryColor}"
imageMaxHeight="none"
nameFontSize="24px"
itemPadding="0"
rowPadding="0"
skuMatch=1
sectionOrder=['image', 'sticker', 'heading', 'subheading']
sectionSpacing="12px"
}


<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$secondaryColor}"
                    style="padding-top:32px; padding-bottom:32px; background-color:{$secondaryColor};"
                    class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                        class="container">
                        <tr>
                            <td align="start" class="width-100" style="padding-bottom:32px;">
                                <table>
                                    <tr>
                                        <td style="text-align:center; background-color: {$primaryColor}; padding:15px 55px; border-radius: 3px;"
                                            class="width-100">
                                            <a href="{$baseballUrl}"
                                                style="font-family:sans-serif; font-size:16px; line-height:18px; font-weight: bold; text-align:center; text-decoration:none; color:#ffffff;"
                                                data-crdl-key="Main CTA Button - Top" {$nelRemoveLowEngagement}
                                                {$teamAttribute_}>
                                                Shop 2025 Baseball
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>


<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$secondaryColor}"
                    style="padding-top:0px; padding-bottom: 0px; background-color:{$secondaryColor};" class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" class="width-100"
                        style="margin: 0 auto;">
                        <tr>
                            <td align="center" style="text-align: center; "><img src="{$backgroundUrlTop}" alt=""
                                    width="600" class="fluid"
                                    style="display:block; border:none; outline:none; text-decoration:none;" border="0">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>


<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tr>
            <td bgcolor="#ffffff" style="padding-top:0px; padding-bottom:0px; background-color:#ffffff;"
                class="width-100">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td
                            style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:48px; line-height:115%; padding-top:24px; font-weight:800; padding-bottom: 0px;">
                            Baseball Accessories
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

{assign var="accessories" value=[
[
'Name' => 'Baseball Inserts',
'shortDescription' => 'Personalize your mailings for a lasting impact',
'teamUrl' => 'https://www.markful.com/baseball-inserts',
'ImagePath' => ['https://images.cordial.com/1225/450x450/baseball-inserts.jpg']
],
[
'Name' => 'Baseball Envelopes',
'shortDescription' => 'Deliver schedules with a polished, professional touch',
'teamUrl' => 'https://www.markful.com/baseball-envelopes',
'ImagePath' => ['https://images.cordial.com/1225/450x450/accessories-baseball-envelopes.jpg']
],
[
'Name' => 'Envelope Sealers',
'shortDescription' => 'Secure your mailers with a seamless finish',
'teamUrl' => 'https://www.markful.com/envelope-sealers-baseball',
'ImagePath' => ['https://images.cordial.com/1225/450x450/baseball-envelope-sealer.jpg']
],
[
'Name' => 'Doorknob Bags',
'shortDescription' => 'Take your marketing straight to their doorstep',
'teamUrl' => 'https://www.markful.com/door-knobs',
'ImagePath' => ['https://images.cordial.com/1225/450x450/doorknob-bag-royale.jpeg']
]
]}

{include 'content:two-column-layout'
scope='parent'
products=$utils->shuffle($accessories)
nameField='Name'
descField='shortDescription'
urlField='teamUrl'
imagesField='ImagePath'
idField='sku'
withBackground=0
imageMaxHeight="none"
nameFontSize="24px"
skuMatch=1
stickerSubheading=""
}


<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100"
        style="margin: 0 auto; padding-top:16px; background-color: #ffffff;" bgcolor="#ffffff">
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="#ffffff" style="padding-top:0px; padding-bottom:32px; background-color:#ffffff;"
                    class="width-100">
                    <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                        class="container">
                        <tr>
                            <td align="start" class="width-100" style="padding-bottom:32px;">
                                <table>
                                    <tr>
                                        <td style="text-align:center; background-color:{$primaryColor}; padding:15px 55px; border-radius: 3px;"
                                            class="width-100">
                                            <a href="{$baseballUrl}"
                                                style="font-family:sans-serif; font-size:16px; line-height:18px; font-weight: bold; text-align:center; text-decoration:none; color:#ffffff;"
                                                data-crdl-key="Main CTA Button - Top" {$nelRemoveLowEngagement}
                                                {$teamAttribute_}>
                                                Shop Baseball Accessories
                                            </a>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </tbody>
    </table>
</div>


{include 'content:footer' scope="parent"}