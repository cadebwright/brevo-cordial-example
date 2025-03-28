{* --------------------------------------------------------------------------
   File: content:category-info.tpl

   Description:
   - Retrieves category data using $utils->getSupplementRecords().
   - Provides a debug section to display queries, limits, sorting options, cache minutes, 
     and the resulting category data.

   Usage Example:
   {include 'content:category-info' scope='parent'
       query=['status' => 'active'] 
       limit=25 
       sort=['name' => 1]
       cacheMinutes=10
       debug=1
   }
   -------------------------------------------------------------------------- *}

{* ---------------- DEFAULTS & VARIABLES ---------------- *}
{assign var="defaultQuery"       value=[]}
{assign var="defaultLimit"       value=50}
{assign var="defaultSort"        value=[]}
{assign var="defaultCacheMinutes" value=0}

{* Debug style defaults *}
{assign var="debug"             value=$debug|default:0}  {* 1 to enable debug, 0 to disable *}
{assign var="debugColor"        value="#DC3545"}
{assign var="debugBgColor"      value="#F8D7DA"}
{assign var="debugBorderColor"  value="#F5C6CB"}

{* ---------------- BUILD CATEGORY QUERY ---------------- *}
{assign var="supplement_records" value=[
    'key'          => 'categories',
    'query'        => $query|default:$defaultQuery,
    'limit'        => $limit|default:$defaultLimit,
    'sort'         => $sort|default:$defaultSort,
    'cacheMinutes' => $cacheMinutes|default:$defaultCacheMinutes
]}

{* ---------------- FETCH CATEGORY DATA ---------------- *}
{$supplement_records.data = $utils->getSupplementRecords(
    $supplement_records.key,
    $supplement_records.query,
    $supplement_records.limit,
    $supplement_records.sort,
    $supplement_records.cacheMinutes
)}

{* Transform array into an object indexed by category ID for easy lookup *}
{$supCategories = []}
{foreach $supplement_records.data as $category}
    {$supCategories[$category.id] = $category}
{/foreach}

{* --------------- OUTPUT PRODUCTS DATA TO VARIABLE --------------- *}
{assign var="categories" value=$supplement_records.data}

{* ---------------- OPTIONAL DEBUG OUTPUT ---------------- *}
{if $debug == 1}
  <div style="background: {$debugBgColor}; border: 1px solid {$debugBorderColor}; padding: 15px; margin: 15px 0; border-radius: 4px; color: {$debugColor};">
    <strong style="font-size: 16px;">Debug Mode Active</strong>
  </div>

  <h1 style="color: {$debugColor}; font-size: 24px; margin-bottom: 20px;">Category Data</h1>
  <pre style="background: {$debugBgColor}; padding: 20px; border-radius: 4px; border: 1px solid {$debugBorderColor}; color: #333; font-family: monospace;">
  {$JSON_PRETTY_PRINT = 128}
  <br />
  <span style="color: {$debugColor};">supplement_records.key:</span> {$supplement_records.key}<br />
  <span style="color: {$debugColor};">supplement_records.query:</span> {json_encode($supplement_records.query, $JSON_PRETTY_PRINT)}<br />
  <span style="color: {$debugColor};">supplement_records.limit:</span> {$supplement_records.limit}<br />
  <span style="color: {$debugColor};">supplement_records.sort:</span> {json_encode($supplement_records.sort, $JSON_PRETTY_PRINT)}<br />
  <span style="color: {$debugColor};">supplement_records.cacheMinutes:</span> {$supplement_records.cacheMinutes}<br />
  <br />
  {json_encode($supCategories, $JSON_PRETTY_PRINT)}
  </pre>
  <br><hr style="border: 0; border-top: 1px solid {$debugBorderColor}; margin: 30px 0;"><br>
{/if}

{* ---------------- EXAMPLE USAGE OUTPUT ---------------- *}
{if $example|default:0 == 1}
  <div style="background: #E2F0D9; border: 1px solid #A8D08D; padding: 15px; margin: 15px 0; border-radius: 4px; color: #548235;">
    <strong style="font-size: 16px;">Example Usage Instructions</strong>
  </div>

  <div style="padding: 20px; border-radius: 4px; border: 1px solid #A8D08D; margin-bottom: 30px;">
    <h3>How to Include This Template:</h3>
    <pre style="background: #F5F5F5; padding: 15px; border-radius: 4px;">
{literal}
{* Basic Usage *}
{include 'content:category-info' scope='parent'}

{* With Custom Query *}
{include 'content:category-info' scope='parent'
    query=['status' => 'active']
}

{* With Custom Limit *}
{include 'content:category-info' scope='parent' limit=25}

{* With Sort & Cache Minutes *}
{include 'content:category-info' scope='parent'
    sort=['name' => 1]
    cacheMinutes=60
}

{* With Debug Mode *}
{include 'content:category-info' scope='parent' debug=1}

{* Full Example with All Parameters *}
{include 'content:category-info' scope='parent'
    query=['status' => 'active']
    limit=50
    sort=['name' => 1]
    cacheMinutes=10
    debug=1
}
{/literal}
    </pre>
    
    <h4>Available Parameters:</h4>
    <ul>
      <li><strong>query</strong>: Array of search criteria (optional, defaults to empty array).</li>
      <li><strong>limit</strong>: Number of categories to return (optional, defaults to 50).</li>
      <li><strong>sort</strong>: Sorting options (optional, defaults to empty array).</li>
      <li><strong>cacheMinutes</strong>: Cache duration in minutes (optional, defaults to 0).</li>
      <li><strong>debug</strong>: Enable debug output (optional, defaults to 0).</li>
    </ul>
  </div>
{/if}

{* 
  - After including this file, you can use {$supCategories} or {$supplement_records.data} 
    anywhere in your template. For example:

    {foreach $supCategories as $categoryId => $category}
      <p>Category ID: {$categoryId}, Name: {$category.name}</p>
    {/foreach}
*}

{if $debug == 1}
  {$debug = 0}
{/if}
