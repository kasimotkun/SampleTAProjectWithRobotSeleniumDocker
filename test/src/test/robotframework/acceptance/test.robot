*** Settings ***
Documentation  A resource file containing the application specific keywords
Library		Selenium2Library	15	15
Test Teardown	Close all browsers

*** Variables ***
@{BROWSERS}          ff	 gc

*** Test Cases ***
Test Crossover Web Site
	:FOR  ${browser}  IN   @{BROWSERS}
		# Go to crossover.com web site
	\	Open Browser  https://www.crossover.com/  ${browser}  remoteUrl=http://192.168.99.102:4444/wd/hub
		# Crossover home page should open
	\	Element Should Be Visible  xpath=//div[@id="desktopNav"]/nav//div/ul/li[4]
		# Click on FOR CANDIDATES in order to go to available jobs page  
	\	Click Element  xpath=//div[@id="desktopNav"]/nav//div/ul/li[4]
		# Available Jobs link should be visible
	\	Element Should Be Visible  xpath=//a[@href="https://app.crossover.com/x/marketplace/available-jobs"]
		# Click available jobs link
	\	Click Element  xpath=//a[@href="https://app.crossover.com/x/marketplace/available-jobs"]
		# Default avaliable jobs page should open
	\	Element Should Be Visible  xpath=//input[@type='text']
		# Focus on the "Job title, keywords" field.
	\	Focus  xpath=//input[@type='text']
		# Type the text "Chief
	\	İnput Text  xpath=//input[@type='text']  Chief
		# Click on the "SEARCH JOBS" button
	\	Click Element  css=button.btn.btn-success
		# The search should display results containing the text "Chief" only
	\	Element Should Contain  xpath=//*[@id="available-jobs"]/div[3]/div/div/a[1]/div/div[1]		Chief
		# Click on the "RESET" button.
	\	Click Element  xpath=//button[@type='button']
		# Default available-jobs page should open.
	\	Element Should Not Contain  xpath=//div[@id="available-jobs"]/div[2]/form/div/div[1]/div/input		Chief
		# Click on "All Job Categories" drop-down box.
	\	Click Element  xpath=//span[text()="All Job Categories"]
		# Click on "Java" and verify that it gives the result as per search criteria
	\	Click Element 	xpath=//span[text()="Java"]
		# The search should display results containing the text "Java" only
	\	Element Should Contain  xpath=//div[contains(text(),'Java')]		Java
		# Click on the "RESET" button
	\	Click Element  xpath=//button[@type='button']
		# Default available-jobs page should open.
	\	Element Should Contain  css=span.ng-binding.ng-scope		All Job Categories
		# Click on "PEOPLE" and verify that it was navigated to Main page
	\	Click Element  css=span
		# Crossover home page should open
	\	Element Should Contain  xpath=//div[@id="desktopNav"]/nav/div/ul/li[4]/a/span		FOR CANDIDATES	
	\	Close Browser