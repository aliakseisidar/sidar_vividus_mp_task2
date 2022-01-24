Scenario: Generation email
Given I am on a page with the URL 'https://yopmail.com/en/email-generator'
When I click on element located `By.xpath(//button[@onclick="newgen();"])`
When I change context to element located `By.xpath(//div[@id="egen"])`
When I save text of context element to story variable `email`
When I reset context
When I click on element located `By.xpath(//button[@onclick="egengo();"])`
When I wait until element located `By.xpath(//div[@id="wminboxmain"])` appears
When I open URL `https://trello.com/` in new window

Scenario: Sign up scenario
Given I am on the main application page
When I click on element located `By.xpath(//a[text()="Sign up"])`
When I enter `${email}` in field located `By.xpath(//*[@id="email"])`
When I click on element located `By.xpath(//*[@id="signup-submit"])`
When I wait until element located `By.xpath(//*[@id="displayName"])` appears
When I enter `${userName}` in field located `By.xpath(//*[@id="displayName"])`
When I click on element located `By.xpath(//*[@id="signup-submit"])`
When I wait until element located `By.xpath(//button[text()="Continue"])` appears
When I click on element located `By.xpath(//button[text()="Continue"])`
When I wait until element located `By.xpath(//button[text()="Take me to Trello"])` appears
When I click on element located `By.xpath(//button[text()="Take me to Trello"])`
When I wait until the page has the title 'Trello Workspace | Trello'
When I wait until element located `By.xpath(//span[text()="Trello Workspace"])` appears
When I click on element located `By.xpath(//*[@aria-label="Open member menu"])`
When I wait until element located `By.xpath(//*[text()="Log out"])` appears
When I click on element located `By.xpath(//*[text()="Log out"]/..)`
When I wait until element located `By.xpath(//*[@id="logout-submit"])` appears
When I click on element located `By.xpath(//*[@id="logout-submit"])`
