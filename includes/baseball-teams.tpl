{* --------------------------------------------------------------------------
   File: content:baseball-teams.tpl

   Description:
   - Fetches baseball teams from the supplement records.
   - Attempts to find the user’s preferred baseball team (if specified), 
     otherwise uses the user’s ZIP code to estimate the nearest teams by distance.
   - Includes optional debug output to review logic and data.

   Usage Example:
   {include 'content:baseball-teams' scope='parent'
       debug=1
       example=1
   }
   -------------------------------------------------------------------------- *}

{* ---------------- DEFAULTS & VARIABLES ---------------- *}
{assign var="defaultKey"           value='baseball-teams'}
{assign var="defaultQuery"         value=[]}
{assign var="defaultLimit"         value=100}
{assign var="defaultSort"          value=[]}
{assign var="defaultCacheMinutes"  value=0}
{assign var="forceZip"             value=$forceZip|default:0} {* 1 = force zip code to 64106 if no location data is found, 0 = use user's zip code *}
{assign var="debug"                value=$debug|default:0}   {* 1 = show debug info, 0 = hide *}

{* You can also expose these if you'd like to make them overrideable:
   {assign var="key"         value=$key|default:$defaultKey}
   {assign var="query"       value=$query|default:$defaultQuery}
   {assign var="limit"       value=$limit|default:$defaultLimit}
   {assign var="sort"        value=$sort|default:$defaultSort}
   {assign var="cacheMinutes" value=$cacheMinutes|default:$defaultCacheMinutes}
*}

{* ---------------- FETCH TEAM LIST ---------------- *}
{assign var="supplement_records" value=[
    'key'          => $key|default:$defaultKey,
    'query'        => $query|default:$defaultQuery,
    'limit'        => $limit|default:$defaultLimit,
    'sort'         => $sort|default:$defaultSort,
    'cacheMinutes' => $cacheMinutes|default:$defaultCacheMinutes
]}

{$teams = $utils->getSupplementRecords(
    $supplement_records.key,
    $supplement_records.query,
    $supplement_records.limit,
    $supplement_records.sort,
    $supplement_records.cacheMinutes
)}

{* ---------------- DETERMINE PREFERRED TEAM ---------------- *}
{* Grab the user's preferred baseball team from contact data *}
{assign var="preferredTeamId" value=$contact['preferred-baseball-team']}
{assign var="preferredTeam"   value=null}

{if $preferredTeamId}
  {* Search $teams for a match by ID *}
  {foreach from=$teams item=team}
    {if $team.id == $preferredTeamId}
      {assign var="preferredTeam" value=$team}
      {break}
    {/if}
  {/foreach}
{/if}

{* If no preferred team found, estimate nearest team by user’s ZIP code *}
{if !$preferredTeam}
  {* Try user’s zip-code first, else fallback to auto-locate ip data *}
  {assign var="userZip" value=$contact['zip-code']}
  {if !$userZip}
    {assign var="userZip" value=$contact['auto_locate_ip']['postal_code']}
    {if !$userZip && $forceZip == 1}
      {assign var="userZip" value='64106'}
    {/if}
  {/if}

  {* Prepare a temp array to store distance calculations *}
  {assign var="tempArray" value=[]}

  {* Iterate through each team to calculate the distance from userZip *}
  {foreach from=$teams item=team}
    {assign var="teamZip" value=$team['zipCode']}
    {assign var="distance" value=$utils->distanceBetweenPostalCodes($userZip, $teamZip, 'miles', 'US', 'US')}

    {* Skip if the distance comes back as 0 or invalid *}
    {if $distance == 0}
      {continue}
    {/if}

    {* Build a record with distance data for sorting *}
    {$tempArray[] = [
      'distance'              => $distance,
      'id'                    => $team.id,
      'sku'                   => $team.sku,
      'Name'                  => $team.Name,
      'category'              => $team.category,
      'teamUrl'               => $team.teamUrl,
      'ImagePath'             => $team.ImagePath,
      'Peel & Stick Magnets'  => $team['Peel & Stick Magnets'],
      'Standard Magnet Cards' => $team['Standard Magnet Cards'],
      'Mailer Magnet Cards'   => $team['Mailer Magnet Cards'],
      'Baseball Shape'        => $team['Baseball Shape'],
      'Jersey Shape'          => $team['Jersey Shape'],
      'Small Full Magnets'    => $team['Small Full Magnets'],
      'Standard Full Magnets' => $team['Standard Full Magnets'],
      '_geoloc'              => $team._geoloc,
      'zipCode'               => $team.zipCode,
      'updateContactAttribute' => "crdl-setAttribute-preferred-baseball-team='{$team.id}'"
    ]}
  {/foreach}

  {* Sort teams by ascending distance *}
  {$teams = $utils->sortArray($tempArray, 'distance', 'asc')}
{/if}

{* ---------------- OPTIONAL DEBUG OUTPUT ---------------- *}
{if $debug == 1}
  <div style="background: #F8D7DA; border: 1px solid #F5C6CB; padding: 15px; margin: 15px 0; border-radius: 4px; color: #DC3545;">
    <strong style="font-size: 16px;">Debug Mode Active</strong>
  </div>

  <h2 style="color: #DC3545; margin-bottom: 10px;">Baseball Teams Debug Info</h2>
  <pre style="background: #F8D7DA; padding: 15px; border-radius: 4px; border: 1px solid #F5C6CB; color: #333; font-family: monospace; overflow-wrap: break-word;">
    {$JSON_PRETTY_PRINT = 128}
    <strong>Preferred Team ID:</strong> {$preferredTeamId}
    <br />
    <strong>Preferred Team Object:</strong>
    {json_encode($preferredTeam, $JSON_PRETTY_PRINT)}

    <br /><br />
    <strong>Teams Array (After Distance Sorting If No Preferred):</strong>
    {json_encode($teams, $JSON_PRETTY_PRINT)}
  </pre>
{/if}

{* 
  At this point, you have access to:
    - $teams (either sorted by distance or the original array if a preferred team is found).
    - $preferredTeam (the user’s preferred team object, if found).
    - If $preferredTeam is null, the first item in $teams after sorting is presumably the nearest team.

  Use them as needed in your subsequent template logic:
  e.g. 
    {if $preferredTeam}
      <p>You prefer: {$preferredTeam.name}</p>
    {else}
      <p>Closest team is: {$teams[0].name}</p>
    {/if}
*}


{* ---------------- EXAMPLE USAGE OUTPUT (OPTIONAL) ---------------- *}
{if $example|default:0 == 1}
  <div style="background: #E2F0D9; border: 1px solid #A8D08D; padding: 15px; margin: 15px 0; border-radius: 4px; color: #548235;">
    <strong style="font-size: 16px;">Example Usage Instructions</strong>
  </div>

  <div style="padding: 20px; border-radius: 4px; border: 1px solid #A8D08D;">
    <h3>How to Include This Template:</h3>
    <pre style="background: #F5F5F5; padding: 15px; border-radius: 4px;">
{literal}
{* Basic Usage *}
{include 'content:baseball-teams' scope='parent'}

{* With Debug Mode *}
{include 'content:baseball-teams' scope='parent'
    debug=1
}

{* With Custom Supplement Data *}
{include 'content:baseball-teams' scope='parent'
    key='baseball-teams'
    query=['league' => 'NL']
    limit=50
    sort=['name' => 1]
    cacheMinutes=15
    debug=1
}
{/literal}
    </pre>
    
    <h4>Available Parameters:</h4>
    <ul>
      <li><strong>debug</strong>: Enable debug output (optional, defaults to 0).</li>
      <li><strong>key</strong>: Name of the supplement record to fetch (optional, defaults to "baseball-teams").</li>
      <li><strong>query</strong>: Filter for the supplement record (optional, defaults to empty array).</li>
      <li><strong>limit</strong>: Number of records to fetch (optional, defaults to 100).</li>
      <li><strong>sort</strong>: Sorting options for supplement records (optional, defaults to empty array).</li>
      <li><strong>cacheMinutes</strong>: Cache duration (optional, defaults to 0).</li>
      <li><strong>example</strong>: Toggle display of these usage instructions (optional, defaults to 0).</li>
    </ul>
  </div>
{/if}


{if $debug == 1}
    {$debug = 0}
{/if}