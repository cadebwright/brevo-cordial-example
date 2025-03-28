{include 'content:header' scope="parent"}

{include 'content:get-categories' scope="parent"
    query=['id' => 'BC']
    limit=1
}

{include 'content:get-products' scope='parent'
    query=[
      "manufacturerName" => ["in" => [{$contact['company-gbs-company-id']|default:'00-100-00000'}]],
      "category" => "Business Cards"
    ]
    limit=10
}

{assign var="updatedProducts" value=[]}
{foreach from=$products item=product}
    {assign var="updatedProduct" value=$product}
    {if $contact['company-gbs-company-id']|default:'00-100-00000' != '00-100-00000'}
        {$updatedProduct.description = ""}
    {else}
        {$updatedProduct.description = ""}
    {/if}
    {append var="updatedProducts" value=$updatedProduct}
{/foreach}
{assign var="products" value=$updatedProducts}


{assign var="businessCards" value=[
  [
    "Name" => "Standard<br />Business Cards",
    "shortDescription" => "16pt Stock, Matte Finish, Square Corners",
    "url" => "https://www.markful.com/business-cards",
    "ImagePath" => ["https://images.cordial.com/1225/1080x1080/2025-CardStack.jpg"]
  ],
  [
    "Name" => "Easy<br />Customization",
    "shortDescription" => "Upload your design or use your company's templates for a polished look in seconds.",
    "url" => "https://www.markful.com/business-cards",
    "ImagePath" => ["https://images.cordial.com/1225/1080x1080/2025-Card-in-editor.jpg"]
  ],
  [
    "Name" => "Durable &<br />Versatile",
    "shortDescription" => "Reliable, professional, and <b>anything but standard</b>.",
    "url" => "https://www.markful.com/business-cards", 
    "ImagePath" => ["https://images.cordial.com/1225/1080x1080/2025-HandHolding-BCs.jpg"]
  ],
  [
    "Name" => "High Impact,<br />Low Price",
    "shortDescription" => "Premium materials and vibrant colors—without the premium price.",
    "url" => "https://www.markful.com/business-cards",
    "ImagePath" => ["https://images.cordial.com/1225/1080x1080/2025-Presenting-BC.jpg"]
  ]
]}

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" style="margin: 0px auto;" class="width-100">
            <tr>
                <td bgcolor="{$primaryColor}" style="background-color: {$primaryColor};">
                    <table width="600" align="center" cellspacing="0" cellpadding="0" border="0" class="width-100"
                        style="margin: 0 auto;">
                            <tr>
                                <td>
                                    <table width="560" align="center" cellspacing="0" cellpadding="0" border="0"
                                        class="container">
                                            <tr>
                                                <td
                                                    style="font-family: Helvetica, arial, sans-serif; font-size:12px; color: #ffffff; text-align:center; padding-top:7px; padding-bottom: 0px;">
                                                    A professional card keeps you top of mind after every conversation.
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

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
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
    </table>
</div>

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tr>
            <td bgcolor="#ffffff" style="padding-top:24px; padding-bottom: 0px; background-color:#ffffff;">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td align="left" style="text-align: left;" class="width-100">
                            <a href="https://www.markful.com/business-cards" {$nelRemoveLowEngagement}
                                data-crdl-key="Markful Logo">
                                <img src="https://images.cordial.com/1225/251x40/Logo-Markful-2c.png" width="200"
                                    alt="Markful Logo"
                                    style="display:block; border:none; outline:none; text-decoration:none;" border="0">
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
        <tr>
            <td bgcolor="#ffffff" style="padding-top:32px; padding-bottom:0px; background-color:#ffffff;">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td
                            style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:52px; line-height:115%; padding-top:0px; padding-bottom: 16px; font-weight:800; margin: 0 auto; display: block;">
                           Your Brand,<br />Front and Center
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

{include 'content:two-column-layout'
      scope='parent'
      products=array_slice($products, 0, 2)
      withBackground=0
      imageMaxHeight="none"
      nameFontSize="24px"
      itemPadding="0"
      rowPadding="0"
      skuMatch=1
      sectionOrder=['image']
      sectionSpacing="0"
      withBackground=1
}

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tr>
            <td bgcolor="#ffffff" style="padding-top:16px; padding-bottom:0px; background-color:#ffffff;">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td
                            style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:22px; line-height:165%; padding-top:0px; padding-bottom: 16px; font-weight:400; margin: 0 auto; display: block;">
                            Your business card is more than just contact info—it’s a tangible reminder of your
                            brand. When meeting potential clients, at open houses, or networking with fellow agents,
                            a polished, professional card makes sure you’re remembered.
                        </td>
                    </tr>

                    <tr>
                        <td style="padding-bottom: 16px;">
                            <table>
                                <tr>
                                    <td style="text-align:center; background-color:{$primaryColor}; padding:15px 55px; border-radius: 3px;"
                                        class="width-100">
                                        <a href="https://www.markful.com/business-cards"
                                            style="font-family:sans-serif; font-size:16px; line-height:18px; font-weight: bold; text-align:center; text-decoration:none; color:#ffffff;"
                                            data-crdl-key="Main CTA Button - Top" {$nelRemoveLowEngagement}>
                                            Shop Business Cards
                                        </a>
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

<div>
    <table width="600" cellpadding="0" cellspacing="0" border="0" class="width-100" style="margin: 0 auto;">
        <tbody>
            <tr>
                <td bgcolor="{$primaryColor}"
                    style="padding-top:0px; padding-bottom: 0px; background-color:{$primaryColor};" class="width-100">
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


{$highlights = [
    [
        "productName" => "Free Double<br />Sided Printing",
        "description" => "Double the impact<br />at no extra cost",
        "url" => "https://www.markful.com/business-cards",
        "images" => ["https://images.cordial.com/1225/512x512/icon-check-circle_BK.png"]
    ],
    [
        "productName" => "Quality<br />Cards",
        "description" => "Top-quality cards,<br />expert craftsmanship",
        "url" => "https://www.markful.com/business-cards",
        "images" => ["https://images.cordial.com/1225/576x512/icon-gem_BK.png"]
    ],
    [
        "productName" => "Luxury<br />Feel",
        "description" => "Premium textures for<br />a standout impression",
        "url" => "https://www.markful.com/business-cards",
        "images" => ["https://images.cordial.com/1225/576x512/start-icon.png"]
    ],
    [
        "productName" => "Low<br />Minimums",
        "description" => "Flexible ordering<br />options",
        "url" => "https://www.markful.com/business-cards",
        "images" => ["https://images.cordial.com/1225/512x512/icon-sync-alt_BK.png"]
    ]
]}


{include 'content:two-column-layout'
    scope='parent'
    products=$highlights
    backgroundColor={$primaryColor}
imageMaxHeight="50px"
headingColor="#ffffff"
subheadingColor="#ffffff"
nameFontSize="32px"
withBackground=0
skuMatch=1
sectionOrder=['image', "sticker", "heading"]
sectionSpacing="12px"
textAlign="center"
}

{$headingColor = "#0a1f44"}


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
        <tr>
            <td bgcolor="#ffffff" style="padding-top:32px; padding-bottom:0px; background-color:#ffffff;">
                <table width="560" cellpadding="0" cellspacing="0" border="0" align="center" style="margin: 0 auto;"
                    class="container">
                    <tr>
                        <td
                            style="font-family: Helvetica, arial, sans-serif; text-align:left; color:{$headingColor}; font-size:52px; line-height:115%; padding-top:0px; padding-bottom: 16px; font-weight:800; margin: 0 auto; display: block;">
                            Find the Perfect Business Card for You
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>

{include 'content:two-column-layout'
    scope='parent'
    products=array_slice($products, 2, 8)
    withBackground=1
    skuMatch=1
    sectionOrder=['image', "sticker", "heading", "subheading"]
    sectionSpacing="12px"
    textAlign="center"
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
                                            <a href="https://www.markful.com/business-cards"
                                                style="font-family:sans-serif; font-size:16px; line-height:18px; font-weight: bold; text-align:center; text-decoration:none; color:#ffffff;"
                                                data-crdl-key="Main CTA Button - Top" {$nelRemoveLowEngagement}>
                                                Shop Business Cards
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