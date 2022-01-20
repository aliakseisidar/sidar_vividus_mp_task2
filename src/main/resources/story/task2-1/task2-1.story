Lifecycle:
Examples:
|Email |FullName |BoardName |
|#{generate(Internet.emailAddress)} |#{generate(Name.fullName)} |#{generate(regexify '[a-z]{5}[A-Z]{2}')} |
|#{generate(Internet.emailAddress)} |#{generate(Name.fullName)} |#{generate(regexify '[a-z]{5}[A-Z]{2}')} |

Scenario: Sign up scenario with example tables
Given I am on the main application page
When I save number of elements located `By.xpath(//a[text()='Sign up'])` to scenario variable `numberOfElements`
And the condition '#{eval("${numberOfElements}"=="0")}' is true I do
|step|
|When I click on element located `By.xpath(//*[@aria-label="Open member menu"])`|
|When I wait until element located `By.xpath(//*[text()="Log out"])` appears|
|When I click on element located `By.xpath(//*[text()="Log out"]/..)`|
|When I wait until element located `By.xpath(//*[@id="logout-submit"])` appears|
|When I click on element located `By.xpath(//*[@id="logout-submit"])`|
|Given I am on the main application page|
When I click on element located `By.xpath(//a[text()="Sign up"])`
When I enter `<Email>` in field located `By.xpath(//*[@id="email"])`
When I click on element located `By.xpath(//*[@id="signup-submit"])`
When I wait until element located `By.xpath(//*[@id="displayName"])` appears
When I enter `<FullName>` in field located `By.xpath(//*[@id="displayName"])`
When I click on element located `By.xpath(//*[@id="signup-submit"])`
When I wait until element located `By.xpath(//button[text()="Continue"])` appears
When I click on element located `By.xpath(//button[text()="Continue"])`
When I wait until element located `By.xpath(//button[text()="Take me to Trello"])` appears
When I click on element located `By.xpath(//button[text()="Take me to Trello"])`
When I wait until the page has the title 'Trello Workspace | Trello'
When I wait until element located `By.xpath(//span[text()="Trello Workspace"])` appears
Then the text 'Create your first board' exists

Scenario: Board creation
Given I am on a page with the URL 'https://trello.com/app-key'
When I click on element located `By.xpath(//*[@id="accept-developer-agreement"])`
When I click on element located `By.xpath(//button[text()="Show API Key"])`
When I save `value` attribute value of element located `By.xpath(//*[@id="key"])` to scenario variable `key`
When I click on element located `By.xpath(//a[text()="Token"])`
When I switch to window with title that is equal to `Authorize | Trello`
When I wait until element located `By.xpath(//input[@id="approveButton" and not(@disabled)])` appears
When I click on element located `By.xpath(//*[@id="approveButton"])`
When I wait until element located `By.xpath(//pre)` appears
When I change context to element located `By.xpath(//pre)`
When I save text of context element to scenario variable `token`
When I issue a HTTP POST request for a resource with the URL 'https://api.trello.com/1/boards/?name=<BoardName>&key=${key}&token=${token}'
Then `${responseCode}` is equal to `200`
Given I am on the main application page
Then the text '<BoardName>' exists
