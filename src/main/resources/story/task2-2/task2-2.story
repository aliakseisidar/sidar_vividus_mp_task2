GivenStories: story/precondition/precondition.story

Scenario: 'First Sign In' scenario with email verification
Given I am on the main application page
When I click on element located `By.xpath(//a[text()="Log in"])`
When I enter `${email}` in field located `By.xpath(//*[@id="user"])`
When I wait until element located `By.xpath(//input[@value="Log in with Atlassian"])` appears
When I click on element located `By.xpath(//input[@value="Log in with Atlassian"])`
When I wait until element located `By.xpath(//h5[text()="Check your inbox to log in"])` appears
When I close the current window
When I switch to window with title that is equal to `Inbox`
!-- For-Each step for refreshing inbox
When I find = `1` elements `By.xpath(//iframe[@id="ifnoinb" and not(@state="hidden")])` and while they exist do up to 20 iteration of
|step|
|When I click on element located `By.xpath(//button[@id="refresh"])`|
!-- End of For-Each step
When I switch to frame located `By.xpath(//iframe[@id="ifmail"])`
When I click on element located `By.xpath(//a[text()="Verify your email"])`
When I switch to window with title that contains `Sign up`
When I enter `#{generate(regexify '[a-z]{5}[A-Z]{3}')}` in field located `By.xpath(//input[@id="password"])`
When I click on element located `By.xpath(//button[@id="signup-submit"])`
When I wait until the page has the title 'Boards | Trello'
When I wait until element located `By.xpath(//span[text()="Trello Workspace"])` appears

Scenario: Visual check for 'Boards | Trello' page
When I COMPARE_AGAINST baseline with `trello_boards_empty_page` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|1|

Scenario: Visual check for 'board_name | Trello' page
When I click on element located `By.xpath(//div[@class="board-tile mod-add"])`
When I wait until element located `By.xpath(//div[text()="Create board"]/../..)` appears
When I click on element located `By.xpath(//div[@id="background-picker"]//button[@title="Blue"])`
When I enter `${boardName}` in field located `By.xpath(//div[text()="Board title"]/following-sibling::input)`
When I wait until element located `By.xpath(//button[text()="Create" and not(@disabled)])` appears
When I click on element located `By.xpath(//button[text()="Create" and not(@disabled)])`
When I wait until the page has the title '${boardName} | Trello'
When I wait until element located `By.xpath(//div[@id="content"])` appears
!-- If-Like step for closing Slack banner
When I save number of elements located `By.xpath(//button[text()='Add to Slack'])` to scenario variable `numberOfElements`
And the condition '#{eval("${numberOfElements}"=="1")}' is true I do
|step|
|When I click on element located `By.xpath(//button[@aria-label="Close"])`|
|When I wait until element located `By.xpath(//button[text()='Add to Slack']/../../..)` disappears|
|When I click on element located `By.xpath(//h2[text()='To Do']/../..//span[text()='Add a card']/..)`|
!-- End of If-Like step
When I COMPARE_AGAINST baseline with `simple_board` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|
|1|

Scenario: Visual check for 'Profile | Trello' page
When I click on element located `By.xpath(//button[@aria-label="Open member menu"])`
When I wait until element located `By.xpath(//span[text()="Profile and visibility"]/..)` appears
When I click on element located `By.xpath(//span[text()="Profile and visibility"]/..)`
When I wait until element located `By.xpath(//main[@id="popover-boundary"])` appears
When I COMPARE_AGAINST baseline with `profile_page` ignoring:
|ACCEPTABLE_DIFF_PERCENTAGE|ELEMENT|
|1|By.xpath(//div[@class='tabbed-pane-header'])

Scenario: Visual check for 'Log out | Trello' page
When I click on element located `By.xpath(//button[@aria-label="Open member menu"])`
When I wait until element located `By.xpath(//*[text()="Log out"])` appears
When I click on element located `By.xpath(//*[text()="Log out"]/..)`
When I wait until element located `By.xpath(//*[@id="logout-submit"])` appears
When I COMPARE_AGAINST baseline with `logout_page` ignoring:
|ELEMENT|
|By.xpath(//div[contains(@class, 'account-entry')])

Scenario: Visual check for 'Logged out | Trello' page
When I click on element located `By.xpath(//*[@id="logout-submit"])`
When I wait until the page has the title 'Logged out of Trello'
When I COMPARE_AGAINST baseline with `logged_out_page`
