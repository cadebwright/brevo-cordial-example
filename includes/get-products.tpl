
{* --------------------------------------------------------------------------
   Description:
   - Similar to the category info file, retrieves product data using $utils->getProducts().
   - Provides a debug section to print out queries, limits, and resulting data.

   Usage Example:
   {include 'content:product-info' scope='parent' 
       query=["manufacturerName" => ["in" => ["00-100-00000"]], "category" => "Calendars", "tags" => ["notIn" => ["Tented Desk Calendar"]]] 
       limit=4
       debug=1
   }
   -------------------------------------------------------------------------- *}

{* ---------------- DEFAULTS & VARIABLES ---------------- *}
{assign var="defaultQuery" value=[
    "manufacturerName" => ["in" => [{$contact['company-gbs-company-id']|default:'00-100-00000'}]],
"category" => "",
"tags" => ["notIn" => ['']]
]}
{assign var="defaultLimit" value=4}
{assign var="defaultCacheMinutes"   value=3}

{* Debug style defaults *}
{assign var="debug"          value=$debug|default:0} {* 1 to enable debug, 0 to disable *}
{assign var="debugColor"     value="#DC3545"}
{assign var="debugBgColor"   value="#F8D7DA"}
{assign var="debugBorderColor" value="#F5C6CB"}

{* ---------------- BUILD PRODUCT QUERY ---------------- *}
{assign var="product_records" value=[
    'key'   => 'products',
    'query' => $query|default:$defaultQuery,
    'limit' => $limit|default:$defaultLimit,
    "cache" => $cacheMinutes|default:$defaultCacheMinutes
]}

{* ---------------- FETCH PRODUCT DATA ---------------- *}
{$product_records.data = $utils->getProducts(
    $product_records.query,
    $product_records.limit,
    [],
    $product_records.cache
)}

{* --------------- OUTPUT PRODUCTS DATA TO VARIABLE --------------- *}
{assign var="products" value=$product_records.data}

{* ---------------- OPTIONAL DEBUG OUTPUT ---------------- *}
{if $debug == 1}
  <div
    style="background: {$debugBgColor}; border: 1px solid {$debugBorderColor}; padding: 15px; margin: 15px 0; border-radius: 4px; color: {$debugColor};">
    <strong style="font-size: 16px;">Debug Mode Active</strong>
  </div>

  <h1 style="color: {$debugColor}; font-size: 24px; margin-bottom: 20px;">Product Data</h1>
  <pre
    style="background: {$debugBgColor}; padding: 20px; border-radius: 4px; border: 1px solid {$debugBorderColor}; color: #333; font-family: monospace;">
      {$JSON_PRETTY_PRINT = 128}
      <br />
      <span style="color: {$debugColor};">product_records.key:</span> {$product_records.key}<br />
      <span style="color: {$debugColor};">product_records.query:</span> {json_encode($product_records.query, $JSON_PRETTY_PRINT)}<br />
      <span style="color: {$debugColor};">product_records.limit:</span> {$product_records.limit}<br />
      <br />
      {json_encode($product_records.data, $JSON_PRETTY_PRINT)}
      </pre>
  <br>
  <hr style="border: 0; border-top: 1px solid {$debugBorderColor}; margin: 30px 0;"><br>
{/if}

{* ---------------- EXAMPLE USAGE OUTPUT ---------------- *}
{if $example|default:0 == 1}
  <div
    style="background: #E2F0D9; border: 1px solid #A8D08D; padding: 15px; margin: 15px 0; border-radius: 4px; color: #548235;">
    <strong style="font-size: 16px;">Example Usage Instructions</strong>
  </div>

  <div style="padding: 20px; border-radius: 4px; border: 1px solid #A8D08D; margin-bottom: 30px;">
    <h3>How to Include This Template:</h3>
    <pre style="background: #F5F5F5; padding: 15px; border-radius: 4px;">
    {literal}
        {* Basic Usage *}
        {include 'content:product-info' scope='parent'}

        {* With Custom Query *}
        {include 'content:product-info' scope='parent'
            query=[
                "manufacturerName" => ["in" => ["00-100-00000"]],
                "category" => "Calendars",
                "tags" => ["notIn" => ["Tented Desk Calendar"]]
            ]
        }

        {* With Custom Limit *}
        {include 'content:product-info' scope='parent' limit=6}

        {* With Debug Mode *}
        {include 'content:product-info' scope='parent' debug=1}

        {* Full Example with All Parameters *}
        {include 'content:product-info' scope='parent'
            query=[
                "manufacturerName" => ["in" => ["00-100-00000"]],
                "category" => "Calendars",
                "tags" => ["notIn" => ["Tented Desk Calendar"]]
            ]
            limit=4
            debug=1
        }
    {/literal}
        </pre>

    <h4>Available Parameters:</h4>
    <ul>
      <li><strong>query</strong>: Array of search criteria (optional, defaults to current company products)</li>
      <li><strong>limit</strong>: Number of products to return (optional, defaults to 4)</li>
      <li><strong>debug</strong>: Enable debug output (optional, defaults to 0)</li>
    </ul>
  </div>
{/if}

{* 
  - You can now use {$product_records.data} wherever needed.
  - Example of looping over products:

    {foreach $product_records.data as $product}
      <p>{$product.title}</p>
    {/foreach}
*}


{if $debug == 1}
  {$debug = 0}
{/if}