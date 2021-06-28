# Mobile Demo

- [Inputs](#inputs)
  - [Auto Zoom](#auto-zoom)
  - [Input Modes](#input-modes)
- [Utilities](#utilities)
  - [Responsive Columns](#responsive-columns)
  - [Footer](#footer)
  - [Buttons](#buttons)
  - [Responsive Classes](#responsive-classes)
- [Reports](#reports)
  - [Links](#links)
  - [Line Clamp](#line-clamp)
  - [Cards](#cards)
  - [Split Reports](#split-reports)
  - [Refreshing Dual Reports](#refreshing-dual-reports)
- [Navigation](#navigation)
  - [Region Display Selector (RDS)](#region-display-selector-rds)
  - [Modal Title](#modal-title)
- [Other](#other)
  - [Plugins](#plugins)
  - [Image Resizing](#image-resizing)
  - [Case Insensitive Searching](#case-insensitive-searching)
  - [Testing Tools](#testing-tools)


Start by looking at the current app


## Inputs

### Auto Zoom


- iOS will auto zoom in for inputs if the app font size below 16px so that user's an see what they type


- Option: Disable auto zooming(_see notes below_):
```js
$('meta[name=viewport]').attr('content', 'width=device-width, user-scalable=no');
```


Note: Something to consider is that this is good for accessibility as disables zooming for the entire application.


### Input Modes

- When entering data on `input` fields that contain subtype information (numbers, email, phone) keyboard entry is "regular" keyboard and context is not observed despite defining the subtype in APEX.

- Show the Customer's page definition with no subtype definitions
- Now change the subtypes and demo the input
  - Phone
  - Email
  - Number
- Note the number field still doesn't work.

- Change the customer attributes to: 
  - `inputmode="numeric"`
  - then to
  - `inputmode="decimal"`

- Other input modes to be aware of so More info on [inputmode](https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/inputmode)
  - Some are inherited via the `type` attribute (APEX will apply this when subtype is defined). Others must be explicitly added (number).
- Testing: This is where constantly testing with a device beside you makes a big difference so you see the full experience





## Utilities


### Responsive Columns

- Go back to the User: Edit. In Desktop mode I have multiple columns. When on mobile I don't
  - Need to explicitly define column breakup on mobile

- [Grid layout](https://apex.oracle.com/pls/apex/apex_pm/r/ut/grid-layout). Need to explicitly define how it behaves on all the screen types you want to support.
  - In my case just used `col-xxs-` suffix. Could get more sophisticated as time goes for iPads, etc but kept it simple.
  - _I suggest supporting one "device" (i.e. small phone) to start rather than handling all screen sizes. Will get too confusing_


For each item add the following in Advanced > Layout Column CSS Classes:
- Use `col-xxs-8` and `col-xxs-4` for phone/pin
- Use `col-xxs-6` and `col-xxs-6` for address

Refresh the page on the phone and it will observe these column definitions;

Rotate the phone and see what happens


### Footer

- Want to have something "sticky" at the bottom. This is usually a button bar
  - Very useful on pages to save content
- In this demo will show how we use it for just info buttons
- Create Help and Cancel buttons (can be anything)
  - Prev / Next


### Buttons

Notice that Help takes up a lot of space

- Demo icon and icon mobile only: `fa-info-circle-o`


### Responsive Classes

Go to: [Responsive Utilities](https://apex.oracle.com/pls/apex/apex_pm/r/ut/responsive-utilities)

- Situation: I don't want icon to show up on desktop but to showup on mobile
- Solution (not pretty but works)
  - Remove the explicit icon and template option
  - `<span class="hidden-xxs-down">Help</span><span class="hidden-xs-up fa fa-info-circle-o"></span>`
  - Demo: Show desktop and also phone rotation


_more to demo_



## Reports


### Links


- Enter in user address and phone number:
  - `403-265-2622`
  - `401 9 Ave SW` 
    - `Calgary` 
    - `Alberta`
- Show in Report
  - If techs need to call they need to remember number to enter into phone or copy & paste into maps
- Phone:
  - Change to Link
  - `tel:#PHONE_NUMBER#`
- Maps:
  - Change to Link
  - iOS: `https://maps.apple.com/?q=#ADDRESS#`
  - Google Maps: `https://maps.google.com/?q=#ADDRESS#`
    
More info on [how to launch a map from mobile](https://support.prontoforms.com/hc/en-us/articles/217496598-How-To-Launch-a-Map-App-from-a-Mobile-Form)


### Line Clamp

- Problem: Long text doesn't look good on desktop or mobile, bad experience
- Lots of solution in the past. Most common in Oracle `substr...`
  - Has it's issues
- Solutions
  - SQL: Substring
    - Problem is that it will force cut then you need to put the logic to add ellipsis (`...`) in or not
    - Also what if you do a partial cut. Ex if you say 5 characters and you have a Locations data. What if you see "Green". Is it Greenland or Greenville? or just a place called "Green"?
  - PL/SQL: 
      - [`oos_util_string.truncate`](https://github.com/OraOpenSource/oos-utils/blob/master/docs/oos_util_string.md#truncate)
      - More than just a `substr...`. Can force cut or truncate to the nearest word but won't exceed number of charaters
      - Con: Not the most efficient since does a PL/SQL in an SQL statement. For large reports can slow down so either have a "short" column and precalulate it with a trigger, MV, etc?
- CSS [`line-clamp`](https://css-tricks.com/almanac/properties/l/line-clamp/) solves this problem.
  - Restricts based on number of lines and add ellipsis if more content.


```less
.line-clamp(@numRows){
  -webkit-line-clamp: @numRows;
  display: -webkit-box;
  overflow: hidden;
  -webkit-box-orient: vertical;
}

.demo-line-clamp-1{.line-clamp(1)}
.demo-line-clamp-2{.line-clamp(2)}
.demo-line-clamp-3{.line-clamp(3)}
.demo-line-clamp-4{.line-clamp(4)}
.demo-line-clamp-5{.line-clamp(5)}
```
  

### Cards

- Classic / IR reports doesn't look very good on mobile (seen me scrolling)
  - May also want to put different / more detailed information into the report

```sql
select 
    customer_id,
    full_name,
    email_address,
    phone_number,
    pin,
    nvl2(address_street,
        address_street || ', ' || address_city || ', ' || address_province,
        null
    ) address,
    address_street address_short
  from customers
order by full_name
```


- Duplicate to have a cards region
- Create cards and modify to have all the settings changed then show on mobile
  - Title: Name
  - Name Icons
  - Badges (just use ID for now)
  - Pagination: Page > 15
  - Actions: Edit
  - Buttons
    - `tel:&PHONE_NUMBER.`
      - Icon: `fa-phone`
    - `https://maps.apple.com/?q=&ADDRESS.`
      - Icon: `fa-map-marker`

### Split Reports


- Add the [responsive classes](https://apex.oracle.com/pls/apex/apex_pm/r/ut/responsive-utilities)
- Column Layout CSS:
- Classic Report: `hidden-xxs-down`
- Cards: `hidden-xs-up`

### Refreshing Dual Reports

- Add to each report:
  - Cards:
    - Static ID: `customers-cards`
    - Custom Attributes: `data-refresh-also="customers-report"`
  - Classic Report:
    - Static ID: `customers-report`
    - Custom Attributes: `data-refresh-also="customers-cards"`

- In a DA that already is triggered on `onClose Dialog` for `.t-Region, .t-CardsRegion`
  - Add: `Refresh` > `Triggering Element`
  - Add: `Refresh` > `Javascript Expression`:

```js
(function (pThis) {
    let refreshAlsoId = $(pThis.triggeringElement).attr('data-refresh-also');

    if (refreshAlsoId){
        return document.getElementById(refreshAlsoId);
    }
})(this)
```


## Navigation

### Region Display Selector (RDS)

- RDS issues:
  - isn't very user friendly. The arrow is extremely small to go left and right
  - It's not showing up all the time


- Setup:
  - Shared Components > User Interface > Navigation
  - Position: `Top`
  - List Template: `Mega Menu`
  - Template Options: `Display Menu Callout`


- RDS:
  - Welcome region: Move to Page Navigation


- RDS:
  - Add a new button called `RDS_MENU` in `Left of Title` with Icon: `fa-bars`
    - CSS Class: `js-menuButton hidden-xs-up`
    - Action: Defined by DA


- Create a  new DA: `onTabsRegionChange`
  - Type: `Custom`
  - Custom event: `tabsregionchange`
  - Region: `RDS`
  - Action:
    - Javascript: `daMenuForTabs(this);`
    - Affected Elements: `RDS_MENU`
    - Fire on Init: `Yes`


- Look at JS for this code

- Demo tab selection then rotate phone (same one is selected)


### Modal Title

- When tighter for space and using modal dialogs the title can be "wasted space". Can dynamically change with function:

```js
/**
 * Sets the title of the current modal from within itself (i.e. doesn't need to be called from calling page)
 * 
 * @function setModalDialogTitle
 * @example setModalDialogTitle(apex.item(this.affectedElements[0]).getValue());
 * @example setModalDialogTitle('My Title');
 **/
setModalDialogTitle = (modalTitle) => {
  // Can also use parent.jQuery(...) instead
  apex.util.getTopApex().jQuery('.ui-dialog-title').html(modalTitle);
}; // setModalDialogTitle
```

On the Customer Page add DA:
- onPageLoad
  - Action: JavaScript
    - Condition: `P3_FULL_NAME` is not null
    - JavaScript: 
```js
let pageItem = apex.item(this.affectedElements[0]);
setModalDialogTitle(pageItem.getValue());
// Hide the page item since moved to modal title
pageItem.hide();
```
    - Affected Element: `P3_FULL_NAME`


## Other

### Plugins

[FOS](https://www.foex.at/fos/) open source plugins from [FOEX](https://www.foex.at/). Lots of great (and supported) plugins that can add a lot of enhancement to mobile apps.


### Image Resizing

Store pictures in full size but display in small size. 

- [APEX Media Extension](https://www.apexmediaextension.com/index.html) regenerate images in PL/SQl
- [Imageresizer](https://imageresizer.io/) 3rd party site that can store or read from a cloud buck (Object Storage on OCI).
  - Used this as can do on the fly and all I needed to do was change the URL to change the image attributes



### Case Insensitive Searching

Not necessary mobile but users got frustrated pretty quick if they have to be concerned about case when searching
- Reference : [Case Insensitive Sorting in APEX | TalkApex](https://www.talkapex.com/2019/02/case-insensitive-sorting-in-apex/)



### Testing Tools

- Good for testing but I think using in real life gives you a different experience.
    - Too often we don't "eat our own dog food". For this app any free time I had I'd test on my device.
    - For example I'd be brushing my teeth an try it out. Why? Because I only had one hand free and was doing something else. Found so many inefficiences and user expereinces that weren't good in this situation. It's something you need to "feel" and can just sit on your big screen with mobile simulators
- Browsers have a device simulator (good but not perfect)
- iOS: Simulator on macOS
- Android: Adroid Studio:[Run apps on the Android Emulator  |  Android Developers](https://developer.android.com/studio/run/emulator)




-- TODO mdsouza: : other ideas:
- Show how when a tech starts I use card buttons to auto-populate what needs to be done so that they don't need to open, start time, close, end time, etc


todo: Show the button option to hide label with icon
- Alternative is to manually use classes 



-  Pictures: 
    - Problem: Want users to upload alot of pictures of their work. For upload ok with uploading full size but don't want to view full size by default as too much bandwidth/cost when using mobile network.
    - Solutions:
        - Reduce upload file: Didn't end up using this but still good to know that if you don't want large files in the first place can save mobile network charges:
	        - `Photo Library > Select Pictures > Click on "Show Selected" (bottom of screen) then click "Actual Size" and choose "Small"` along with a Max file size
            - Instead add a note in Block Dropzone with these instructions. Not perfect and didn't get a lot of success of users actually doing this (more of an annoyance)
            - Couldn't find a way to force downgrade of image.
            - Another option (didn't pursue) was to use JS to actually reduce the image quality in the browser before upload. It's possible I just didn't end up using
                - Ex: https://murb.medium.com/resizing-images-before-upload-1c832dec7fd5
        - Final solution was to upload full sized image then resize on view
            - Wanted simple solution for resizing so did the following (note: Not a good idea for sensitive material)
            - Uploads went directly to OCI storage bucket in a public storage container (we randomized file names ~256 random chars)
            - Linked 3rd party tool (Image resizer) to connect to the bucket
            - In APEX referenced imageResizer for all display images so it did the heavy lifting and I didn't need to worry about image transfirmation
            - Imageresizer can do a lot and also restrict referring domains
        - Other options
            - Don't need to use 3rd party external tool for senstive info. Lots of JS libraries out there that do this. Could use something like Oracle FN to manage conversion
		    - Use Oracle FN (not doing but suggestion) to resize on demand
		    - AME: [APEX Media Extension](https://www.apexmediaextension.com)
- Font Awesome:
    - Font APEX didn't have enough so wanted to use a 3rd party library.
    - Font Awesome is the industry standard
    - Note: This wasn't a smooth transition for the "integration" piece. Be very cautious if you want to do this as it's tough to go back
        - Not all the icons in FApex are interoperatible in FAwesome
    - APEX modifications
        - TODO: Show in APEX what I had to change from a Theme option
        - TODO: CSS that I had to modify or else things don't line up
    - Pros:
        - Can use built in CDN or multiple ways to self-host
            - I just CDN and 1 line of JS
        - Get so many icons
        - Can use different styles 
        - Lots more options (solid, regular, light, etc)
        - Layering (think putting the current date in the calendar)
            - Requires the SVG + JS version of Font Awesome.: Don't do it.
            - Couldn't get this to work (not sure why)
        - DON'T USE FA on the custom prefix Class use far, fas, fal, etc
    - Cons:
        - Icons don't line up as well as APEX does (i.e. slightly off in buttons, etc)
        - Lose ability to view all the icons (when selecting) in APEX as you must explicity list all the icons
            - You can do that but even then the field has a size restriction
            - Not really worth the fight so I just reference Font Awesome all the time to search and chose
    


- Time: 
    - Don't like scroll list
    - Use 24hr clock and popup LOV
    - -- TODO: mdsouza: better idea
    - Had to inject my own input type that I had to do (hoepfully we'll see it)





