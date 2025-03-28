{* --------------------------------------------------------------------------
File: content:two-column-layout.tpl

Description:
- Takes a list of products (e.g., from getProducts) and groups them 
in pairs of two, then displays them in a two-column layout.
- Supports optional debug output to view the grouped data.

Usage Example:
{include 'content:two-column-layout' scope='parent'
products=$myProducts
secondaryColor='#F0F0F0'
stickerColor='#FFD700'
headingColor='#333333'
debug=1
}
-------------------------------------------------------------------------- *}

{* ---------------- DEFAULTS & VARIABLES ---------------- *}
{assign var="debug"          value=$debug|default:0} {* 1 = show debug info, 0 = hide *}
{assign var="secondaryColor" value=$secondaryColor|default:'#F0F0F0'}
{assign var="stickerColor"   value=$stickerColor|default:'#138b55'}
{assign var="stickerPosition"   value=$stickerPosition|default:'bottom'}
{assign var="headingColor"   value=$headingColor|default:'#0A1F44'}
{assign var="subheadingColor"   value=$subheadingColor|default:'#0A1F44'}
{assign var="withBackground"   value=$withBackground|default:1}
{assign var="backgroundColor"   value=$backgroundColor|default:'#ffffff'}
{assign var="imageMaxHeight"   value=$imageMaxHeight|default:"200px"}
{assign var="imageMinHeight"   value=$imageMinHeight|default:"auto"}
{assign var="itemPadding"   value=$itemPadding|default:"8px"}
{assign var="rowPadding"   value=$rowPadding|default:"15px 0 0 0"}
{assign var="withSubhead"   value=$withSubhead|default:1}
{assign var="showImageVariations"   value=$showImageVariations|default:0}
{assign var="globalDiscount"   value=$globalDiscount|default:''} {* New global discount variable *}
{assign var="nameFontSize"   value=$nameFontSize|default:'16px'} {* New font size variable *}
{assign var="textAlign"   value=$textAlign|default:'left'} {* New text alignment variable *}
{assign var="sectionOrder"   value=$sectionOrder|default:['image', 'sticker', 'heading', 'subheading']}
{* Default section order *}
{assign var="sectionSpacing" value=$sectionSpacing|default:"12px"} {* Consistent spacing between sections *}
{assign var="evenColumns" value=$evenColumns|default:0} {* Even columns *}

{* ---------------- VARIABLE MAPPING ---------------- *}
{assign var="nameField"      value=$nameField|default:'productName'}
{assign var="descField"      value=$descField|default:'description'}
{assign var="productSticker"  value=$productSticker|default:'productSticker'}
{assign var="urlField"       value=$urlField|default:'url'}
{assign var="imagesField"    value=$imagesField|default:'images'}
{assign var="idField"        value=$idField|default:'productID'}
{assign var="linkAttrField"  value=$linkAttrField|default:'linkAttribute'}

{* ---------------- GROUP PRODUCTS TWO-BY-TWO ---------------- *}
{assign var="groupedItems" value=[]}
{assign var="pair" value=[]}

{foreach from=$products item=product}
    {* Add each product to the temporary pair array *}
    {append var="pair" value=$product}
    {* Once the pair has two items, append it to groupedItems and reset *}
    {if count($pair) == 2}
        {append var="groupedItems" value=$pair}
        {assign var="pair" value=[]}
    {/if}
{/foreach}

{* If there's an incomplete pair left, add it to groupedItems *}
{if count($pair) > 0}
    {append var="groupedItems" value=$pair}
{/if}

{if $skuMatch == 1}
    {include 'content:get-categories' scope='parent'}
    {assign var="skuMatchCategories" value=$supCategories}
{/if}

{* ---------------- DEBUG OUTPUT (OPTIONAL) ---------------- *}
{if $debug == 1}
    <div
        style="background: #F8D7DA; border: 1px solid #F5C6CB; padding: 15px; margin: 15px 0; border-radius: 4px; color: #DC3545;">
        <strong style="font-size: 16px;">Debug Mode Active</strong>
    </div>

    <h2 style="color: #DC3545; margin-bottom: 10px;">Grouped Products</h2>
    <pre
        style="background: #F8D7DA; padding: 15px; border-radius: 4px; border: 1px solid #F5C6CB; color: #333; font-family: monospace; overflow-wrap: break-word;">
        {$JSON_PRETTY_PRINT = 128}
        {json_encode($groupedItems, $JSON_PRETTY_PRINT)}
        </pre>
{/if}

{* ---------------- SECTION RENDERING FUNCTIONS ---------------- *}
{function name="renderImage"}
    <tr style="width: 100%;">
        <td width="100%" align="center"
            style="text-align: center; display: block; padding-bottom: {if $showImageVariations == 1 && $item[$imagesField]|@count > 1}8px{else}{$sectionSpacing}{/if};">
            <table role="presentation" style="width: 100%; height: 100%;">
                <tr>
                    <td align="center" valign="middle" style="text-align: center; height: 100%;">
                        <a href="{$item[$urlField]}" {$nelRemoveLowEngagement} {$item[$linkAttrField]}
                            data-crdl-key="Two Column Row Image - {$item[$nameField]}" style="display: block;">
                            <img src="{$item[$imagesField][0]}" alt="{$item[$nameField]}" width="100%" class="fluid"
                                style="border:none; display: block; border-radius: 5px; max-height: {$imageMaxHeight}; object-fit: contain; min-height: {$imageMinHeight}"
                                border="0">
                        </a>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    {if $showImageVariations == 1 && $item[$imagesField]|@count > 1}
        <tr style="width: 70%; display: block; {if $withBackground == 1}padding-left: 12px; padding-right: 12px;{/if}">
            <td>
                <table role="presentation" style="width: 100%;">
                    <tr>
                        {assign var="maxImages" value=3}
                        {assign var="imageCount" value=0}
                        {* Get all images except first one *}
                        {assign var="remainingImages" value=[]}
                        {foreach from=$item[$imagesField] item=image name=images}
                            {if !$smarty.foreach.images.first}
                                {append var="remainingImages" value=$image}
                            {/if}
                        {/foreach}
                        {* Shuffle remaining images *}
                        {assign var="shuffledImages" value=$utils->shuffle($remainingImages)}
                        {* Display up to maxImages *}
                        {foreach from=$shuffledImages item=image name=shuffled}
                            {if $smarty.foreach.shuffled.index < $maxImages}
                                <td width="42" align="start">
                                    <a href="{$item[$urlField]}" {$nelRemoveLowEngagement}
                                        data-crdl-key="Two Column Row Image Variant - {$item[$nameField]}" {$item[$linkAttrField]}
                                        style="display: inline-block; padding: 3px;">
                                        <img src="{$image}" alt="{$item[$nameField]}" width="100%" class="fluid"
                                            style="border:none; border-radius: 5px; max-height: 36px; object-fit: contain;" border="0">
                                    </a>
                                </td>
                            {/if}
                        {/foreach}
                    </tr>
                </table>
            </td>
        </tr>
    {/if}
{/function}

{function name="renderSticker"}
    {if ($globalDiscount != '') || $item[$productSticker] || ($skuMatch == 1 && $skuMatchCategories|@count > 0 && $item.sku)}
        <tr>
            <td
                style="padding-bottom: {$sectionSpacing}; {if $withBackground == 1}padding-left: 12px; padding-right: 12px;{/if}">
                <table width="100%" cellspacing="0" cellpadding="0" style="text-align: start;">
                    <tr>
                        <td
                            style="font-family: Helvetica, arial, sans-serif; font-size: 12px; line-height: 125%; color: #ffffff; font-weight: bold; letter-spacing: 0.5px;">
                            <span
                                style="background-color: {$stickerColor}; border-radius: 5px; padding: 4px 13px; display: inline-block; text-transform: uppercase;">
                                {if $globalDiscount != ''}
                                    {$globalDiscount}
                                {elseif $item[$productSticker]}
                                    {$item[$productSticker]}
                                {else}
                                    {assign var="bestMatch" value=""}
                                    {assign var="bestMatchLength" value=0}
                                    {assign var="bestMatchCategory" value=null}
                                    {foreach from=$skuMatchCategories item=category}
                                        {assign var="categoryIdLength" value=$category.ID|strlen}
                                        {assign var="productIdPrefix" value=$item[$idField]|substr:0:$categoryIdLength}
                                        {if $category['productSticker'] !== "null" && $productIdPrefix == $category.id}
                                            {if $categoryIdLength > $bestMatchLength}
                                                {assign var="bestMatch" value=$category['productSticker']}
                                                {assign var="bestMatchLength" value=$categoryIdLength}
                                                {assign var="bestMatchCategory" value=$category}
                                            {/if}
                                        {/if}
                                    {/foreach}
                                    {$bestMatch}
                                {/if}
                            </span>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    {/if}
{/function}

{function name="renderHeading"}
    <tr>
        <td
            style="font-family: Helvetica, arial, sans-serif; font-size: {$nameFontSize}; color: {$headingColor}; text-align: {$textAlign}; font-weight: 700; line-height: 125%; padding-bottom: {if $sectionSpacing|strstr:'px'}{$sectionSpacing|replace:'px':''*0.75}px{else}{$sectionSpacing}{/if}; {if $withBackground == 1}padding-left: 12px; padding-right: 12px;{/if}">
            {$item[$nameField]}
        </td>
    </tr>
{/function}

{function name="renderSubheading"}
    {if $item[$descField] && $withSubhead == 1}
        <tr>
            <td
                style="font-family: Helvetica, arial, sans-serif; font-size: 13px; line-height: 125%; color: {$subheadingColor}; font-weight: normal; letter-spacing: 0.5px; font-style: italic; text-align: {$textAlign}; {if $withBackground == 1}padding-left: 12px; padding-right: 12px;{/if}">
                {$item[$descField]}
            </td>
        </tr>
    {/if}
{/function}

{* ---------------- RENDER GROUPS IN TWO-COLUMN LAYOUT ---------------- *}
{foreach from=$groupedItems item=group}
    <div>
        <table width="600" border="0" cellspacing="0" cellpadding="0"
            style="background-color: {$backgroundColor}; margin:0 auto; padding-bottom: {if $sectionSpacing|strstr:'px'}{$sectionSpacing|replace:'px':''*1.5}px{else}{$sectionSpacing}{/if};"
            class="width-100" bgcolor="{$backgroundColor}">
            <tr>
                <td valign="top" bgcolor="{$backgroundColor}"
                    style="background-color: {$backgroundColor}; padding: {$rowPadding}; font-family: Helvetica, arial, sans-serif;"
                    class="width-100">
                    <table width="575" border="0" cellspacing="0" cellpadding="0" style="margin:0 auto;" class="container">
                        <tr>
                            {foreach from=$group item=item}
                                <td width="255.5" valign="top"
                                    style="padding: 0 8px; font-family: Helvetica, arial, sans-serif; {if $withBackground == 1}background-color: {$secondaryColor}; border-radius: 5px;{/if}">
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0"
                                        style="margin:0 auto; padding: {$itemPadding}; {if $withBackground == 1}padding-bottom: {if $sectionSpacing|strstr:'px'}{$sectionSpacing|replace:'px':''* 1.125}px{else}{$sectionSpacing}{/if};{/if} font-family: Helvetica, arial, sans-serif;">
                                        {foreach from=$sectionOrder item=section name=sections}
                                            {if $section == 'image'}
                                                {renderImage}
                                            {elseif $section == 'sticker'}
                                                {renderSticker}
                                            {elseif $section == 'heading'}
                                                {renderHeading}
                                            {elseif $section == 'subheading'}
                                                {renderSubheading}
                                            {/if}
                                        {/foreach}
                                    </table>
                                </td>
                                {if $item@first && $withBackground == 1}
                                    <td width="16" valign="top" style="font-family: Helvetica, arial, sans-serif;">
                                    </td>
                                {/if}
                            {/foreach}
                            {if $evenColumns == 1 && $group|@count == 1}
                                <td width="255.5" valign="top"
                                    style="padding: 0 8px; font-family: Helvetica, arial, sans-serif;">
                                </td>
                            {/if}
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
{/foreach}

{* ---------------------------------------------------------------------------
Example Usage (Optional)
Set example=1 to display usage instructions inline:
{include 'content:two-column-layout' scope='parent' products=$myProducts debug=1 example=1}
--------------------------------------------------------------------------- *}

{if $example|default:0 == 1}
    <div
        style="background: #E2F0D9; border: 1px solid #A8D08D; padding: 15px; margin: 15px 0; border-radius: 4px; color: #548235;">
        <strong style="font-size: 16px;">Example Usage Instructions</strong>
    </div>

    <div style="padding: 20px; border-radius: 4px; border: 1px solid #A8D08D;">
        <h3>How to Include This Template:</h3>
        <pre style="background: #F5F5F5; padding: 15px; border-radius: 4px;">
        {literal}
                {* Basic Usage *}
                {include 'content:two-column-layout' scope='parent'
                products=$myProducts
                }

                {* With All Styling Options *}
                {include 'content:two-column-layout' scope='parent'
                products=$myProducts
                secondaryColor='#F0F0F0'
                stickerColor='#FFD700'
                headingColor='#333333'
                nameFontSize='18px'
                globalDiscount='SAVE 20%'
                debug=1
                }

                {* With Custom Field Mapping *}
                {include 'content:two-column-layout' scope='parent'
                products=$myProducts
                nameField='title'
                descField='shortDescription'
                productSticker='saleTag'
                urlField='productUrl'
                imagesField='imageUrls'
                idField='sku'
                }
        {/literal}
        </pre>

        <h4>Available Parameters:</h4>
        <ul>
            <li><strong>products</strong>: Array of product objects to display. (Required)</li>
            <li><strong>secondaryColor</strong>: Background color for product cards. (Optional, defaults to #F0F0F0)</li>
            <li><strong>stickerColor</strong>: Background color for discount badges. (Optional, defaults to #138b55)</li>
            <li><strong>headingColor</strong>: Color for product names. (Optional, defaults to #0A1F44)</li>
            <li><strong>nameFontSize</strong>: Font size for product names. (Optional, defaults to 16px)</li>
            <li><strong>globalDiscount</strong>: Global discount text to show on all products. (Optional)</li>
            <li><strong>debug</strong>: Toggle debug mode to show grouped item data. (Optional, defaults to 0)</li>
            <li><strong>example</strong>: Toggle example usage instructions. (Optional, defaults to 0)</li>
        </ul>

        <h4>Field Mapping Options:</h4>
        <ul>
            <li><strong>nameField</strong>: Field name for product title. (Optional, defaults to 'productName')</li>
            <li><strong>descField</strong>: Field name for product description. (Optional, defaults to 'description')</li>
            <li><strong>productSticker</strong>: Field name for product discount. (Optional, defaults to 'discount')</li>
            <li><strong>urlField</strong>: Field name for product URL. (Optional, defaults to 'url')</li>
            <li><strong>imagesField</strong>: Field name for product images array. (Optional, defaults to 'images')</li>
            <li><strong>idField</strong>: Field name for product ID. (Optional, defaults to 'productID')</li>
        </ul>
    </div>
{/if}

{if $debug == 1}
    {$debug = 0}
{/if}

{* Reset all variables to prevent scope overflow *}
{assign var="debug" value=""}
{assign var="stickerColor" value=""}
{assign var="stickerPosition" value=""}
{assign var="subheadingColor" value=""}
{assign var="withBackground" value=""}
{assign var="backgroundColor" value=""}
{assign var="imageMaxHeight" value=""}
{assign var="imageMinHeight" value=""}
{assign var="itemPadding" value=""}
{assign var="rowPadding" value=""}
{assign var="withSubhead" value=""}
{assign var="showImageVariations" value=""}
{assign var="globalDiscount" value=""}
{assign var="nameFontSize" value=""}
{assign var="textAlign" value=""}
{assign var="sectionOrder" value=""}
{assign var="sectionSpacing" value=""}
{assign var="nameField" value=""}
{assign var="descField" value=""}
{assign var="productSticker" value=""}
{assign var="urlField" value=""}
{assign var="imagesField" value=""}
{assign var="idField" value=""}
{assign var="linkAttrField" value=""}
{assign var="groupedItems" value=""}
{assign var="pair" value=""}